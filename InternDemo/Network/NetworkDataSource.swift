//
//  NetworkDataSource.swift
//  InternDemo
//
//  Created by WF | Mariana on 11/28/16.
//  Copyright © 2016 WF | Mariana. All rights reserved.
//

import UIKit
import Alamofire
import RxSwift

class NetworkDataSource: NSObject {

    static func request(request: APIRouter) -> Observable<AnyObject?> {
        return TokenProvider.getToken()
            .flatMap({ (token) -> Observable<AnyObject?> in
                print("token: \(token.accessToken)")
                return NetworkDataSource.sendRequest(request: request)
            })
    }
    
    static func upload(to request: APIRouter, image: UIImage) -> Observable<Progress> {
        return TokenProvider.getToken()
            .flatMap({ (token) -> Observable<Progress> in
                return NetworkDataSource.upload(request, image: image)
            })
    }
 
    private static func sendRequest(request: APIRouter) -> Observable<AnyObject?> {
        return Observable.create({ (observer) -> Disposable in
            
            Alamofire
                .request(request)
                .validate()
                .responseJSON(completionHandler: { (response) in
                    
                    switch response.result {
                    case .success(let JSON):
                        observer.onNext(JSON as AnyObject)
                        observer.onCompleted()
                        
                    case .failure(let error):
                        observer.onError(error)
                    }
                })
            
            return Disposables.create()
        })
    }
    
    private static func upload(_ request: APIRouter, image: UIImage) -> Observable<Progress> {
        return Observable.create({ (subscriber) -> Disposable in
            
            Alamofire.upload(multipartFormData: { (multipartFormData) in
                multipartFormData.append(image.asData(), withName: "image")
                multipartFormData.append("title_example".asData(), withName: "title")
                
            }, with: request,
               encodingCompletion: { (encodingResult) in
                switch encodingResult {
                case .success(let request, _, _):
                    
                    _ = request.uploadProgress(closure: { (progress) in
                        OperationQueue.main.addOperation({
//                            let percentProgress = progress.fractionCompleted * 100
//                            print(percentProgress)
                            subscriber.onNext(progress)
//                            print("progress: ", progress.localizedDescription)
                        })
                    })
                    
                    request.response(completionHandler: { (response) in
                        print("Completion: \(response)")
                        subscriber.onCompleted()
                    })
                    
                case .failure(let error):
                    subscriber.onError(error)
                }
            })
            
            return Disposables.create()
        })
        
    }
}
