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
    
    case Authenticate([String: Any])
    case Posts(pageNumber: Int, type: String)
    case RefreshToken([String: Any])
    
    var path: String {
        switch self {
        case .Authenticate:
            return "https://api.imgur.com/oauth2/authorize"
        case .Posts(let page,let type):
            return "https://api.imgur.com/3/gallery/\(type)/\(page)"
        case .RefreshToken:
            return "https://api.imgur.com/oauth2/token"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .RefreshToken:
            return .post
        default:
            return .get
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .Authenticate(let parameters): return parameters
        case .Posts(_, _): return nil
        case .RefreshToken(let parameters): return parameters
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        
        print(self.path)
        
        let url = URL(string: path)
        var urlRequest = URLRequest(url: url!)
        let encoding = Alamofire.URLEncoding.methodDependent
        
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue("application/json",
                            forHTTPHeaderField: "Content-Type")
        urlRequest.setValue(ConfigurationsManager.shared.imgurClientId,
                            forHTTPHeaderField: "client_id")
        
        switch self { // don't like this, refactor! :D
            
        case .Posts:
            urlRequest.setValue("Bearer " + TokenManager.shared.accessToken!.accessToken, forHTTPHeaderField: "Authorization")
        default: break
        }

        return try! encoding.encode(urlRequest, with: parameters)
    }
    
}
