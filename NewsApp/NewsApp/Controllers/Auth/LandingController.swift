//
//  LandingController.swift
//  NewsApp
//
//  Created by Rodolfo Alamer on 28/07/2021.
//  Copyright © 2021 Richard John Alamer. All rights reserved.
//

import Foundation
import UIKit
import XLPagerTabStrip

class LandingController: ButtonBarPagerTabStripViewController {
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  override func viewDidLoad() {
    setup()
    super.viewDidLoad()
    view.layoutIfNeeded()
  }
  
  override func moveToViewController(at index: Int, animated: Bool) {
    super.moveToViewController(at: index, animated: false)
  }
  
  override func moveTo(viewController: UIViewController, animated: Bool) {
    super.moveTo(viewController: viewController, animated: false)
  }
  
  override public func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
    return [
      R.storyboard.auth.loginController()!,
      R.storyboard.auth.signUpController()!
    ]
  }
}

extension LandingController {
  private func setup() {
    setupNavBar()
    setupButtonBar()
  }
  
  private func setupNavBar() {
    navigationController?.isNavigationBarHidden = true
  }
  
  private func setupButtonBar() {
    settings.style.buttonBarBackgroundColor = .clear
    settings.style.buttonBarItemBackgroundColor = .clear
    settings.style.buttonBarItemTitleColor = .white
    settings.style.selectedBarBackgroundColor = .white
    settings.style.buttonBarItemFont = .systemFont(ofSize: 20)
    settings.style.selectedBarHeight = 8.0
    settings.style.buttonBarItemsShouldFillAvailableWidth = true
    
    changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?,
                                      newCell: ButtonBarViewCell?,
                                      progressPercentage: CGFloat,
                                      changeCurrentIndex: Bool,
                                      animated: Bool) -> Void in
      guard changeCurrentIndex else { return }
      
      oldCell?.label.font = .systemFont(ofSize: 20)
      newCell?.label.font = .boldSystemFont(ofSize: 20)
    }
  }
}

