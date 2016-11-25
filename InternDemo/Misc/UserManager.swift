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
    
    private var cachedUser: Variable<User?>!
    
    var currentUser: Variable<User?> {
        get {
            if cachedUser != nil && cachedUser.value == nil {
                cachedUser = getCurrentUser()
            }
            return cachedUser
        }
        set {
            setCurrentUser(user: newValue)
        }
    }
    
    private init() {
        cachedUser = getCurrentUser()
    }
    
    private func getCurrentUser() -> Variable<User?> {
        if let data = UserDefaults.standard.object(forKey: "currentUser") as? Data {
            if let user = NSKeyedUnarchiver.unarchiveObject(with: data) as? User {
                return Variable.init(user)
            }
        }
        
        return Variable.init(nil)
    }
    
    private func setCurrentUser(user: Variable<User?>) {
        cachedUser = user
        
        if let currentUser = user.value {
            let archivedObject = NSKeyedArchiver.archivedData(withRootObject: currentUser)
            UserDefaults.standard.set(archivedObject, forKey: "currentUser")
        } else {
            UserDefaults.standard.removeObject(forKey: "currentUser")
        }
    }
}
