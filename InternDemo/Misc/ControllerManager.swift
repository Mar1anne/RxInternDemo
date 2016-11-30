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

    static let shared = ControllerManager()
    private let disposeBag = DisposeBag()
    
    init() {
        addUserObservable()
    }
    
    private func addUserObservable() {
        UserManager.shared.observableUser.subscribe(onNext: { (user) in
            if user == nil {
                self.setLoginRootController()
            } else {
                self.setDrawerRootController()
            }

        }, onError: nil, onCompleted: nil, onDisposed: nil)
        .addDisposableTo(disposeBag)
    }
    
    private func setLoginRootController() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let window = appDelegate?.window
        
        if window?.rootViewController?.isKind(of: LoginViewController.self) ?? false {
            return
        }
        
        let loginController = LoginViewController()
        window?.rootViewController = loginController
    }
    
    private func setDrawerRootController() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let window = appDelegate?.window
        
        if window?.rootViewController?.isKind(of: DrawerController.self) ?? false {
            return
        }
        
        var drawerController: DrawerController!
        
        let centerViewController = PostsViewController(withPresenter: PostsPresenterImpl(postsType: .HotPosts))
        let leftViewController = MenuViewController(withPresenter: MenuViewPresenterImpl())
        
        let mainNavigationController = UINavigationController(rootViewController: centerViewController)
        
        drawerController = DrawerController(centerViewController: mainNavigationController,
                                            leftDrawerViewController: leftViewController)

        window?.rootViewController = drawerController
    }
    
}
