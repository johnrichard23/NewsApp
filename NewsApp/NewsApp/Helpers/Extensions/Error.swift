//
//  Error.swift
//  NewsApp
//
//  Created by Rodolfo Alamer on 27/07/2021.
//  Copyright © 2021 Richard John Alamer. All rights reserved.
//

import Foundation

extension Error {
    
    private static var apiErrorDomain: String {
        return "APIError"
    }
    
    static var genericAPIError: Error {
        return error(domain: apiErrorDomain, code: -1, message: "Something went wrong, please try again.")
    }
    
    static func error(domain: String, code: Int, message: String) -> Error {
      return NSError(
        domain: domain,
        code: code,
        userInfo: [NSLocalizedDescriptionKey: message]
      )
    }
    
    static func error(from response: BaseResponse) -> Error {
      return NSError.error(
        domain: apiErrorDomain,
        code: response.status,
        message: response.message
      )
    }
}
