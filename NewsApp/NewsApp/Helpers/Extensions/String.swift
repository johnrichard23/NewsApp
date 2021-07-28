//
//  String.swift
//  NewsApp
//
//  Created by Rodolfo Alamer on 28/07/2021.
//  Copyright © 2021 Richard John Alamer. All rights reserved.
//

import UIKit

extension String {
  var trimmed: String {
    return self.trimmingCharacters(in: .whitespacesAndNewlines)
  }
}
