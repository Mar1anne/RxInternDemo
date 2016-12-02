//
//  TokenProvider.swift
//  InternDemo
//
//  Created by WF | Mariana on 12/2/16.
//  Copyright © 2016 WF | Mariana. All rights reserved.
//

import UIKit
import RxSwift
import Alamofire
import ObjectMapper
import RxOptional

class TokenProvider: NSObject {
    
    private static let shared = TokenProvider()
    private let disposeBag = DisposeBag()
    
    static func getToken() -> Observable<Token> {
        return refreshToken()
            .flatMap { (response) -> Observable<Token?> in
                return parseToken(withJSON: response)
            }
            .do(onNext: { (token) in
                TokenManager.shared.accessToken = token
            })
            .errorOnNil()
    }
    
    private static func refreshToken() -> Observable<Any?> {
        
        return Observable.create({ (observer) -> Disposable in
            
            if let token = TokenManager.shared.accessToken {
                if token.isValid {
                    observer.onNext(token.toJSON())
                    observer.onCompleted()
                } else {
                    let parameters = ["refresh_token": token.refreshToken,
                                      "client_secret": ConfigurationsManager.shared.imgurClientSecret,
                                      "client_id": ConfigurationsManager.shared.imgurClientId,
                                      "grant_type": "access_token"]
                    
                    Alamofire
                        .request(APIRouter.RefreshToken(parameters))
                        .validate()
                        .responseJSON(completionHandler: { (response) in
                            
                            switch response.result {
                            case .success(let JSON):
                                observer.onNext(JSON)
                                observer.onCompleted()
                                
                            case .failure(let error):
                                observer.onError(error)
                            }
                        })
                }
            } else {
                let error = NSError(domain: "No initial token", code: -5050, userInfo: nil)
                observer.onError(error)
            }
            
            return Disposables.create()
        })
    }
    
    private static func parseToken(withJSON json: Any?) -> Observable<Token?> {
        return Observable.create({ (observer) -> Disposable in
            
            if let jsonParams = json as? [String: AnyObject] {
                observer.onNext(Mapper<Token>().map(JSON: jsonParams))
                observer.onCompleted()
            } else {
                let error = NSError(domain: "parse error", code: -50, userInfo: nil)
                observer.onError(error)
            }
            
            return Disposables.create()
        })
    }
}
