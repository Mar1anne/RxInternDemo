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
    static let sharedManager = UserManager()
    
    var currentUser: Variable<User?> {
        get {
            return getCurrentUser()
        }
        set {
            setCurrentUser(user: currentUser)
        }
    }
    
    private init() {
        
    }
    
    private func getCurrentUser() -> Variable<User?> {
        if let object = UserDefaults.standard.object(forKey: "currentUser") as? User {
            return Variable.init(object)
        }
        return Variable.init(nil)
    }
    
    private func setCurrentUser(user: Variable<User?>) {
        if let currentUser = user.value {
            UserDefaults.standard.set(currentUser, forKey: "currentUser")
        } else {
            UserDefaults.standard.removeObject(forKey: "currentUser")
        }
    }
}
