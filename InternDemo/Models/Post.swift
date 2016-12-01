//
//  Post.swift
//  InternDemo
//
//  Created by WF | Mariana on 11/24/16.
//  Copyright © 2016 WF | Mariana. All rights reserved.
//

import UIKit
import ObjectMapper

class Post: NSObject, Mappable {
    
    var id: String!
    var link: String!
    var title: String?
    var postDescription: String?
    var isAlbum: Bool!
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        id <- map[Network.Post.id]
        link <- map[Network.Post.link]
        title <- map[Network.Post.title]
        isAlbum <- map[Network.Post.isAlbum]
        postDescription <- map[Network.Post.description]
    }
    
}
