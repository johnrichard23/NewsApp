//
//  Codable.swift
//  NewsApp
//
//  Created by Richard John Alamer on 27/07/2021.
//  Copyright © 2021 Richard John Alamer. All rights reserved.
//

import Foundation

extension Encodable {
  func encoded() throws -> Data {
    return try JSONEncoder().encode(self)
  }
}

extension Data {
  func decoded<T: Decodable>() throws -> T {
    return try JSONDecoder().decode(T.self, from: self)
  }
}
