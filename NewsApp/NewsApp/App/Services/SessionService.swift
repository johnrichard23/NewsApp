//
//  SessionService.swift
//  NewsApp
//
//  Created by Rodolfo Alamer on 28/07/2021.
//  Copyright © 2021 Richard John Alamer. All rights reserved.
//

import Foundation

class SessionService {
  
  struct Notifications {
    static let didLogin = Notification.Name("didLogin")
    static let didLogout = Notification.Name("didLogout")
  }
  
  private(set) var api: APIClient
  
  var user: User? {
    didSet {
      UserDefaults.standard.cachedUser = try? user.encoded()
      UserDefaults.standard.synchronize()
    }
  }
  
  var userId: Int {
    return user?.id ?? 0
  }
  
  var isLoggedIn: Bool {
    return user != nil
  }
  
  init(api: APIClient) {
    self.api = api
    self.user = try! UserDefaults.standard.cachedUser?.decoded()
  }
  
}

// MARK: Public
extension SessionService {
  
  func didLogin() {
    NotificationCenter.default.post(name: Notifications.didLogin, object: nil)
  }
  
//  func loginAsGuest() {
//    UserDefaults.standard.loggedInAsGuest = true
//    didLogin()
//  }
//  
//  func register(
//    email: String,
//    password: String,
//    _ completion: @escaping (_ error: Error?) -> Void) {
//    api.postRegisterUser(email: email, password: password, loginHandler(completion))
//  }
//  
//  func login(
//    email: String,
//    password: String,
//    _ completion: @escaping (_ error: Error?) -> Void) {
//    api.postLoginUser(email: email, password: password, loginHandler(completion))
//  }
//  
//  private func loginHandler(_ completion: @escaping (_ error: Error?) -> Void) -> APIClientLoginClosure {
//    return { user, token, error in
//      guard let user = user, let token = token, error == nil else {
//        return completion(error)
//      }
//      debugPrint("test", user)
//      self.user = user
//      self.api.accessToken = token
//      completion(nil)
//      
//      self.didUpdateProfile(user)
//      NotificationCenter.default.post(name: SessionService.Notifications.didUpdateProfile,
//                                      object: nil)
//      
//      self.didLogin()
//    }
//  }
  
  func logout() {
    user = nil
//    api.accessToken = nil
    UserDefaults.standard.loggedInAsGuest = false
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
  
  private var loggedInAsGuestKey: String {
    return "SessionService:loggedInAsGuest"
  }
  
  var loggedInAsGuest: Bool {
    set {
      set(newValue, forKey: loggedInAsGuestKey)
    }
    get {
      return bool(forKey: loggedInAsGuestKey)
    }
  }
  
}

