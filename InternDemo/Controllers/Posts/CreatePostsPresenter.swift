//
//  CreatePostsPresenter.swift
//  InternDemo
//
//  Created by WF | Mariana on 12/5/16.
//  Copyright © 2016 WF | Mariana. All rights reserved.
//

import UIKit
import RxSwift

protocol CreatePostsView: class {
    func close()
}

protocol CreatePostsPresenter: class {
    func attachView(_ view: CreatePostsView)
    func detachView(_ view: CreatePostsView)
    
    func uploadImage(_ image: UIImage)
}

class CreatePostsPresenterImpl: CreatePostsPresenter {
    private weak var view: CreatePostsView?
    private let disposeBag = DisposeBag()
    
    //MARK: CreatePostsPresenter
    func attachView(_ view: CreatePostsView) {
        if self.view == nil {
            self.view = view
        }
    }
    
    func detachView(_ view: CreatePostsView) {
        if self.view === view {
            self.view = nil
        }
    }
    
    func uploadImage(_ image: UIImage) {
        
        let base64ImageData = image.toBase64()
        let parameters = ["image": base64ImageData]
        
        self.view?.close()
        
        NetworkDataSource.request(request: .UploadImage(parameters))
            .subscribe(onNext: { (response) in
                print(response ?? "no response")
            }, onError: { (error) in
                print(error)
            }, onCompleted: nil, onDisposed: nil)
            .addDisposableTo(disposeBag)
    }
}
