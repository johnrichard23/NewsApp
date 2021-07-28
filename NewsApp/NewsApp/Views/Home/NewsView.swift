//
//  NewsView.swift
//  NewsApp
//
//  Created by Rodolfo Alamer on 28/07/2021.
//  Copyright © 2021 Richard John Alamer. All rights reserved.
//

import UIKit

class NewsView: BaseView {
  
  lazy var imageView = UIImageView(image: R.image.placeholder(),
                              contentMode: .scaleAspectFill)
  
  let countryNameLabel = UILabel(text: "Country Name Here",
                          font: R.font.sfProTextSemibold(size: 16),
                          textColor: .white)
  let gradientLayer = CAGradientLayer()
  
  override func prepare() {
    super.prepare()
    imageView.layer.cornerRadius = 10
    stack(imageView)
    setupGradientLayer()
    stack(UIView(),
          countryNameLabel).withMargins(.allSides(8))
  }
  
  private func setupGradientLayer() {
    gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
    gradientLayer.locations = [0.7, 1.1]
    layer.cornerRadius = 10
    clipsToBounds = true
    layer.addSublayer(gradientLayer)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    gradientLayer.frame = bounds
  }

}
