//
//  MDCTextInputControllerBase.swift
//  NewsApp
//
//  Created by Rodolfo Alamer on 28/07/2021.
//  Copyright © 2021 Richard John Alamer. All rights reserved.
//

import Foundation
import UIKit

import Popover
import MaterialComponents.MaterialTextFields

extension MDCTextInputControllerBase {
  
  func presentPopoverError(with message: String, sideInsets: CGFloat? = nil) {
    
    guard let textInput = textInput else { return }
    
    // Focus text input field
    textInput.becomeFirstResponder()
    
    // Setup label
    let label = UILabel()
    label.textColor = .white
    label.textAlignment = .center
    label.font = R.font.montserratMedium(size: 13)
    label.text = message
    label.sizeToFit()
    
    // Calculate dimensions
    var width = textInput.frame.size.width
    if let sideInsets = sideInsets {
      width = UIScreen.main.bounds.width - (sideInsets * 2)
    }
    let height = max(label.frame.size.height, 50)
    let adjustedFrame = CGRect(x: 0, y: 0, width: width, height: height)
    label.frame = adjustedFrame
    
    // Setup options
    let options = [
      .type(.up),
      .showBlackOverlay(false),
      .color(activeColor),
      .animationIn(0.3),
      ] as [PopoverOption]
    
    // Present popover
    let popover = Popover(options: options, showHandler: nil, dismissHandler: nil)
    popover.show(label, fromView: textInput)
  }
  
}
