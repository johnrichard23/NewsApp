//
//  UserDefaultsExtension.swift
//  NewsApp
//
//  Created by Rodolfo Alamer on 29/07/2021.
//  Copyright © 2021 Richard John Alamer. All rights reserved.
//

import Foundation

extension UserDefaults {
  
  enum UserDefaultsKeys: String {
    case isLoggedIn
  }
  
  func setIsLoggedIn(value: Bool) {
    set(value, forKey: UserDefaultsKeys.isLoggedIn.rawValue)
    synchronize()
  }
  
  func isLoggedIn() -> Bool {
    return bool(forKey: UserDefaultsKeys.isLoggedIn.rawValue)
  }
}
