//
//  PostCollectionViewCell.swift
//  InternDemo
//
//  Created by WF | Mariana on 11/30/16.
//  Copyright © 2016 WF | Mariana. All rights reserved.
//

import UIKit
import Haneke

class PostCollectionViewCell: UICollectionViewCell {
    
    private let postImageView = UIImageView()
    private let postDescriptionLabel = UILabel()
    
    var post: Post? {
        didSet {
            updateViewForPost(post: post)
        }
    }
    
    static var cellIdentifier: String {
        return NSStringFromClass(self) + ".identifier"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: View setup
    private func setupView() {
        backgroundColor = UIColor(colorLiteralRed: 236/255, green: 240/255, blue: 241/255, alpha: 1)
        
        postDescriptionLabel.numberOfLines = 0
        postDescriptionLabel.font = UIFont.gothicRegularFontOfSize(size: 15)
        
        postImageView.contentMode = .scaleAspectFill
        postImageView.backgroundColor = .white
        postImageView.frame = CGRect(x: 5, y: 5, width: 100, height: 100)
        postImageView.clipsToBounds = true
        
        addSubview(postImageView)
        addSubview(postDescriptionLabel)
    }
    
    private func setupConstraints() {
        postImageView.snp.makeConstraints { (make) in
            make.top.left.equalTo(self).offset(5)
            make.width.height.equalTo(self.snp.width).offset(-10)
        }
        
        postDescriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(postImageView.snp.bottom).offset(5)
            make.left.equalTo(self).offset(5)
            make.right.bottom.equalTo(self).offset(-5)
        }
    }
    
    private func updateViewForPost(post: Post?) {
        postDescriptionLabel.text = post?.postDescription
        guard let url = URL(string: post?.link ?? "") else { return }
        
        postImageView.hnk_setImageFromURL(url,
                                          placeholder: UIImage(named: "bubbles"),
                                          format: nil,
                                          failure: nil,
                                          success: nil)
    }
    
}
