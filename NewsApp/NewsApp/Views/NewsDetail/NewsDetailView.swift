//
//  NewsDetailView.swift
//  NewsApp
//
//  Created by Rodolfo Alamer on 28/07/2021.
//  Copyright © 2021 Richard John Alamer. All rights reserved.
//

import UIKit

class NewsDetailView: BaseView {
  
  lazy var imageView = UIImageView(image: R.image.defaultNewsImage(),
                              contentMode: .scaleAspectFill)

  override func prepare() {
    super.prepare()
    imageView.layer.cornerRadius = 5
    stack(imageView)
  }
  
  
  override func layoutSubviews() {
    super.layoutSubviews()
  }

}
