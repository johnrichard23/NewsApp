//
//  News.swift
//  NewsApp
//
//  Created by Rodolfo Alamer on 27/07/2021.
//  Copyright © 2021 Richard John Alamer. All rights reserved.
//

import UIKit
import SwiftyJSON

//struct News: APIModel, Codable, Identifiable {
//  let id: Int
//  let author, title, avatarURL: String
//
//  enum CodingKeys: String, CodingKey {
//    case id, author, title
//    case avatarURL = "urlToImage"
//  }
//}

struct News: ResponseCollectionSerializable, ResponseObjectSerializable {

    var articles = [NewsArticles]()

    init?(response: HTTPURLResponse, json: JSON) {
      articles = NewsArticles.collection(withJSON: json["articles"])
    }

    init?(json: JSON) {
      articles = NewsArticles.collection(withJSON: json["articles"])
    }
}

struct NewsArticles: ResponseCollectionSerializable, ResponseObjectSerializable {
    
    var author: String = ""
    var title: String = ""
    var publishedDate: String = ""
    var avatarURL: String = ""
    
    init?(response: HTTPURLResponse, json: JSON) {
      author = json["author"].stringValue
      title = json["title"].stringValue
      publishedDate = json["publishedAt"].stringValue
      avatarURL = json["urlToImage"].stringValue
    }
    
    init?(json: JSON) {
      author = json["author"].stringValue
      title = json["title"].stringValue
      publishedDate = json["publishedAt"].stringValue
      avatarURL = json["urlToImage"].stringValue
    }
}
