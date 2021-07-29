//
//  Helpers.swift
//  NewsApp
//
//  Created by Richard John Alamer on 27/07/2021.
//  Copyright © 2021 Richard John Alamer. All rights reserved.
//

import UIKit

public struct Helpers {}

public func debugLog(_ message: String, file: String = #file, line: Int = #line, function: String = #function) {
  #if DEBUG
    let fileURL = NSURL(fileURLWithPath: file)
    let fileName = fileURL.deletingPathExtension?.lastPathComponent ?? ""
    print("\(fileName)::\(function)[L:\(line)] \(message)")
  #endif

}
