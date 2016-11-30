//
//  MenuItem.swift
//  InternDemo
//
//  Created by WF | Mariana on 11/30/16.
//  Copyright © 2016 WF | Mariana. All rights reserved.
//

import UIKit

enum MenuItemType: Int {
    case MyPosts
    case HotPosts
    case PopularPosts
    case Settings
}

struct MenuItem: CustomStringConvertible {
    var type: MenuItemType
    
    init(type: MenuItemType) {
        self.type = type
    }
    
    var description: String {
        switch self.type {
        case .MyPosts:
            return "My Posts"
        case .HotPosts:
            return "Hot Posts"
        case .PopularPosts:
            return "Popular Posts"
        case .Settings:
            return "Settings"
        }
    }
}
