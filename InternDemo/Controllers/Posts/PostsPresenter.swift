//
//  PostsPresenter.swift
//  InternDemo
//
//  Created by WF | Mariana on 11/30/16.
//  Copyright © 2016 WF | Mariana. All rights reserved.
//

import UIKit

enum PostsType {
    case MyPosts
    case HotPosts
    case PopularPosts
}

protocol PostsView: class {
    
}

protocol PostsPresenter: class {
    func attachView(_ view: PostsView)
    func detachView(_ view: PostsView)
}

class PostsPresenterImpl: PostsPresenter {

    private weak var view: PostsView?
    private var postsType: PostsType!
    
    init(postsType: PostsType) {
        self.postsType = postsType
    }
    
    //MARK: PostsPresenter implementation
    func attachView(_ view: PostsView) {
        if self.view == nil {
            self.view = view
        }
    }
    
    func detachView(_ view: PostsView) {
        if self.view === view {
            self.view = nil
        }
    }

}
