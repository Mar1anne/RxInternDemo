//
//  PostsProvider.swift
//  InternDemo
//
//  Created by WF | Mariana on 11/30/16.
//  Copyright © 2016 WF | Mariana. All rights reserved.
//

import UIKit
import RxSwift

class PostsProvider: NSObject {

    private static let shared = PostsProvider()
    private let disposeBag = DisposeBag()
    
    class func postsForPage(_ page: Int, section: String) -> Observable<[Post]> {
        
        return Observable.create({ (observer) -> Disposable in
            
            NetworkDataSource.shared
                .request(request: .Posts(pageNumber: page, type: section))
                .throttle(1, scheduler: MainScheduler.instance)
                .flatMapLatest({ (response) -> Observable<[Post]> in
                    print(response ?? "")
                    
                    return Observable.just([Post]())
                    
                }).subscribe(onNext: { (posts) in
                    print(posts)
                    observer.onNext(posts)
                    observer.onCompleted()
                    
                }, onError: { error in
                    print(error)
                    observer.onError(error)
                    
                }, onCompleted: nil,
                   onDisposed: nil)
                .addDisposableTo(PostsProvider.shared.disposeBag)
            
            return Disposables.create()
        })
        

    }
}
