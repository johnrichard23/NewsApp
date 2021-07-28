//
//  Model.swift
//  NewsApp
//
//  Created by Rodolfo Alamer on 27/07/2021.
//  Copyright © 2021 Richard John Alamer. All rights reserved.
//

import Foundation

protocol Model {
    
    static func decoder() -> JSONDecoder
    static func encoder() -> JSONEncoder
}

// MARK: - Decodable
extension Model where Self: Decodable {
    
    static func decoder() -> JSONDecoder {
        return JSONDecoder()
    }
    
    static func decode(_ data: Data) throws -> Self {
        return try decoder().decode(self, from: data)
    }
    
    static func decode(_ dictionary: [String: Any]) throws -> Self {
        return try decode(try JSONSerialization.data(withJSONObject: dictionary))
    }
}

// MARK: - Encodable
extension Model where Self: Encodable {
    
    static func encoder() -> JSONEncoder {
        return JSONEncoder()
    }
    
    func encode() throws -> Data {
      return try Self.encoder().encode(self)
    }
    
    func dictionary() -> [String: Any]? {
      do {
        if let dict = try JSONSerialization.jsonObject(
          with: try encode(),
          options: .allowFragments
          ) as? [String: Any] {
          return dict.filter { !($0.value is NSNull) }
        }
      } catch {
        
      }
      return nil
    }
    
    func json() -> String? {
        do {
            return String(data: try encode(), encoding: .utf8)
        } catch {
            App.shared.recordError(error)
            return nil
        }
    }
}

// MARK: - APIModel

protocol APIModel: Model {}

extension APIModel {
    
    static func decoder() -> JSONDecoder {
        return JSONDecoder()
    }
    
    static func encoder() -> JSONEncoder {
        return JSONEncoder()
    }
    
    static func decode<T>(_ type: T.Type, from data: Data) -> T? where T: Decodable {
        return try? JSONDecoder().decode(type, from: data)
    }
    
}

struct GenericAPIModel: APIModel {}

// MARK: - APIRequestParameters

protocol APIRequestParameters: Model, Codable { }
