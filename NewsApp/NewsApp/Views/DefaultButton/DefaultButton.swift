//
//  DefaultButton.swift
//  NewsApp
//
//  Created by Richard John Alamer on 28/07/2021.
//  Copyright © 2021 Richard John Alamer. All rights reserved.
//

import Foundation
import UIKit

class DefaultButton: UIButton {
  @IBInspectable var customImage: UIImage? = nil {
    didSet {
      guard let ci = customImage else { return }
      
      let iv = UIImageView()
      iv.setContentHuggingPriority(.defaultHigh, for: .horizontal)
      iv.setContentHuggingPriority(.defaultHigh, for: .vertical)
      iv.image = ci
      addSubview(iv)
      iv.autoPinEdge(toSuperviewEdge: .left, withInset: 16)
      iv.autoAlignAxis(toSuperviewAxis: .horizontal)
    }
  }
}

class DefaultButtonOutlined: DefaultButton {
  @IBInspectable var outlineColor: UIColor = .black {
    didSet {
      titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
      setTitleColor(outlineColor, for: .normal)
      layer.borderColor = outlineColor.cgColor
      layer.borderWidth = 1.5
      layer.cornerRadius = 6
      layer.masksToBounds = true
    }
  }
}

class DefaultButtonFilled: DefaultButton {
  @IBInspectable var fillColor: UIColor = .black {
    didSet {
      backgroundColor = fillColor
      titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
      setTitleColor(.white, for: .normal)
      layer.cornerRadius = 6
      layer.masksToBounds = true
    }
  }
}

