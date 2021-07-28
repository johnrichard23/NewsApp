//
//  Defaultable.swift
//  NewsApp
//
//  Created by Rodolfo Alamer on 27/07/2021.
//  Copyright © 2021 Richard John Alamer. All rights reserved.
//

import Foundation

protocol Defaultable: RawRepresentable {
    
    static var defaultValue: Self { get }
}

extension Defaultable {
    
    static func value(for rawValue: RawValue) -> Self {
        return Self(rawValue: rawValue) ?? Self.defaultValue
    }
}

extension Defaultable where Self.RawValue: Decodable {
    
    init(from decoder: Decoder) throws {
        self = Self.value(for: try decoder.singleValueContainer().decode(RawValue.self))
    }
}
