//
//  UploadProgressWindow.swift
//  InternDemo
//
//  Created by WF | Mariana on 12/6/16.
//  Copyright © 2016 WF | Mariana. All rights reserved.
//

import UIKit
import RxSwift
import Alamofire

class UploadProgressWindow: UIWindow {

    private let uploadView = UploadProgressView(frame: CGRect.zero)
    private let notificationViewHeight: CGFloat = 64
    private let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        setupCustomWindow()
        setupNotificationView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View setup
    private func setupCustomWindow() {
        
        isUserInteractionEnabled = false
        windowLevel = UIWindowLevelStatusBar
    }
    
    private func setupNotificationView() {
        uploadView.frame = frameWithHeight(0)
        addSubview(uploadView)
    }
    
    //MARK: - Methods
    func showNotification(withProgress progress: Observable<Progress>) {
        
        setNotificationViewVisible(true)
        
        progress.subscribe(onNext: { (progressObject) in
            let progressPercent: Float = Float(progressObject.fractionCompleted) * 100
            print(progressPercent)
            self.uploadView.progressPercent = progressPercent
        }, onError: { (error) in
            self.hideNotification()
        }, onCompleted: {
            self.hideNotification()
        }, onDisposed: {
            self.hideNotification()
        })
        .addDisposableTo(disposeBag)
        
    }
    
    func hideNotification() {
        setNotificationViewVisible(false)
    }
    
    private func setNotificationViewVisible(_ visible: Bool) {
        
        UploadProgressView.cancelPreviousPerformRequests(withTarget: self,
                                                         selector: #selector(hideNotification),
                                                         object: nil)
        let nextFrame = visible ? frameWithHeight(notificationViewHeight) : frameWithHeight(0)
        
        uploadView.setNeedsLayout()
        uploadView.layoutIfNeeded()
        
        UIView.animate(withDuration: TimeInterval(0.3),
                       delay: 0,
                       options: .beginFromCurrentState,
                       animations: { [weak self] () -> Void in
                        
                        self?.uploadView.frame = nextFrame
                        self?.uploadView.layoutIfNeeded()
        })
    }
    
    //MARK: - Helper methods
    private func frameWithHeight(_ height: CGFloat) -> CGRect {
        return CGRect(x: 0, y: 0, width: frame.width, height: height)
    }

}
