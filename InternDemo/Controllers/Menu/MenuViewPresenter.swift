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
    func setMenuOptions(_ options: Observable<[String]>)
}

protocol MenuViewPresenter: class {
    func attachView(_ view: MenuView)
    func detachView(_ view: MenuView)
    
    func onMenuOptionSelected(atIndex index: Int)
}

class MenuViewPresenterImpl: NSObject, MenuViewPresenter {

    private weak var view: MenuView?
    private var menuOptions = Observable.just(["My Posts", "Popular posts", "Sync", "Logout"]) // TODO: Change them runtime if other options are needed or changed

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
    
    func onMenuOptionSelected(atIndex index: Int) {
        print(index)
    }
}
