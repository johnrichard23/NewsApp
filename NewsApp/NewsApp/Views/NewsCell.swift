//
//  NewsCell.swift
//  NewsApp
//
//  Created by Rodolfo Alamer on 28/07/2021.
//  Copyright © 2021 Richard John Alamer. All rights reserved.
//

import UIKit
import LBTATools

class NewsCell: LBTAListCell<NewsArticles> {
  let authorNameLabel = UILabel(font: R.font.sfProTextSemibold(size: 18),
                          textColor: UIColor.black)
  let titleLabel = UILabel(font: R.font.sfProTextRegular(size: 12),
                              textColor: UIColor.gray)
  let border = UIView(backgroundColor: .lightGray).withHeight(0.5)
  
  var avatarImgView = UIImageView(image: R.image.defaultNewsImage(),
                                  contentMode: .scaleAspectFill).withWidth(100).withHeight(100)
  
  override var item: NewsArticles! {
    didSet {
      
      if item.author.isEmpty {
        authorNameLabel.text = "No Author"
      } else {
        authorNameLabel.text = item.author
      }
      
      if item.title.isEmpty {
        titleLabel.text = "No Title"
      } else {
        titleLabel.text = item.title
      }
      
      guard let url = URL(string: item.avatarURL) else { return }
      
      if url.absoluteString == "" {
            
          let image : UIImage = UIImage(named: "placeholder.png")!
              
          let imageView = UIImageView(image: image)
            imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
            avatarImgView.addSubview(imageView)
            avatarImgView.bringSubviewToFront(imageView)
      } else {
      
        let data = try? Data(contentsOf: url)
      
          if let imageData = data {
            let image = UIImage(data: imageData)
            let imageView = UIImageView(image: image!)
            imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
            avatarImgView.addSubview(imageView)
            avatarImgView.bringSubviewToFront(imageView)
        }
      }
    }
  }

  override func setupViews() {
    super.setupViews()
    
    titleLabel.numberOfLines = 0
    
    stack(hstack(avatarImgView,
                 stack(UIView(),
                       authorNameLabel,
                       titleLabel,
                       UIView(), spacing: 2),
                 spacing: 10, alignment: .center).withMargins(.init(top: 0,
                                                                    left: 10,
                                                                    bottom: 0,
                                                                    right: 10)), border)
  }
}
