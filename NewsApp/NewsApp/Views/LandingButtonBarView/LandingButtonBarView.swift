//
//  LandingButtonBarView.swift
//  NewsApp
//
//  Created by Richard John Alamer on 28/07/2021.
//  Copyright © 2021 Richard John Alamer. All rights reserved.
//

import Foundation
import UIKit
import XLPagerTabStrip

class LandingButtonBarView: ButtonBarView {
  override func moveTo(index: Int, animated: Bool, swipeDirection: SwipeDirection, pagerScroll: PagerScroll) {
    super.moveTo(index: index, animated: animated, swipeDirection: swipeDirection, pagerScroll: pagerScroll)
    updateRoundedCorners(basedOn: index)
  }
  
  private func updateRoundedCorners(basedOn nextIndex: Int) {
    let roundedCorners: UIRectCorner = (nextIndex == 0) ? [.topRight] : [.topLeft]
    selectedBar.roundCorners(corners: roundedCorners, radius: frame.size.height * 2)
  }
}
