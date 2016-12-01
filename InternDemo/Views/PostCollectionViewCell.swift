//
//  PostCollectionViewCell.swift
//  InternDemo
//
//  Created by WF | Mariana on 11/30/16.
//  Copyright © 2016 WF | Mariana. All rights reserved.
//

import UIKit

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
        
        postImageView.contentMode = .scaleAspectFill
        
        addSubview(postImageView)
        addSubview(postDescriptionLabel)
    }
    
    private func setupConstraints() {
        
    }
    
    private func updateViewForPost(post: Post?) {
        
    }
}
