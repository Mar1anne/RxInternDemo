//
//  TokenManager.swift
//  InternDemo
//
//  Created by WF | Mariana on 11/28/16.
//  Copyright © 2016 WF | Mariana. All rights reserved.
//

import UIKit
import Alamofire
import RxSwift

class TokenManager: NSObject {

    static let shared = TokenManager()
    
    var accessToken: String?

    func parseParameters(parameters: [String]) -> Observable<(User, Token)> {
        return Observable.create({ (observer) -> Disposable in
        
            var jsonParams = [String: AnyObject]()
            for itemString in parameters {
                let paramString = itemString.components(separatedBy: "=")
                jsonParams[paramString[0]] = paramString[1] as AnyObject
            }
            
            if let user = User(JSON: jsonParams), let token = Token(JSON: jsonParams) {
                observer.onNext((user, token))
                observer.onCompleted()
            } else {
                let error = NSError(domain: "parse error", code: -50, userInfo: nil)
                observer.onError(error)
            }
            
            return Disposables.create()
        })
    }
}
