//
//  BaseView.swift
//  NewsApp
//
//  Created by Richard John Alamer on 28/07/2021.
//  Copyright © 2021 Richard John Alamer. All rights reserved.
//

import UIKit

class BaseView: UIView {
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.prepare()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    prepare()
  }
  
  func prepare() {
    // Do additional setups here.
  }
}

