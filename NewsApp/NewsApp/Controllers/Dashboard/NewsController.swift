//
//  NewsController.swift
//  NewsApp
//
//  Created by Richard John Alamer on 27/07/2021.
//  Copyright © 2021 Richard John Alamer. All rights reserved.
//

import UIKit
import LBTATools
import SVProgressHUD

class NewsController: LBTAListController<NewsCell, NewsArticles>, UICollectionViewDelegateFlowLayout {
  var viewModel: NewsViewModel!
  var newsId: String = ""
  private let refreshControl = UIRefreshControl()

  override func viewDidLoad() {
      super.viewDidLoad()
      setup()
  }
  
  override var items: [NewsArticles] {
    didSet {
      collectionView.reloadData()
    }
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    return .init(width: view.frame.width, height: 140)
  }
  
  override func collectionView(_ collectionView: UICollectionView,
                                 didSelectItemAt indexPath: IndexPath) {
    let vc = NewsDetailController()
    
    let newsAuthor = items[indexPath.row].author
    let newsAvatar = items[indexPath.row].avatarURL
    let publishedDate = items[indexPath.row].publishedDate
    
    if newsAuthor.isEmpty {
      vc.author = "No author Available"
    } else {
      vc.author = newsAuthor
    }
    if newsAvatar == "" {
      vc.avatarURL = ""
    } else {
      vc.avatarURL = newsAvatar
    }
    if publishedDate.isEmpty {
      vc.publishedDate = "No published date available"
    } else {
      vc.publishedDate = publishedDate
    }
    
    let navigationVC = NavigationController(rootViewController: vc)
    navigationVC.modalPresentationStyle = .fullScreen
    present(navigationVC, animated: true)
  }
}

extension NewsController {
  
  private func setup() {
    viewModel = NewsViewModel()
    viewModel.delegate = self
    viewModel.refreshData(countryId: self.newsId)
    
    
    collectionView.showsVerticalScrollIndicator = false
    setupNavBar()
    
    // Add Refresh Control to Collection View
    if #available(iOS 10.0, *) {
        collectionView.refreshControl = refreshControl
    } else {
        collectionView.addSubview(refreshControl)
    }
    
    refreshControl.attributedTitle = NSAttributedString(string: "Fetching News...", attributes: nil)
    refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
    refreshControl.addTarget(self, action: #selector(refreshCollectionViewData), for: .valueChanged)
  }

  private func setupNavBar() {
    
    if self.newsId == "US" {
      navigationItem.title = R.string.localizable.usNewsHeadlineTitle()
    } else {
      navigationItem.title = R.string.localizable.canadaNewsHeadlineTitle()
    }
    navigationController?.navigationBar.backgroundColor = .white
    navigationController?.view.backgroundColor = UIColor.white
    navigationController?.navigationBar.isTranslucent = false
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationItem.customLeftBarButton(withImage: "backIcon") { [weak self] _ in
        self?.dismiss(animated: true)
    }
  }
  
  @objc private func refreshCollectionViewData(_ sender: Any) {
    viewModel.refreshData(countryId: self.newsId)
    self.refreshControl.endRefreshing()
  }
}

extension NewsController: NewsViewModelTypeDelegate {
  func viewModel(_ viewModel: NewsViewModelType, didFetchData data: [NewsArticles]) {
    self.items = data
  }
  
  func viewModel(_ viewModel: NewsViewModelType, didEncounter error: Error) {
    DispatchQueue.main.async {
      SVProgressHUD.showDismissableError(with: error.localizedDescription)
    }
  }
}
