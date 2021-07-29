//
//  DefaultTextInputControllerOutlined.swift
//  NewsApp
//
//  Created by Rodolfo Alamer on 28/07/2021.
//  Copyright © 2021 Richard John Alamer. All rights reserved.
//

import Foundation
import MaterialComponents.MaterialTextFields

class DefaultTextInputControllerOutlined: MDCTextInputControllerOutlined {
  override init() {
    super.init()
  }
  
  required init(textInput input: (UIView & MDCTextInput)?) {
    super.init(textInput: input)
    activeColor = UIColor.lightGray
    normalColor = UIColor.lightGray
    floatingPlaceholderActiveColor = UIColor.gray
    floatingPlaceholderNormalColor = UIColor.lightGray
  }
}
