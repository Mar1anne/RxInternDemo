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
    
    private var cachedToken: String?
    var accessToken: String? {
        get {
            return cachedToken ?? getAccessToken()
        }
        set {
            cachedToken = newValue
            setAccessToken(newValue)
        }
    }

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
    
    private func getAccessToken() -> String? {
        return UserDefaults.standard.object(forKey: Network.Token.accessToken) as? String
    }
    
    private func setAccessToken(_ token: String?) {
        guard let _ = token else { return }
        
        UserDefaults.standard.set(token, forKey: Network.Token.accessToken)
        UserDefaults.standard.synchronize()
    }
}
