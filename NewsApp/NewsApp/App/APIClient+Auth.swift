//
//  APIClient+Auth.swift
//  NewsApp
//
//  Created by Rodolfo Alamer on 29/07/2021.
//  Copyright © 2021 Richard John Alamer. All rights reserved.
//

import UIKit
import Foundation
import FirebaseAuth
import SVProgressHUD
import Alamofire


extension APIClient {
  
  func postRegisterUser(email: String,
                        password: String,
                        completionBlock: @escaping (_ success: Bool) -> Void) {
    
    Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
        if let user = authResult?.user {
            print(user)
            completionBlock(true)
        } else {
            completionBlock(false)
        }
    }
  }
  
  func postLoginUser(email: String,
                     password: String,
                     completionBlock: @escaping (_ success: Bool) -> Void) {
    
    Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
      
      if let error = error, let _ = AuthErrorCode(rawValue: error._code) {
          completionBlock(false)
      } else {
          completionBlock(true)
      }
    }
  }
}
