//
//  User.swift
//  InternDemo
//
//  Created by WF | Mariana on 11/24/16.
//  Copyright © 2016 WF | Mariana. All rights reserved.
//

import UIKit
import ObjectMapper

class User: Mappable, NSCoding {

    var id: Int!
    var username: String!
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        id <- map["id"]
        username <- map["url"]
    }
    
    required init?(coder aDecoder: NSCoder) {
        id = aDecoder.decodeObject(forKey: "id") as? Int
        username = aDecoder.decodeObject(forKey: "url") as? String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(username, forKey: "url")
    }
    
    
}
