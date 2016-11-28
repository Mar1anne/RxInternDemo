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

    static let shared = NetworkDataSource()
    
    func request(request: APIRouter) -> Observable<AnyObject?> {
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
}
