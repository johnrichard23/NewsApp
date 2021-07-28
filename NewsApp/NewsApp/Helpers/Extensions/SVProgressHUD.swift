//
//  SVProgressHUD.swift
//  NewsApp
//
//  Created by Rodolfo Alamer on 28/07/2021.
//  Copyright © 2021 Richard John Alamer. All rights reserved.
//

import Foundation
import SVProgressHUD

/// Ref: https://stackoverflow.com/a/41111242/425694
public extension SVProgressHUD {
  
  static func showDismissableError(with status: String) {
    addHUDNotificationObservers()
    SVProgressHUD.showError(withStatus: status)
    SVProgressHUD.setDefaultMaskType(.clear)
  }
  
  static func showDismissableInfo(with status: String) {
    addHUDNotificationObservers()
    SVProgressHUD.showInfo(withStatus: status)
    SVProgressHUD.setDefaultMaskType(.clear)
  }
  
  private static func addHUDNotificationObservers() {
    let nc = NotificationCenter.default
    nc.addObserver(
      self, selector: #selector(hudTapped(_:)),
      name: NSNotification.Name.SVProgressHUDDidReceiveTouchEvent,
      object: nil
    )
    nc.addObserver(
      self, selector: #selector(hudDisappeared(_:)),
      name: NSNotification.Name.SVProgressHUDWillDisappear,
      object: nil
    )
  }
  
  @objc
  private static func hudTapped(_ notification: Notification) {
    SVProgressHUD.dismiss()
    SVProgressHUD.setDefaultMaskType(.none)
  }
  
  @objc
  private static func hudDisappeared(_ notification: Notification) {
    let nc = NotificationCenter.default
    nc.removeObserver(self, name: NSNotification.Name.SVProgressHUDDidReceiveTouchEvent, object: nil)
    nc.removeObserver(self, name: NSNotification.Name.SVProgressHUDWillDisappear, object: nil)
    SVProgressHUD.setDefaultMaskType(.none)
  }
  
}
