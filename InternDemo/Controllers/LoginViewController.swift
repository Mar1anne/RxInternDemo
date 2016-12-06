//
//  LoginViewController.swift
//  InternDemo
//
//  Created by WF | Mariana on 11/24/16.
//  Copyright © 2016 WF | Mariana. All rights reserved.
//

import UIKit
import RxCocoa

class LoginViewController: BaseViewController {

    private let logoLabel = UILabel()
    private let loginButton = UIButton()
    private let loginImage = UIImageView()
    
    //MARK: - View setup
    override func setupViews() {
        super.setupViews()
        
        view.backgroundColor = .white
        
        loginImage.image = UIImage(named: "login_background")
        
        logoLabel.text = "imgur Demo"
        logoLabel.font = UIFont.gothicBoldFontOfSize(size: 37)
        
        loginButton.backgroundColor = .black
        loginButton.layer.cornerRadius = 20
        loginButton.clipsToBounds = true
        loginButton.setTitle("Login", for: .normal)
        loginButton.titleLabel?.font = UIFont.gothicBoldFontOfSize(size: 17)
        
        loginButton.rx.tap.subscribe { (event) in
            self.onLogin()
        }.addDisposableTo(disposeBag)
        
        view.addSubview(loginImage)
        view.addSubview(logoLabel)
        view.addSubview(loginButton)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        logoLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(view).offset(100)
        }
        
        loginButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(view).offset(-50)
            make.width.equalTo(view).multipliedBy(0.6)
            make.centerX.equalTo(view)
            make.height.equalTo(40)
        }
        
        loginImage.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
    
    //MARK: - Login
    func onLogin() {
        let parameters = ["client_id": ConfigurationsManager.shared.imgurClientId,
                          "response_type": "token"]
        let urlRequest = APIRouter.Authenticate(parameters as [String : AnyObject])
        UIApplication.shared.openURL(urlRequest.urlRequest!.url!)
    }
    
}
