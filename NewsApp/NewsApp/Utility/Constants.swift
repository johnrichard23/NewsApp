//
//  Constants.swift
//  NewsApp
//
//  Created by Rodolfo Alamer on 28/07/2021.
//  Copyright © 2021 Richard John Alamer. All rights reserved.
//

import Foundation

public typealias JSONDictionary = [String: Any]

struct Constants {

  struct UserDefaults {
    static let isNotFreshInstall = "isNotFreshInstall"
  }
}

struct Formatters {
  
  static let debugConsoleDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
    formatter.timeZone = TimeZone(identifier: "UTC")!
    return formatter
  }()
  
}


