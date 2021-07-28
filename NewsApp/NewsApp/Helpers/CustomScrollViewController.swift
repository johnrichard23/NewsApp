//
//  CustomScrollViewController.swift
//  NewsApp
//
//  Created by Rodolfo Alamer on 28/07/2021.
//  Copyright © 2021 Richard John Alamer. All rights reserved.
//

import UIKit
import PureLayout

open class CustomScrollViewController: UIViewController {
  
  @IBOutlet open weak var scrollView: UIScrollView!
  @IBOutlet open weak var contentView = UIView()
  
  deinit {
    print("deinit - ScrollViewController")
  }
  
  open override func viewDidLoad() {
    super.viewDidLoad()
    
    if #available(iOS 11.0, *) {
      scrollView.contentInsetAdjustmentBehavior = .automatic
    }
    
    if view.backgroundColor == nil {
      view.backgroundColor = .white
    }
    if scrollView.superview == nil {
      view.addSubview(scrollView)
      if #available(iOS 11.0, *) {
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
      } else {
        scrollView.autoPinEdge(toSuperviewEdge: .left)
        scrollView.autoPinEdge(toSuperviewEdge: .right)
        scrollView.autoPinEdge(toSuperviewMargin: .top)
        scrollView.autoPinEdge(toSuperviewMargin: .bottom)
      }
    }
    if let contentView = contentView, contentView.superview == nil {
      scrollView.insertSubview(contentView, at: 0)
      contentView.autoMatch(.width, to: .width, of: view)
      contentView.autoPinEdge(toSuperviewEdge: .left)
      contentView.autoPinEdge(toSuperviewEdge: .right)
      contentView.autoPinEdge(toSuperviewMargin: .top)
      contentView.autoPinEdge(toSuperviewMargin: .bottom)
    }
    
    scrollView.alwaysBounceVertical = true
    scrollView.keyboardDismissMode = .interactive
    addKeyboardVisibilityEventObservers()
  }
  
  // MARK: - Interactive Keyboard Dismissal For UIScrollView
  // Ref: https://realm.io/news/tmi-scrollview-for-keyboards/
  
  /// Register to be notified if the keyboard is changing size
  open func addKeyboardVisibilityEventObservers() {
    NotificationCenter.default
      .addObserver(self,
                   selector: #selector(keyboardWillShowOrHideHandler(_:)),
                   name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default
      .addObserver(self,
                   selector: #selector(keyboardWillShowOrHideHandler(_:)),
                   name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  @objc open func keyboardWillShowOrHideHandler(_ notification: NSNotification) {
    
    // Pull a bunch of info out of the notification
    if let scrollView = scrollView,
      let userInfo = notification.userInfo,
      let endValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey],
      let durationValue = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] {
      
      // Transform the keyboard's frame into our view's coordinate system
      let endRect = view.convert((endValue as AnyObject).cgRectValue, from: view.window)
      
      // Find out how much the keyboard overlaps the scroll view
      // We can do this because our scroll view's frame is already in our view's coordinate system
      let keyboardOverlap = scrollView.frame.maxY - endRect.origin.y + 16
      
      // Set the scroll view's content inset to avoid the keyboard
      // Don't forget the scroll indicator too!
      scrollView.contentInset.bottom = keyboardOverlap
      scrollView.scrollIndicatorInsets.bottom = keyboardOverlap
      
      let duration = (durationValue as AnyObject).doubleValue
      UIView.animate(withDuration: duration!, delay: 0, options: .beginFromCurrentState, animations: {
        self.view.layoutIfNeeded()
      }, completion: nil)
    }
  }
  
}
