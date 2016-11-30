//
//  MenuViewPresenter.swift
//  InternDemo
//
//  Created by WF | Mariana on 11/29/16.
//  Copyright © 2016 WF | Mariana. All rights reserved.
//

import UIKit
import RxSwift

protocol MenuView: class {
    func setMenuOptions(_ options: Observable<[MenuItem]>)
}

protocol MenuViewPresenter: class {
    func attachView(_ view: MenuView)
    func detachView(_ view: MenuView)
    
    func onMenuOptionSelected(_ menuItem: MenuItem)
}

class MenuViewPresenterImpl: NSObject, MenuViewPresenter {

    private weak var view: MenuView?
    private var menuOptions = Observable.just([MenuItem(type: MenuItemType.MyPosts),
                                               MenuItem(type: MenuItemType.PopularPosts),
                                               MenuItem(type: MenuItemType.Settings)]) // TODO: Change them runtime if other options are needed or changed

    func attachView(_ view: MenuView) {
        if self.view == nil {
            self.view = view
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
        print(menuItem.description)
    }
    
}
