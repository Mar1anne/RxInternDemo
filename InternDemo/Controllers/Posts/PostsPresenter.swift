//
//  PostsPresenter.swift
//  InternDemo
//
//  Created by WF | Mariana on 11/30/16.
//  Copyright © 2016 WF | Mariana. All rights reserved.
//

import UIKit
import RxSwift

enum PostsType: CustomStringConvertible {
    case MyPosts
    case HotPosts
    case PopularPosts
    
    var description: String {
        switch self {
        case .MyPosts:
            return "user"
        case .PopularPosts:
            return "top"
        default:
            return "hot"
        }
    }
}

protocol PostsView: class {
    func bindPosts(_ posts: Observable<[Post]>?)
    func showLoading(_ show: Bool)
}

protocol PostsPresenter: class {
    func attachView(_ view: PostsView)
    func detachView(_ view: PostsView)
    
    func loadPosts()
    func loadMorePosts()
}

class PostsPresenterImpl: PostsPresenter {

    private weak var view: PostsView?
    private var postsType: PostsType!
    private var postArray: Variable<[Post]>?
    private var posts: Observable<[Post]>?
    private var currentPage = 0
    private let disposeBag = DisposeBag()
    
    init(postsType: PostsType) {
        self.postsType = postsType
        self.postArray = Variable.init([Post]())
    }
    
    //MARK: PostsPresenter implementation
    func attachView(_ view: PostsView) {
        if self.view == nil {
            self.view = view
            self.view?.bindPosts(posts)
            
            self.observePosts()
            self.loadPosts()
        }
    }
    
    func detachView(_ view: PostsView) {
        if self.view === view {
            self.view = nil
        }
    }
    
    func observePosts() {
        posts = postArray?.asObservable()
        .map({ (posts) in
            return posts
        })
    }
    
    func loadPosts() {
        currentPage = 1
        view?.showLoading(true)
        
        PostsProvider.postsForPage(currentPage, section: postsType.description)
        .subscribe(onNext: { [weak self] (posts) in
            self?.view?.showLoading(false)
            self?.postArray?.value = posts
        }, onError: { error in
            
        }, onCompleted: nil,
           onDisposed: nil)
        .addDisposableTo(disposeBag)
    }
    
    func loadMorePosts() {
        currentPage += 1
        PostsProvider.postsForPage(currentPage, section: postsType.description)
            .subscribe(onNext: { [weak self] (posts) in
                self?.postArray?.value = posts
            }, onError: { error in
                
            }, onCompleted: nil, onDisposed: nil)
            .addDisposableTo(disposeBag)
    }
}
