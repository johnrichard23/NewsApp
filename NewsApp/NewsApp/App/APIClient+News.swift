//
//  APIClient+News.swift
//  NewsApp
//
//  Created by Richard John Alamer on 28/07/2021.
//  Copyright © 2021 Richard John Alamer. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

extension APIClient {
  
    func getNews(country: String,
                  category: String,
                  apiKey: String,
                  _ completion: @escaping APINewsClosure) {
      
              dataRequest = Alamofire.request(Router.getNews(countryId: country, category: category, apiKey: apiKey))
              dataRequest?.responseString(completionHandler: { response in
                debugPrint("News API Server Response : \(response)")
                guard response.result.error == nil else {
                    return completion(nil, response.result.error)
                }
                      do {
                        let json = try JSON(data: response.data!)
                        let resp = News(json: json)
                        self.articles = resp!.articles
                        completion(self.articles, nil)
                                
                          } catch {
                            debugPrint("error")
                            completion(nil, error)
                          }
                              
        })
  }
      
}
