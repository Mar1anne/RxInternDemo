//
//  MenuTableHeaderView.swift
//  InternDemo
//
//  Created by WF | Mariana on 11/24/16.
//  Copyright © 2016 WF | Mariana. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift

class MenuTableHeaderView: UIView {

    private let profileImageView = UIImageView()
    private let nameLabel = UILabel()
    private let disposeBag = DisposeBag()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View setup
    private func setupView() {
        backgroundColor = .white
        
        profileImageView.layer.borderColor = UIColor.gray.cgColor
        profileImageView.layer.borderWidth = 1
        profileImageView.clipsToBounds = true
        profileImageView.contentMode = .scaleAspectFill
        
        nameLabel.textAlignment = .center
        
        addSubview(profileImageView)
        addSubview(nameLabel)
    }
    
    private func setupConstraints() {
        profileImageView.snp.makeConstraints { (make) in
            make.center.equalTo(self)
            make.width.height.equalTo(self.snp.width).multipliedBy(0.5)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(profileImageView.snp.bottom)
            make.width.equalTo(self).multipliedBy(0.8)
            make.centerX.equalTo(profileImageView)
        }
    }
    
    //MARK: - Methods
    func bindTo(userObservable: Observable<User?>) {
        userObservable.subscribe(onNext: { (user) in
            self.nameLabel.text = user?.username
        }, onError: nil, onCompleted: nil, onDisposed: nil)
            .addDisposableTo(disposeBag)
    }
}
