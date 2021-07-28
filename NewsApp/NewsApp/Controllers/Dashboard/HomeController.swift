//
//  HomeController.swift
//  NewsApp
//
//  Created by Rodolfo Alamer on 27/07/2021.
//  Copyright © 2021 Richard John Alamer. All rights reserved.
//

import UIKit
import LBTATools
import SVProgressHUD

class HomeController: UIViewController {
  
  var usNewsView = NewsView()
  var canadaNewsView = NewsView()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
  func setup() {
    setupNavBar()
    usNewsView.layer.cornerRadius = 10
    canadaNewsView.layer.cornerRadius = 10
    
    usNewsView.countryNameLabel.text = R.string.localizable.homeUSTitleName()
    canadaNewsView.countryNameLabel.text = R.string.localizable.homeCanadaTitleName()
    
    usNewsView.imageView.image = R.image.usaNewsBackground()
    canadaNewsView.imageView.image = R.image.canadaNewsBackground()
    
    let usNewsViewtapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapUSNewsView))
    usNewsView.addGestureRecognizer(usNewsViewtapGesture)
    
    let canadaNewsViewtapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapCanadaNewsView))
    canadaNewsView.addGestureRecognizer(canadaNewsViewtapGesture)
    
    view.stack(usNewsView.withHeight(180),
               canadaNewsView.withHeight(180),
               UIView(),
               spacing: 30,
               alignment: .fill, distribution: .fill).withMargins(.allSides(20))
  }
  
  func setupNavBar() {
    view.backgroundColor = .white
    navigationItem.title = R.string.localizable.homeTitleName()
    navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  @objc func didTapUSNewsView() {
    let vc = NewsController()
    vc.newsId = R.string.localizable.usNewsTitle()
    let navigationVC = NavigationController(rootViewController: vc)
    navigationVC.modalPresentationStyle = .fullScreen
    present(navigationVC, animated: true)
  }
  
  @objc func didTapCanadaNewsView() {
    let vc = NewsController()
    vc.newsId = R.string.localizable.canadaNewsTitle()
    let navigationVC = NavigationController(rootViewController: vc)
    navigationVC.modalPresentationStyle = .fullScreen
    present(navigationVC, animated: true)
  }
}
