//
//  News.swift
//  NewsApp
//
//  Created by Rodolfo Alamer on 27/07/2021.
//  Copyright © 2021 Richard John Alamer. All rights reserved.
//

import UIKit
import SwiftyJSON

struct News: ResponseCollectionSerializable, ResponseObjectSerializable {
  
    var author: String = ""
    var title: String = ""
    var description: String = ""

    init?(response: HTTPURLResponse, json: JSON) {
      author = json.stringValue
      title = json.stringValue
      description = json.stringValue
    }
      
    init?(json: JSON) {
      author = json["author"].stringValue
      title = json["title"].stringValue
      description = json["description"].stringValue
    }
}
