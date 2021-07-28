//
//  DataRequest.swift
//  NewsApp
//
//  Created by Rodolfo Alamer on 28/07/2021.
//  Copyright © 2021 Richard John Alamer. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

extension DataRequest {
    

  // MARK: Instance
    
  @discardableResult
    func responseCollection<T: ResponseCollectionSerializable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<[T]>) -> Void) -> Self {
        let responseSerializer = DataResponseSerializer<[T]> { request, response, data, error in
            if let error = error {
                return .failure(ResponseObjectError.network(error: error))
            }
            
            guard let data = data else {
                return .failure(ResponseObjectError.data(reason: "Data is missing."))
            }
            
            let json = try! JSON(data: data)
            
            if let error = json.error {
                return .failure(ResponseObjectError.jsonSerialization(error: error))
            }
            
            guard let response = response else {
                return .failure(ResponseObjectError.response(reason: "Response is missing."))
            }
            
            switch response.statusCode {
            case 401:
                if let reason = String(data: data, encoding: .utf8), !reason.isEmpty {
                    return .failure(ResponseObjectError.client(reason: reason))
                }
                
                return .failure(ResponseObjectError.client(reason: "Unauthorized"))
                
            case 422:
                
                if let reason = json.first?.1.stringValue {
                    if var reason = String(data: data, encoding: .utf8), !reason.isEmpty {
                        reason = reason.replacingOccurrences(of: "[", with: "")
                        reason = reason.replacingOccurrences(of: "]", with: "")
                        return .failure(ResponseObjectError.client(reason: reason))
                    }

                    return .failure(ResponseObjectError.client(reason: reason))
                }
                
                return .failure(ResponseObjectError.client(reason: "Unauthorized"))
            
            
            case 403:
                if let reason = String(data: data, encoding: .utf8), !reason.isEmpty {
                    return .failure(ResponseObjectError.client(reason: reason))
                }
                
                return .failure(ResponseObjectError.client(reason: "Unauthorized"))
                
            default: break
            }
            
            return .success(T.collection(from: response, withJSON: json))
        }
        
        return response(responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
    
  @discardableResult
    func responseObject<T: ResponseObjectSerializable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        let responseSerializer = DataResponseSerializer<T> { request, response, data, error in
            
            if let error = error {
                return .failure(ResponseObjectError.network(error: error))
            }
            
            guard let data = data else {
                return .failure(ResponseObjectError.data(reason: "Data is missing."))
            }
            
            let json = try! JSON(data: data)
            
            if let error = json.error {
                return .failure(ResponseObjectError.jsonSerialization(error: error))
            }
            
            guard let response = response else {
                return .failure(ResponseObjectError.response(reason: "Response is missing."))
            }
            
            switch response.statusCode {
            case 401:
                if let reason = String(data: data, encoding: .utf8), !reason.isEmpty {
                    return .failure(ResponseObjectError.client(reason: reason))
                }
                
                return .failure(ResponseObjectError.client(reason: "Unauthorized"))
                
            case 422:
                if let reason = json.first?.1.first?.1.stringValue {
                    if var reason = String(data: data, encoding: .utf8), !reason.isEmpty {
                        reason = reason.replacingOccurrences(of: "[", with: "")
                        reason = reason.replacingOccurrences(of: "]", with: "")
                        return .failure(ResponseObjectError.client(reason: reason))
                    }
                    
                    return .failure(ResponseObjectError.client(reason: reason))
                }
                
                return .failure(ResponseObjectError.client(reason: "Unauthorized"))
            case 403:
                if let reason = String(data: data, encoding: .utf8), !reason.isEmpty {
                    return .failure(ResponseObjectError.client(reason: reason))
                }
                
                return .failure(ResponseObjectError.client(reason: "Unauthorized"))
            
            case 502:
                if let reason = String(data: data, encoding: .utf8), !reason.isEmpty {
                    return .failure(ResponseObjectError.client(reason: reason))
                }
                
                return .failure(ResponseObjectError.client(reason: "Unauthorized"))
                
            default:
                break
            }
            
            guard let responseObject = T(response: response, json: json) else {
                return .failure(ResponseObjectError.objectSerialization(reason: "JSON could not be serialized: \(json)"))
            }
            
            return .success(responseObject)
        }
        
        return response(queue: queue, responseSerializer: responseSerializer, completionHandler: completionHandler)
        
    }
    
}

// MARK: -

enum ResponseObjectError: Error {
    case client(reason: String)
    case data(reason: String)
    case jsonSerialization(error: Error)
    case network(error: Error)
    case response(reason: String)
    case objectSerialization(reason: String)
}

// MARK: -

protocol ResponseCollectionSerializable {
    static func collection(from response: HTTPURLResponse, withJSON json: JSON) -> [Self]
}

extension ResponseCollectionSerializable where Self: ResponseObjectSerializable {
    
    static func collection(from response: HTTPURLResponse, withJSON jsonArray: JSON) -> [Self] {
        var collection: [Self] = []
        
        for json in jsonArray.arrayValue where jsonArray.error == nil {
            if let item = Self(response: response, json: json) {
                collection.append(item)
            }
        }
        return collection
    }
    
    static func collection(withJSON jsonArray: JSON) -> [Self] {
        var collection: [Self] = []
        
        for json in jsonArray.arrayValue where jsonArray.error == nil {
            if let item = Self(json: json) {
                collection.append(item)
            }
        }
        
        return collection
    }
    
}

// MARK: -

protocol ResponseObjectSerializable {
    init?(response: HTTPURLResponse, json: JSON)
    init?(json: JSON)
}

