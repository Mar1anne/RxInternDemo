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
            return "My Posts"
        case .PopularPosts:
            return "Popular Posts"
        default:
            return "Hot Posts"
        }
    }
    
    var networkParameter: String {
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
    func titleUpdated(_ title: String)
}

protocol PostsPresenter: class {
    func attachView(_ view: PostsView)
    func detachView(_ view: PostsView)
    
    func loadPosts()
    func loadMorePosts()
}

class PostsPresenterImpl: PostsPresenter {

    private weak var view: PostsView?
    private var postArray: Variable<[Post]>?
    private var posts: Observable<[Post]>?
    private var currentPage = 0
    private let disposeBag = DisposeBag()
    private var postsType: PostsType! {
        didSet {
            view?.titleUpdated(postsType.description)
        }
    }

    init(postsType: PostsType) {
        self.postsType = postsType
        self.postArray = Variable.init([Post]())
    }
    
    //MARK: PostsPresenter implementation
    func attachView(_ view: PostsView) {
        if self.view == nil {
            self.view = view
            
            self.observePosts()
            self.view?.showLoading(true)
            self.loadPosts()
            self.view?.titleUpdated(postsType.description)
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
        
        self.view?.bindPosts(posts)
    }
    
    func loadPosts() {
        currentPage = 1
        
        PostsProvider.postsForPage(currentPage, section: postsType.networkParameter)
        .subscribe(onNext: { [weak self] (posts) in
            self?.postArray?.value = posts
        }, onError: { [weak self] error in
            self?.view?.showLoading(false)
        }, onCompleted: { [weak self] in
            self?.view?.showLoading(false)
        }, onDisposed: nil)
        .addDisposableTo(disposeBag)
    }
    
    func loadMorePosts() {
        currentPage += 1
        PostsProvider.postsForPage(currentPage, section: postsType.networkParameter)
            .subscribe(onNext: { [weak self] (posts) in
                self?.postArray?.value.append(contentsOf: posts)
            }, onError: { [weak self] (error) in
                self?.currentPage -= 1
                self?.view?.showLoading(false)
            }, onCompleted: { [weak self] in
                self?.view?.showLoading(false)
            }, onDisposed: nil)
            .addDisposableTo(disposeBag)
    }
}
