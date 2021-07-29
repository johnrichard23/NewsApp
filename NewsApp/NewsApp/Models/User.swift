//
//  User.swift
//  NewsApp
//
//  Created by Richard John Alamer on 28/07/2021.
//  Copyright © 2021 Richard John Alamer. All rights reserved.
//

import Foundation

// MARK: - User
struct User: APIModel, Codable {
  let id: Int
  let email: String
  let token: String?

  
  enum CodingKeys: String, CodingKey {
    case id, email, token

  }
}

extension User: Equatable {
  public static func == (lhs: User, rhs: User) -> Bool {
    return lhs.id == rhs.id
  }
}

extension User {
  var isCurrentUser: Bool {
    return false // App.user == self
  }
}

