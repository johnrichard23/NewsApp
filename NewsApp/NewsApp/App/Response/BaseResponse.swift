//
//  BaseResponse.swift
//  NewsApp
//
//  Created by Richard John Alamer on 27/07/2021.
//  Copyright © 2021 Richard John Alamer. All rights reserved.
//

import Foundation

class BaseResponse: Codable {
    let success: Bool
    let message: String
    var status: Int { return http_status }
    
    private let http_status: Int
}
