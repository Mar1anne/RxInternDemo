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
    var expiresIn: String!
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        accessToken <- map[Network.Token.accessToken]
        refreshToken <- map[Network.Token.refreshToken]
        expiresIn <- map[Network.Token.expiresIn]
    }
    
    required init?(coder aDecoder: NSCoder) {
        accessToken = aDecoder.decodeObject(forKey: Network.Token.accessToken) as? String
        refreshToken = aDecoder.decodeObject(forKey: Network.Token.refreshToken) as? String
        expiresIn = aDecoder.decodeDouble(forKey: Network.Token.expiresIn) as? String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(accessToken, forKey: Network.Token.accessToken)
        aCoder.encode(refreshToken, forKey: Network.Token.refreshToken)
        aCoder.encode(expiresIn, forKey: Network.Token.expiresIn)
    }
    
}
