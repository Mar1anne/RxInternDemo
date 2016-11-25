//
//  LoginViewController.swift
//  InternDemo
//
//  Created by WF | Mariana on 11/24/16.
//  Copyright © 2016 WF | Mariana. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {

    private let logoLabel = UILabel()
    private let loginButton = UIButton()

    //MARK: - View setup
    override func setupViews() {
        super.setupViews()
        
        view.backgroundColor = .white
        
        logoLabel.text = "imgur Demo"
        logoLabel.font = UIFont.gothicBoldFontOfSize(size: 37)
        
        loginButton.backgroundColor = .green
        loginButton.layer.cornerRadius = 20
        loginButton.clipsToBounds = true
        loginButton.setTitle("Login", for: .normal)
        loginButton.titleLabel?.font = UIFont.gothicBoldFontOfSize(size: 17)
        
        view.addSubview(logoLabel)
        view.addSubview(loginButton)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        logoLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view).offset(-30)
        }
        
        loginButton.snp.makeConstraints { (make) in
            make.top.equalTo(logoLabel.snp.bottom).offset(30)
            make.width.equalTo(view).multipliedBy(0.6)
            make.centerX.equalTo(view)
            make.height.equalTo(40)
        }
    }
    
    //MARK: - Login
    func onLogin() {
        
    }
}
