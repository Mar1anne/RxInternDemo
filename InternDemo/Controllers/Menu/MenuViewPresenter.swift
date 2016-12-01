//
//  MenuViewPresenter.swift
//  InternDemo
//
//  Created by WF | Mariana on 11/29/16.
//  Copyright © 2016 WF | Mariana. All rights reserved.
//

import UIKit
import RxSwift
import DrawerController

protocol MenuView: class {
    func setMenuOptions(_ options: Observable<[MenuItem]>)
    func showController(_ controller: BaseViewController)
}

protocol MenuViewPresenter: class {
    
    func attachView(_ view: MenuView)
    func detachView(_ view: MenuView)
    
    func onMenuOptionSelected(_ menuItem: MenuItem)
}

class MenuViewPresenterImpl: NSObject, MenuViewPresenter {

    private weak var view: MenuView?
    private var allMenuOptions: Variable<[MenuItem]> = Variable.init([MenuItem]())
    private var menuOptions: Observable<[MenuItem]>!

    override init() {
        super.init()
        
        menuOptions = allMenuOptions.asObservable().map({ (item) in
            return item
        })
    }
    
    func attachView(_ view: MenuView) {
        if self.view == nil {
            self.view = view
            
            self.updateMenu(forCurrentSelection: MenuItem(type: .HotPosts))
            self.view?.setMenuOptions(menuOptions)
        }
    }
    
    func detachView(_ view: MenuView) {
        guard let _ = self.view else { return }
        
        if self.view! === view {
            self.view = nil
        }
    }
    
    func onMenuOptionSelected(_ menuItem: MenuItem) {
        var centerController: BaseViewController
        
        switch menuItem.type {
        case .MyPosts:
            centerController = PostsViewController(withPresenter: PostsPresenterImpl(postsType: .MyPosts))
        case .HotPosts:
            centerController = PostsViewController(withPresenter: PostsPresenterImpl(postsType: .HotPosts))
        case .PopularPosts:
            centerController = PostsViewController(withPresenter: PostsPresenterImpl(postsType: .PopularPosts))
        case .Settings:
            centerController = SettingsViewController()
        }
        
        updateMenu(forCurrentSelection: menuItem)
        view?.showController(centerController)
    }
    
    private func updateMenu(forCurrentSelection selectedItem: MenuItem) {
        let allOptions = [MenuItem(type: MenuItemType.HotPosts),
                          MenuItem(type: MenuItemType.MyPosts),
                          MenuItem(type: MenuItemType.PopularPosts),
                          MenuItem(type: MenuItemType.Settings)]
        allMenuOptions.value = allOptions.filter({ $0.type != selectedItem.type })
    }
}
