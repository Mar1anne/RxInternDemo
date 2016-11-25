//
//  ControllerManager.swift
//  InternDemo
//
//  Created by WF | Mariana on 11/24/16.
//  Copyright © 2016 WF | Mariana. All rights reserved.
//

import UIKit
import RxSwift
import DrawerController

class ControllerManager {

    static let sharedManager = ControllerManager()
    private let disposeBag = DisposeBag()
    
    init() {
        addUserObservable()
    }
    
    private func addUserObservable() {
        UserManager.sharedManager.currentUser
            .asObservable()
            .subscribe(onNext: { (user) in
                if user == nil {
                    self.setLoginRootController()
                } else {
                    self.setDrawerRootController()
                }
            }, onError: nil, onCompleted: nil, onDisposed: nil)
            .addDisposableTo(disposeBag)
    }
    
    private func setLoginRootController() {
        let loginController = LoginViewController()
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let window = appDelegate?.window
        
        window?.rootViewController = loginController
    }
    
    private func setDrawerRootController() {
        var drawerController: DrawerController!
        
        let centerViewController = PostsViewController()
        let leftViewController = MenuViewController()
        
        let mainNavigationController = UINavigationController(rootViewController: centerViewController)
        
        drawerController = DrawerController(centerViewController: mainNavigationController,
                                            leftDrawerViewController: leftViewController)
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let window = appDelegate?.window

        window?.rootViewController = drawerController
    }
}
