//
//  APIRouter.swift
//  InternDemo
//
//  Created by WF | Mariana on 11/28/16.
//  Copyright © 2016 WF | Mariana. All rights reserved.
//

import UIKit
import Alamofire

enum APIRouter: URLRequestConvertible {
    case Authenticate([String: AnyObject])
    
    var path: String {
        switch self {
        case .Authenticate:
            return "https://api.imgur.com/oauth2/authorize"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .Authenticate:
            return .get
        }
    }
    
    var parameters: [String: AnyObject]? {
        switch self {
        case .Authenticate(let parameters): return parameters
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        
        print(self.path)
        
        let url = URL(string: path)
        var urlRequest = URLRequest(url: url!)
        let encoding = Alamofire.URLEncoding.methodDependent
        
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue(ConfigurationsManager.shared.imgurClientId, forHTTPHeaderField: "client_id")
        
        return try! encoding.encode(urlRequest, with: parameters)
    }
    
}
