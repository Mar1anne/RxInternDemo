//
//  UIImagePickerController+Rx.swift
//  InternDemo
//
//  Created by WF | Mariana on 12/5/16.
//  Copyright © 2016 WF | Mariana. All rights reserved.
//
import Foundation

#if os(iOS)
    import Foundation
    
#if !RX_NO_MODULE
    import RxSwift
    import RxCocoa
#endif
    import UIKit
    
    extension Reactive where Base: UIImagePickerController {
        
        /**
         Reactive wrapper for `delegate`.
         For more information take a look at `DelegateProxyType` protocol documentation.
         */
        public var delegate: DelegateProxy {
            return RxImagePickerDelegateProxy.proxyForObject(base)
        }
        
        /**
         Reactive wrapper for `delegate` message.
         */
        public var didFinishPickingMediaWithInfo: Observable<[String : AnyObject]> {
            return delegate
                .methodInvoked(#selector(UIImagePickerControllerDelegate.imagePickerController(_:didFinishPickingMediaWithInfo:)))
                .map({ (a) in
                    return try castOrThrow(Dictionary<String, AnyObject>.self, a[1])
                })
        }
        
        /**
         Reactive wrapper for `delegate` message.
         */
        public var didCancel: Observable<()> {
            return delegate
                .methodInvoked(#selector(UIImagePickerControllerDelegate.imagePickerControllerDidCancel(_:)))
                .map {_ in () }
        }
        
    }
    
#endif

fileprivate func castOrThrow<T>(_ resultType: T.Type, _ object: Any) throws -> T {
    guard let returnValue = object as? T else {
        throw RxCocoaError.castingError(object: object, targetType: resultType)
    }
    
    return returnValue
}
