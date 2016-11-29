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
        var currentUser: User?
        
        if let data = UserDefaults.standard.object(forKey: "currentUser") as? Data {
            if let user = NSKeyedUnarchiver.unarchiveObject(with: data) as? User {
                currentUser = user
            }
        }
        return currentUser
    }
    
    private func setCurrentUser(user: User?) {
        variableUser.value = user
        
        if let currentUser = user {
            let archivedObject = NSKeyedArchiver.archivedData(withRootObject: currentUser)
            UserDefaults.standard.set(archivedObject, forKey: "currentUser")
        } else {
            UserDefaults.standard.removeObject(forKey: "currentUser")
        }
    }
}
