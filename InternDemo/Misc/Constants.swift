//
//  Constants.swift
//  InternDemo
//
//  Created by WF | Mariana on 11/24/16.
//  Copyright © 2016 WF | Mariana. All rights reserved.
//

import UIKit

struct Constants {
    
    struct UI {
        static let screenHeight: CGFloat = UIScreen.main.bounds.size.height
        static let screenWidth: CGFloat = UIScreen.main.bounds.size.width
    }
    
}

struct Network {
    
    struct Token {
        static let accessToken = "access_token"
        static let refreshToken = "refresh_token"
        static let expiresIn = "expires_in"
    }
    
    struct User {
        static let accountId = "account_id"
        static let username = "account_username"
    }
    
}
