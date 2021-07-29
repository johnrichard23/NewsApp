//
//  APIClient.swift
//  NewsApp
//
//  Created by Rodolfo Alamer on 27/07/2021.
//  Copyright © 2021 Richard John Alamer. All rights reserved.
//

import UIKit
import Alamofire

typealias APIClientResultClosure = (APIClientResult) -> Void
typealias APIClientLoginClosure = (User?, Error?) -> Void
typealias APINewsClosure = ([NewsArticles]?, Error?) -> Void

enum APIClientResult {
    case success(APIResponse)
    case failure(Error)
}

enum APIClientError: Error {
    
    struct FailedRequestContext {
        let status: HTTPStatusCode
        let errorCode: APIResponseErrorCode
        let message: String
    }
    
    case failedRequest(FailedRequestContext)
    
    case dataNotFound(_ expectedType: Any.Type)
    
    case unknown
}

class APIClient: AppService {
  
  public var dataRequest: DataRequest?
  var news: News?
  var articles = [NewsArticles]()
 
  private(set) var baseURL: URL
  
  public init(baseURL: URL) {
    self.baseURL = baseURL
  }
  
  public func endpointURL(_ resourcePath: String) -> URL {
    let urlComponents = URLComponents(string: resourcePath)!
    return baseURL.appendingPathComponent("\(urlComponents.string!)")
  }
  
  public func endpointBaseURL(_ resourcePath: String) -> URL {
    return baseURL.appendingPathComponent("/\(resourcePath)")
  }
  
  public func httpRequestHeaders(withAuth: Bool = true) -> HTTPHeaders {
    let headers = [
      "Content-Type": "application/x-www-form-urlencoded",
      "Accept": "application/json"
    ]
    return headers
  }
  
  public func httpRequestHeadersJSON(withAuth: Bool = true) -> HTTPHeaders {
    let headers = [
      "Content-Type": "application/json",
      "Accept": "application/json"
    ]
    return headers
  }

  public func request(
    _ resourcePath: String,
    method: HTTPMethod,
    version: String? = nil,
    parameters: Parameters? = nil,
    encoding: ParameterEncoding = URLEncoding.default,
    headers: HTTPHeaders? = nil,
    success: @escaping (APIResponse) -> Void,
    failure: @escaping (Error) -> Void
    ) -> DataRequest {
    return Alamofire
      .request(
        endpointURL(resourcePath),
        method: method,
        parameters: parameters,
        encoding: encoding,
        headers: headers
      )
      .apiResponse(completion: { (result) in
        switch result {
        case .success(let resp):
          success(resp)
        case .failure(let error):
          failure(error)
        }
      })
  }
  

  func upload(
    to endpointURL: URL,
    with payload: @escaping (MultipartFormData) -> Void,
    requiresAuth: Bool = true,
    method: HTTPMethod = .post,
    completion: @escaping APIClientResultClosure
    ) {
    Alamofire.upload(
      multipartFormData: payload,
      to: endpointURL,
      method: method,
      encodingCompletion: { result in
        switch result {
        case .success(let request, _, _):
          request.apiResponse(completion: completion)
        case .failure(let error):
          App.shared.recordError(error)
          return completion(.failure(error))
        }
    })
  }
}

extension APIClient {

  static func generateAPIError(from response: DataResponse<Data>) -> Error {
    do {
      let baseResponse: BaseResponse = try response.value!.decoded()
      return NSError.error(from: baseResponse)
    } catch {
      return NSError.genericAPIError
    }
  }
}

extension APIClientError: LocalizedError {
  
  var errorDescription: String? {
    switch self {
    case .failedRequest(let ctx):
      return ctx.message
    case .dataNotFound:
      return "Data expected from the server not found"
    default:
      return "An unknown error has occured"
    }
  }
  
  var failureReason: String? {
    switch self {
    case .failedRequest(let ctx):
      return "HTTPStatusCode: \(ctx.status); APIResponseErrorCode: \(ctx.errorCode); Message: \(ctx.message);"
    case .dataNotFound(let type):
      return "Expected \(String(describing: type)). Got nil instead."
    default:
      return "An unknown error has occured"
    }
  }
  
}

// MARK: - Alamofire.DataRequest

extension DataRequest {
  
  @discardableResult
  func apiResponse(
    queue: DispatchQueue? = nil,
    completion: @escaping APIClientResultClosure
    ) -> DataRequest {
    return self.responseData(queue: queue, completionHandler: { (response: DataResponse<Data>) in
      guard response.result.error == nil else {
        App.shared.recordError(response.result.error!)
        return completion(.failure(response.result.error!))
      }
      guard let responseData = response.value else {
        return completion(.failure(APIClientError.dataNotFound(Data.self)))
      }
      
      do {
        let resp = try JSONDecoder().decode(APIResponse.self, from: self.utf8Data(from: responseData))
        if let context = resp.errorContext {
          completion(.failure(APIClientError.failedRequest(context)))
        } else {
          completion(.success(resp))
        }
        
      } catch {
        App.shared.recordError(error)
        completion(.failure(error))
      }
    })
  }
  
  // TODO Throw error
  private func utf8Data(from data: Data) -> Data {
    let encoding = detectEncoding(of: data)
    guard encoding != .utf8 else { return data }
    guard let responseString = String(data: data, encoding: encoding) else {
      preconditionFailure("Could not convert data to string with encoding \(encoding.rawValue)")
    }
    guard let utf8Data = responseString.data(using: .utf8) else {
      preconditionFailure("Could not convert data to UTF-8 format")
    }
    return utf8Data
  }
  
  private func detectEncoding(of data: Data) -> String.Encoding {
    var convertedString: NSString?
    let encoding = NSString.stringEncoding(
      for: data,
      encodingOptions: nil,
      convertedString: &convertedString,
      usedLossyConversion: nil
    )
    debugLog("~~> \(encoding)")
    return String.Encoding(rawValue: encoding)
  }
  
  @discardableResult
  func responseData(queue: DispatchQueue? = nil,
                    completionHandler: @escaping (DataResponse<Data>) -> Void) -> Self {
    return response(
      queue: queue,
      responseSerializer: DataRequest.dataResponseSerializer(),
      completionHandler: { response in
        if response.response?.statusCode == 401 {
          guard let url = response.response?.url else {
            return
          }
        }
        completionHandler(response)
      })
  }
  
}


