//
//  RxImagePickerDelegateProxy.swift
//  InternDemo
//
//  Created by WF | Mariana on 12/5/16.
//  Copyright © 2016 WF | Mariana. All rights reserved.
//

#if os(iOS)
    
    import Foundation
#if !RX_NO_MODULE
    import RxSwift
    import RxCocoa
#endif
    import UIKit
    
    public class RxImagePickerDelegateProxy
        : DelegateProxy
        , DelegateProxyType
        , UIImagePickerControllerDelegate
    , UINavigationControllerDelegate {
        
        /**
         For more information take a look at `DelegateProxyType`.
         */
        public class func setCurrentDelegate(_ delegate: AnyObject?, toObject object: AnyObject) {
            let imagePickerController: UIImagePickerController = castOrFatalError(object)
            imagePickerController.delegate = castOptionalOrFatalError(delegate)
        }
        
        /**
         For more information take a look at `DelegateProxyType`.
         */
        public class func currentDelegateFor(_ object: AnyObject) -> AnyObject? {
            let imagePickerController: UIImagePickerController = castOrFatalError(object)
            return imagePickerController.delegate
        }
        
    }
    
    private func castOrFatalError<T>(_ value: Any!) -> T {
        let maybeResult: T? = value as? T
        guard let result = maybeResult else {
            rxFatalError("Failure converting from \(value) to \(T.self)")
        }
        
        return result
    }
    
    private func castOptionalOrFatalError<T>(_ value: AnyObject?) -> T? {
        if value == nil {
            return nil
        }
        let v: T = castOrFatalError(value)
        return v
    }
    
    private func rxFatalError(_ lastMessage: String) -> Never {
        // The temptation to comment this line is great, but please don't, it's for your own good. The choice is yours.
        fatalError(lastMessage)
    }
    
#endif
