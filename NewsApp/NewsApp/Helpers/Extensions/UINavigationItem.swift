//
//  UINavigationItem.swift
//  NewsApp
//
//  Created by Richard John Alamer on 28/07/2021.
//  Copyright © 2021 Richard John Alamer. All rights reserved.
//

import Foundation
import UIKit

typealias LeftBarBlock = ((_ status: Bool) -> Void)

private class LeftBarWrapper {
  var leftClosure: LeftBarBlock?
  
  init(_ closure: LeftBarBlock?) {
    self.leftClosure = closure
  }
}

private var icAssociationKeyLeftBar: UInt8 = 0

extension UINavigationItem {
    
    private var actionLeftBarAction: LeftBarBlock? {
        get {
          let wrapper = objc_getAssociatedObject(self, &icAssociationKeyLeftBar) as? LeftBarWrapper
          return wrapper?.leftClosure
        }
        set(newValue) {
          objc_setAssociatedObject(self,
                                   &icAssociationKeyLeftBar,
                                   LeftBarWrapper(newValue),
                                   .OBJC_ASSOCIATION_RETAIN)
        }
      }
    
    func customLeftBarButton(withImage imgName: String, completion: @escaping LeftBarBlock) {
      actionLeftBarAction = completion
      
      let image = UIImage(named: imgName)
      let leftBtn = UIButton(type: .custom)
      
      leftBtn.setImage(image, for: .normal)
      leftBtn.setImage(image, for: .highlighted)
      leftBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0.0)
      leftBtn.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
      leftBtn.addTarget(self, action: #selector(leftBarItemTapped), for: .touchUpInside)
      leftBtn.widthAnchor.constraint(equalToConstant: 25.0).isActive = true
      leftBtn.heightAnchor.constraint(equalToConstant: 25.0).isActive = true
      
      let leftBtnItem = UIBarButtonItem(customView: leftBtn)
      self.leftBarButtonItem = leftBtnItem
    }
    
    @objc func leftBarItemTapped() {
        actionLeftBarAction!(true)
    }
}

