//
//  UIView+HelperMethods.swift
//  InternDemo
//
//  Created by WF | Mariana on 12/1/16.
//  Copyright © 2016 WF | Mariana. All rights reserved.
//

import UIKit
import SnapKit

private var loadingKey: UInt8 = 0
private var loadingViewKey: UInt8 = 1

extension UIView {
    var isLoading: Bool {
        get {
           return (objc_getAssociatedObject(self, &loadingKey) as? Bool) ?? false
        }
        set {
            objc_setAssociatedObject(self,
                                     &loadingKey,
                                     newValue,
                                     objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            updateLoadingState()
        }
    }
    
    private var loadingView: LoadingView? {
        get {
            return objc_getAssociatedObject(self, &loadingViewKey) as? LoadingView
        }
        
        set {
            objc_setAssociatedObject(self,
                                     &loadingViewKey,
                                     newValue,
                                     objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    private func updateLoadingState() {
        if isLoading && loadingView == nil {
            loadingView = LoadingView()
            loadingView?.backgroundColor = backgroundColor
            loadingView?.frame = bounds
            
            addSubview(loadingView!)
            bringSubview(toFront: loadingView!)
        } else if !isLoading {
            loadingView?.removeFromSuperview()
            loadingView = nil
        }
    }
}

private class LoadingView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        addLoadingIndicator()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addLoadingIndicator() {
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        indicator.startAnimating()
        
        addSubview(indicator)
        
        indicator.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self).offset(-32)
        }
    }
}
