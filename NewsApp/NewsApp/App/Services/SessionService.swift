//
//  SessionService.swift
//  NewsApp
//
//  Created by Rodolfo Alamer on 28/07/2021.
//  Copyright © 2021 Richard John Alamer. All rights reserved.
//

import Foundation
import FirebaseAuth
import SVProgressHUD

class SessionService {
  
  struct Notifications {
    static let didLogin = Notification.Name("didLogin")
    static let didLogout = Notification.Name("didLogout")
  }
  
  private(set) var api: APIClient
  private(set) var isLoggedIn: Bool
  
  var user: User? {
    didSet {
      UserDefaults.standard.cachedUser = try? user.encoded()
      UserDefaults.standard.synchronize()
    }
  }
  
  var userId: Int {
    return user?.id ?? 0
  }
  
  init(api: APIClient) {
    self.api = api
    self.isLoggedIn = false
  }
  
}

// MARK: Public
extension SessionService {
  
  func isLogIn() -> Bool {
    return UserDefaults.standard.bool(forKey: "isLoggedIn")
  }
  
  func didLogin() {
    NotificationCenter.default.post(name: Notifications.didLogin, object: nil)
  }
    
  func register(
    email: String,
    password: String,
    _ completion: @escaping (_ error: Error?) -> Void) {
    
    api.postRegisterUser(email: email, password: password) { [weak self] (success) in
      guard let self = self else { return }
      if (success) {
        self.didLogin()
      } else {
        SVProgressHUD.showDismissableError(with: "Registration failed")
      }
    }
  }
  
  func login(
    email: String,
    password: String,
    _ completion: @escaping (_ error: Error?) -> Void) {
    
    api.postLoginUser(email: email, password: password) { [weak self] (success) in
        guard let self = self else { return }
        if (success) {
          self.isLoggedIn = true
          self.didLogin()
          UserDefaults.standard.setIsLoggedIn(value: true)
        } else {
          SVProgressHUD.showDismissableError(with: "Login failed")
        }
    }
  }
  
  func logout() {
    UserDefaults.standard.setIsLoggedIn(value: false)
    NotificationCenter.default.post(name: Notifications.didLogout, object: nil)
  }
}

private extension UserDefaults {
  
  private var cachedUserKey: String {
    return "SessionService:cachedUser"
  }
  
  var cachedUser: Data? {
    set {
      set(newValue, forKey: cachedUserKey)
    }
    get {
      return data(forKey: cachedUserKey)
    }
  }
  
}

private extension UserDefaults {
  
}

