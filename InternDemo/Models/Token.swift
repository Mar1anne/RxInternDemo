//
//  Token.swift
//  InternDemo
//
//  Created by WF | Mariana on 11/28/16.
//  Copyright © 2016 WF | Mariana. All rights reserved.
//

import UIKit
import ObjectMapper

class Token: NSObject, Mappable, NSCoding {
    var accessToken: String!
    var refreshToken: String!
    var expiresIn: Double!
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        accessToken <- map["access_token"]
        refreshToken <- map["refresh_token"]
        expiresIn <- map["expires_in"]
    }
    
    required init?(coder aDecoder: NSCoder) {
        accessToken = aDecoder.decodeObject(forKey: "access_token") as? String
        refreshToken = aDecoder.decodeObject(forKey: "refresh_token") as? String
        expiresIn = aDecoder.decodeDouble(forKey: "expires_in")
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(accessToken, forKey: "access_token")
        aCoder.encode(refreshToken, forKey: "refresh_token")
        aCoder.encode(expiresIn, forKey: "expires_in")
    }
    
}
