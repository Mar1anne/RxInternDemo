//
//  User.swift
//  InternDemo
//
//  Created by WF | Mariana on 11/24/16.
//  Copyright © 2016 WF | Mariana. All rights reserved.
//

import UIKit
import ObjectMapper

class User: NSObject, Mappable, NSCoding {

    var id: Int!
    var username: String!
        
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        id <- map[Network.User.accountId]
        username <- map[Network.User.username]
    }
    
    required init?(coder aDecoder: NSCoder) {
        id = aDecoder.decodeObject(forKey: Network.User.accountId) as? Int
        username = aDecoder.decodeObject(forKey: Network.User.username) as? String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: Network.User.accountId)
        aCoder.encode(username, forKey: Network.User.username)
    }
    
}
