//
//  UploadProgressView.swift
//  InternDemo
//
//  Created by WF | Mariana on 12/6/16.
//  Copyright © 2016 WF | Mariana. All rights reserved.
//

import UIKit

class UploadProgressView: UIView {

    private let progressView = UIProgressView(progressViewStyle: UIProgressViewStyle.bar)
    private let percentLabel = UILabel()
    
    var progressPercent: Float = 0 {
        didSet {
            progressView.setProgress(progressPercent, animated: true)
            percentLabel.text = "\(Int(floor(progressPercent)))%"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - View setup
    private func setupViews() {
        backgroundColor = .white
        
        progressView.backgroundColor = .gray
        progressView.tintColor = .blue
        
        percentLabel.font = UIFont.gothicRegularFontOfSize(size: 15)
        percentLabel.textColor = .black
        percentLabel.setContentCompressionResistancePriority(1000, for: .horizontal)
        percentLabel.setContentCompressionResistancePriority(1000, for: .vertical)
        
        addSubview(progressView)
        addSubview(percentLabel)
    }
    
    private func setupConstraints() {
        progressView.snp.makeConstraints { (make) in
            make.center.equalTo(self)
            make.left.equalTo(self).offset(15)
            make.right.equalTo(percentLabel.snp.left).offset(-15)
        }
        
        percentLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.width.equalTo(40)
            make.right.equalTo(self).offset(-15)
        }
    }
}
