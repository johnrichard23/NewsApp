//
//  NewsDetailController.swift
//  NewsApp
//
//  Created by Richard John Alamer on 27/07/2021.
//  Copyright © 2021 Richard John Alamer. All rights reserved.
//

import UIKit
import LBTATools

class NewsDetailController: UIViewController {

  var author: String = ""
  var publishedDate: String = ""
  var avatarURL: String = ""
  var newsImageView = NewsDetailView()
  
  override func viewDidLoad() {
      super.viewDidLoad()
        setup()
    }
  
  private func setup() {
    setupNavBar()
    setupData()
  }
  
  private func setupData() {
    guard let url = URL(string: self.avatarURL) else { return }
    
    if url.absoluteString == "" {
        let image : UIImage = UIImage(named: "placeholder.png")!
          
        let imageView = UIImageView(image: image)
          imageView.frame = CGRect(x: 0, y: 0, width: 375, height: 180)
          newsImageView.addSubview(imageView)
          newsImageView.bringSubviewToFront(imageView)
    } else {
        let data = try? Data(contentsOf: url)
    
        if let imageData = data {
          let image = UIImage(data: imageData)
          let imageView = UIImageView(image: image!)
          imageView.frame = CGRect(x: 0, y: 0, width: 375, height: 180)
          newsImageView.addSubview(imageView)
          newsImageView.bringSubviewToFront(imageView)
        }
    }
    
    let dateFormatter = ISO8601DateFormatter()
    guard let date = dateFormatter.date(from: self.publishedDate) else { return }
    let dateString = dateFormatter.string(from: date)
    
    let dateTitleLabel = UILabel(text: R.string.localizable.datePublishedTitle(),
                         font: R.font.montserratMedium(size: 12),
                         textColor: .black,
                         textAlignment: .left,
                         numberOfLines: 1)
    
    let dateLabel = UILabel(text: String(dateString),
                         font: R.font.montserratMedium(size: 10),
                         textColor: .gray,
                         textAlignment: .left,
                         numberOfLines: 2)
    
    
    let dateTitleView = view.hstack(dateTitleLabel,
                                    dateLabel,
                                   spacing: 1)
    
    view.stack(newsImageView.withHeight(180),
               dateTitleView,
               UIView(),
               spacing: 10,
               alignment: .fill, distribution: .fill).withMargins(.allSides(20))
    
    
  }

  private func setupNavBar() {
    navigationItem.title = self.author
    navigationController?.navigationBar.backgroundColor = .white
    navigationController?.view.backgroundColor = UIColor.white
    navigationController?.navigationBar.isTranslucent = false
    navigationController?.navigationBar.prefersLargeTitles = false
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationItem.customLeftBarButton(withImage: "backIcon") { [weak self] _ in
        self?.dismiss(animated: true)
    }
    
  }

}
