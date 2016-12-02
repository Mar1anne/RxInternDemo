//
//  Token.swift
//  InternDemo
//
//  Created by WF | Mariana on 11/28/16.
//  Copyright © 2016 WF | Mariana. All rights reserved.
//

import UIKit
import ObjectMapper

class Token: NSObject, Mappable {
    
    var accessToken: String!
    var refreshToken: String!
    private var expiresIn: String!
    
    var isValid: Bool {
        guard let expiresInterval = Double(expiresIn) else { return false }

        let date = Date(timeInterval: TimeInterval(expiresInterval), since: Date())
        return date > Date()
    }
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        accessToken <- map[Network.Token.accessToken]
        refreshToken <- map[Network.Token.refreshToken]
        expiresIn <- map[Network.Token.expiresIn]
    }
}
