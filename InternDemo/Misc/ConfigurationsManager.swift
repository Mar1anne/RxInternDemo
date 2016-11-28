//
//  ConfigurationsManager.swift
//  InternDemo
//
//  Created by WF | Mariana on 11/28/16.
//  Copyright © 2016 WF | Mariana. All rights reserved.
//

import UIKit

class ConfigurationsManager: NSObject {
    static let shared = ConfigurationsManager()
    
    var imgurClientSecret: String!
    var imgurClientId: String!
    
    override init() {
        
        let infoPlistPath = Bundle.main.path(forResource: "Info", ofType: "plist")
        let infoPlistConfig = NSDictionary(contentsOfFile: infoPlistPath!)
        
        imgurClientId = infoPlistConfig?["ImgurClientId"] as! String
        imgurClientSecret = infoPlistConfig?["ImgurClientSecret"] as! String
        
        super.init()
    }
}
