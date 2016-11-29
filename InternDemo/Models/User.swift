//
//  User.swift
//  InternDemo
//
//  Created by WF | Mariana on 11/24/16.
//  Copyright © 2016 WF | Mariana. All rights reserved.
//

import UIKit
import ObjectMapper

class User: NSObject, Mappable {

    var id: String!
    var username: String!
        
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        id <- map[Network.User.accountId]
        username <- map[Network.User.username]
    }
}
