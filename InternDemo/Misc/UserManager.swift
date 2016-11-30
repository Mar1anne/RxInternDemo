//
//  UserManager.swift
//  InternDemo
//
//  Created by WF | Mariana on 11/24/16.
//  Copyright © 2016 WF | Mariana. All rights reserved.
//

import UIKit
import RxSwift

class UserManager {
    
    static let shared = UserManager()

    private var variableUser: Variable<User?>!
    var observableUser: Observable<User?>!
    
    var currentUser: User? {
        get {
            return variableUser.value
        }
        set {
            setCurrentUser(user: newValue)
        }
    }
    
    private init() {
        variableUser = Variable.init(getCurrentUser())
        
        observableUser = variableUser.asObservable()
        .map({ (user) in
            return user
        })
    }
    
    private func getCurrentUser() -> User? {        
        if let json = UserDefaults.standard.object(forKey: "current_user") as? String {
            return User(JSONString: json)
        }
        return nil
    }
    
    private func setCurrentUser(user: User?) {
        variableUser.value = user
        
        let json = user?.toJSONString(prettyPrint: true)
        UserDefaults.standard.set(json, forKey: "current_user")
        UserDefaults.standard.synchronize()
    }
    
}
