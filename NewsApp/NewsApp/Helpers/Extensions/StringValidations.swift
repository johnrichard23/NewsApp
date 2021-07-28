//
//  StringValidations.swift
//  NewsApp
//
//  Created by Rodolfo Alamer on 28/07/2021.
//  Copyright © 2021 Richard John Alamer. All rights reserved.
//

import Foundation

extension String {
  
  var isEmail: Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,20}"
    let emailTest  = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: self)
  }
}
