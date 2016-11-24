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
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    //MARK: - View setup
    override func setupViews() {
        super.setupViews()
        
        logoLabel.text = "imgur Demo"
        logoLabel.font = UIFont(name: "", size: 17)
        
        loginButton.backgroundColor = .green
        loginButton.layer.cornerRadius = 20
        loginButton.clipsToBounds = true
        loginButton.setTitle("Login", for: .normal)
        
        view.addSubview(logoLabel)
        view.addSubview(loginButton)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        logoLabel.snp.makeConstraints { (make) in
            make.center.equalTo(view)
        }
        
        loginButton.snp.makeConstraints { (make) in
            make.top.equalTo(logoLabel.snp.bottom).offset(30)
            make.width.equalTo(view).multipliedBy(0.6)
            make.centerX.equalTo(view)
            make.height.equalTo(40)
        }
    }
}
