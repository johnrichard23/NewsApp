//
//  APIClient+News.swift
//  NewsApp
//
//  Created by Rodolfo Alamer on 28/07/2021.
//  Copyright © 2021 Richard John Alamer. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

extension APIClient {
  
//  @discardableResult
//  func getNews(country: String,
//               category: String,
//                apiKey: String,
//                _ completion: @escaping APINewsClosure) -> DataRequest {
//    let params: JSONDictionary = [
//      "country": country,
//      "category": category,
//      "apiKey": apiKey
//    ]
//
//    return request(
//      "top-headlines?",
//      method: .get,
//      parameters: params,
//      encoding: URLEncoding.queryString,
//      headers: httpRequestHeaders(withAuth: false),
//      success: { resp in
//        return completion(resp.decodedValue(), nil)
//      }, failure: { error in
//        completion(nil, error)
//      }
//    )
//  }
  
//  @discardableResult
//  func getNews1(country: String,
//                category: String,
//                apiKey: String,
//                _ completion: @escaping APINewsClosure) -> DataRequest {
//
//        let urlString = "top-headlines"
//
//        var urlComponents = URLComponents(string: urlString)!
//        urlComponents.queryItems = [
//          URLQueryItem(name: "country", value: country),
//          URLQueryItem(name: "category", value: category),
//          URLQueryItem(name: "apiKey", value: apiKey)
//        ]
//
//    debugPrint(urlComponents.string!)
//
//        return Alamofire
//
//            .request(
//              endpointURL(urlComponents.string!),
//              method: .get,
//              headers: httpRequestHeaders(withAuth: false)
//        )
//        .responseData(completionHandler: { (response: DataResponse<Data>) in
//                guard response.result.error == nil else {
//                    return completion(nil, response.result.error)
//                }
//                do {
//
//                    let json = try JSON(data: response.data!)
//                    let resp = News.collection(withJSON: json)
//                    debugPrint(json)
//                    debugPrint(resp)
//                    completion(resp, nil)
//
//                } catch {
//                    completion(nil, APIClient.generateAPIError(from: response))
//          }
//      })
//  }
  
    func getNews(country: String,
                  category: String,
                  apiKey: String,
                  _ completion: @escaping APINewsClosure) {
      
              dataRequest = Alamofire.request(Router.getNews(countryId: country, category: category, apiKey: apiKey))
              dataRequest?.responseString(completionHandler: { response in
//                print("News API Server Response : \(response)")
                guard response.result.error == nil else {
                    return completion(nil, response.result.error)
                }
                      do {
                        let json = try JSON(data: response.data!)
                        let resp = News(json: json)
                        self.articles = resp!.articles
                        debugPrint("lang", self.articles)
                        completion(self.articles, nil)
                                
                          } catch {
                            debugPrint("error")
                            completion(nil, error)
                          }
                              
        })
  }
      
}
