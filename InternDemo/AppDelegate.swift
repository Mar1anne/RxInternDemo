//
//  AppDelegate.swift
//  InternDemo
//
//  Created by WF | Mariana on 11/21/16.
//  Copyright © 2016 WF | Mariana. All rights reserved.
//

import UIKit
import DrawerController

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var drawerController: DrawerController!
    
    func application(_ application: UIApplication,
                     willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        
        let screenSize = UIScreen.main.bounds.size
        window = UIWindow(frame: CGRect(origin: CGPoint.zero, size: screenSize))
        
        _ = UserManager.sharedManager
        
//        setupWindowAndRootController()
        return true
    }
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window?.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) { }

    func applicationDidEnterBackground(_ application: UIApplication) { }

    func applicationWillEnterForeground(_ application: UIApplication) { }

    func applicationDidBecomeActive(_ application: UIApplication) { }

    func applicationWillTerminate(_ application: UIApplication) { }
    
    func setupWindowAndRootController() {
        
        
        let centerViewController = PostsViewController()
        let leftViewController = MenuViewController()
        
        let mainNavigationController = UINavigationController(rootViewController: centerViewController)
        
        drawerController = DrawerController(centerViewController: mainNavigationController,
                                            leftDrawerViewController: leftViewController)
        
        window?.rootViewController = drawerController
    }

}

