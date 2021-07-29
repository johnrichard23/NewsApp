//
//  APIResponse.swift
//  NewsApp
//
//  Created by Richard John Alamer on 27/07/2021.
//  Copyright © 2021 Richard John Alamer. All rights reserved.
//

import Foundation

enum APIResponseErrorCode: String, Codable, Defaultable {
  case validationError
  case verificationError
  case other
  
  static var defaultValue: APIResponseErrorCode {
    return .other
  }
}


public struct APIResponse: Decodable {
  
  let status: HTTPStatusCode
  let data: Any?
  let message: String?
  let isSuccess: Bool
  let errorContext: APIClientError.FailedRequestContext?
  
  enum CodingKeys: String, CodingKey {
    case status = "http_status"
    case data
    case message
    case isSuccess = "success"
    case errorCode = "error_code"
  }
  
    public init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      
      status = try container.decode(HTTPStatusCode.self, forKey: .status)
      data = (try container.decodeIfPresent(AnyDecodable.self, forKey: .data))?.value
      isSuccess = try container.decodeIfPresent(Bool.self, forKey: .isSuccess) ?? false
      
      let errorCode = try container.decodeIfPresent(APIResponseErrorCode.self, forKey: .errorCode) ?? .other
      
      // Value of `message` could either be an array of strings or just a single string.
      let messages = try container.decodeIfPresent(AnyDecodable.self, forKey: .message)
      if let array = messages?.value as? [String] {
        message = array.first
      } else if messages?.value is String {
        message = messages!.value as? String
      } else {
        message = nil
      }
      
      if (HTTPStatusCode.badRequest...HTTPStatusCode.networkConnectTimeoutError).contains(status) {
        errorContext = APIClientError.FailedRequestContext(
          status: status,
          errorCode: errorCode,
          message: message ?? "An unknown error has occurred"
        )
      } else {
        errorContext = nil
      }
    }
    
    func decodeDataPayload<T>(_ keyPath: String? = nil) -> T? where T: Decodable {
      guard var json = data else { return nil }
      if let keyPath = keyPath, let dict = json as? [String: Any] {
        json = dict[keyPath] as Any
      }
      return try? JSONDecoder()
        .decode(T.self, from: JSONSerialization.data(withJSONObject: json, options: .prettyPrinted))
    }
    
    func decodedValue<T>(forKeyPath: String? = nil, decoder: JSONDecoder? = nil) -> T? where T: Decodable {
      guard var payload = data else { return nil }
      
      if let keyPath = forKeyPath {
        guard let d = nestedData(keyPath) else { return nil }
        payload = d
      }
      
      guard JSONSerialization.isValidJSONObject(payload) else {
        debugLog("payload is not a valid json object: \(String(describing: payload))")
        guard let val = payload as? T else { return nil }
        return val
      }
      
      do {
        let json = try JSONSerialization.data(withJSONObject: payload)
        return try (decoder ?? GenericAPIModel.decoder()).decode(T.self, from: json)
      } catch {
        App.shared.recordError(error, info: ["keyPath": forKeyPath ?? "n/a"])
        return nil
      }
    }
    
      func decodedArrayValue<T>(forKeyPath: String? = nil, decoder: JSONDecoder? = nil) -> [T]? where T: Decodable {
        guard var payload = data else { return nil }
        
        if let keyPath = forKeyPath {
          guard let d = nestedData(keyPath) else { return nil }
          payload = d
        }
        
        guard JSONSerialization.isValidJSONObject(payload) else {
          debugLog("payload is not a valid json object: \(String(describing: payload))")
          guard let val = payload as? [T] else { return nil }
          return val
        }
        
        do {
          let json = try JSONSerialization.data(withJSONObject: payload)
          return try (decoder ?? GenericAPIModel.decoder()).decode(Array<T>.self, from: json)
        } catch {
          App.shared.recordError(error, info: ["keyPath": forKeyPath ?? "n/a"])
          return nil
        }
      }
      
      private func nestedData(_ keyPath: String) -> Any? {
        guard let payload = data, !keyPath.isEmpty else { return nil }
        guard let dict = payload as? [String: Any] else { return nil }
        return dict[keyPath] as Any
    }
}
