//
//  App.swift
//  NewsApp
//
//  Created by Rodolfo Alamer on 27/07/2021.
//  Copyright © 2021 Richard John Alamer. All rights reserved.
//

import UIKit

class App {
  
  static let shared = App()
  
  private(set) var api: APIClient!
  
  init() {
    
  }
  
  func bootstrap(
      with application: UIApplication,
      launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ){
      api = APIClient(baseURL: URL(string: "https://newsapi.org/v2/top-headlines?")!)
  }

  func recordError(_ error: Error, info: [String: Any]? = nil) {
    debugLog(String(describing: error))

    if info != nil {
      debugLog("other info: \(String(describing: info!))")
    }

  }
}

protocol AppService {}

extension AppService {
  
  var app: App {
    return App.shared
  }
}

