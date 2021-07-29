//
//  UIView.swift
//  NewsApp
//
//  Created by Richard John Alamer on 28/07/2021.
//  Copyright © 2021 Richard John Alamer. All rights reserved.
//

import UIKit

extension UIView {
  
  func addDropShadow(
    color: UIColor,
    opacity: Float = 0.5,
    offSet: CGSize = CGSize(width: -1, height: 1),
    radius: CGFloat = 1
  ) {
    layer.masksToBounds = false
    layer.shadowColor = color.cgColor
    layer.shadowOpacity = opacity
    layer.shadowOffset = offSet
    layer.shadowRadius = radius
    
    layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    layer.shouldRasterize = true
    layer.rasterizationScale = UIScreen.main.scale
  }

  func roundCorners(corners: UIRectCorner, radius: CGFloat) {
    let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    layer.mask = mask
  }
  
  func addBorder(
    edge: UIRectEdge,
    color: UIColor = UIColor(red:0.70, green:0.70, blue:0.70, alpha:1.0),
    thickness: CGFloat = 0.5) {
    
    let border = UIView()
    addSubview(border)
    border.translatesAutoresizingMaskIntoConstraints = false
    border.backgroundColor = color
    
    if edge == .left && edge == .right {
      border.widthAnchor.constraint(equalToConstant: thickness).isActive = true
      border.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
      border.centerYToSuperview()
    } else {
      border.heightAnchor.constraint(equalToConstant: thickness).isActive = true
      border.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
      border.centerXToSuperview()
    }
    
    switch edge {
    case .top:
      border.topAnchor.constraint(equalTo: topAnchor).isActive = true
    case .bottom:
      border.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    case .left:
      border.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
    case .right:
      border.leftAnchor.constraint(equalTo: rightAnchor).isActive = true
    default:
      border.topAnchor.constraint(equalTo: topAnchor).isActive = true
    }
  }
}

