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
import ObjectMapper

class TokenManager: NSObject {

    static let shared = TokenManager()
    
    private var cachedToken: Token?
    var accessToken: Token? {
        get {
            if (cachedToken == nil) {
                cachedToken = getAccessToken()
            }
            return cachedToken
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
            
            let data = Mapper<User>().map(JSON: jsonParams)
            if let user = data, let token = Token(JSON: jsonParams) {
                observer.onNext((user, token))
                observer.onCompleted()
            } else {
                let error = NSError(domain: "parse error", code: -50, userInfo: nil)
                observer.onError(error)
            }
            
            return Disposables.create()
        })
    }
    
    private func getAccessToken() -> Token? {
        let json = UserDefaults.standard.object(forKey: Network.Token.accessToken) as? String
        guard let _ = json else { return nil }
        return Token(JSONString: json!)
    }
    
    private func setAccessToken(_ token: Token?) {
        let json = token?.toJSONString(prettyPrint: true)
        UserDefaults.standard.set(json, forKey: Network.Token.accessToken)
        UserDefaults.standard.synchronize()
    }
    
}
