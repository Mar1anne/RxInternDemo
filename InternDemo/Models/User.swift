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
        id <- map["account_id"]
        username <- map["account_username"]
    }
    
    required init?(coder aDecoder: NSCoder) {
        id = aDecoder.decodeObject(forKey: "account_id") as? Int
        username = aDecoder.decodeObject(forKey: "account_username") as? String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "account_id")
        aCoder.encode(username, forKey: "account_username")
    }
    
}
