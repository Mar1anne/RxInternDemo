//
//  PostsProvider.swift
//  InternDemo
//
//  Created by WF | Mariana on 11/30/16.
//  Copyright © 2016 WF | Mariana. All rights reserved.
//

import UIKit
import RxSwift
import ObjectMapper

class PostsProvider: NSObject {

    private static let shared = PostsProvider()
    private let disposeBag = DisposeBag()
    
    class func postsForPage(_ page: Int, section: String) -> Observable<[Post]> {
        
        return Observable.create({ (observer) -> Disposable in
            
            NetworkDataSource
                .request(request: .Posts(pageNumber: page, type: section))
                .flatMap({ (response) -> Observable<[Post]> in
                    var posts: [Post]?
                    if let result = response as? [String: AnyObject] {
                        if let data = result["data"] as? [[String: Any]] {
                            posts = Array<Post>(JSONArray: data)?.filter({ $0.isAlbum == false })
                        }
                    }
                    return Observable.just(posts ?? [Post]())
                })
                .subscribe(onNext: { (posts) in
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
    
    class func uploadImage(_ image: UIImage) -> Observable<Bool> {
        return Observable.create({ (subscriber) -> Disposable in
            
            
            
            return Disposables.create()
        })
    }
}
