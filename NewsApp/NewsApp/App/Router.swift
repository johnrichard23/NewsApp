//
//  Router.swift
//  NewsApp
//
//  Created by Richard John Alamer on 28/07/2021.
//  Copyright © 2021 Richard John Alamer. All rights reserved.
//

import Foundation
import Alamofire
import UIKit
import Foundation

enum Router: URLRequestConvertible {
    
    // GET: functions
  case getNews(countryId: String, category: String, apiKey: String)
    
    // MARK: URL for News API Server
    static let baseURLString = "https://newsapi.org/v2/top-headlines"
   

    
    // MARK: Endpoints
    private var path: String {
        switch self {
            
        // GET: Endpoints
        case .getNews(let countryId, let category, let apiKey):
            return ""
        
        } //END: Switch
        
    }
    
    
    
    // MARK: Methods
    private var method: HTTPMethod {
        switch self {
            
        // GET: Methods
        case .getNews: return .get

        } // END: Switch
    }
    
    
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        
        var url = try Router.baseURLString.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
            
        print("PATH URL: \(urlRequest)" )
        urlRequest.httpMethod = method.rawValue
        urlRequest.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        switch self {
        // GET: parameters
        case .getNews(let countryId, let category, let apiKey):
            let parameters: [String: Any] = [
                "country" : countryId,
                "category" : category,
                "apiKey" : apiKey,
            ]
            print("PATH PARAMS: \(parameters)" )
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
                            
        } // END: Switch
        
        return urlRequest
    }
    
}

