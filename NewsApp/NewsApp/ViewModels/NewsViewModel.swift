//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Rodolfo Alamer on 28/07/2021.
//  Copyright © 2021 Richard John Alamer. All rights reserved.
//

import UIKit
import LBTATools
import SVProgressHUD

protocol NewsViewModelType {
  var delegate: NewsViewModelTypeDelegate? { get set }
  func refreshData(countryId: String)
}

protocol NewsViewModelTypeDelegate: AnyObject {
  func viewModel(_ viewModel: NewsViewModelType, didFetchData data: [NewsArticles])
  func viewModel(_ viewModel: NewsViewModelType, didEncounter error: Error)
}

class NewsViewModel: NewsViewModelType {
  
  weak var delegate: NewsViewModelTypeDelegate?
  private let api: APIClient
  private var newsList: [NewsArticles] = []
  
  init(api: APIClient = App.shared.api) {
    self.api = api
  }
  
  func refreshData(countryId: String) {
      SVProgressHUD.show()
      
    api.getNews(country: countryId, category: "business", apiKey: "f206dc889f1246f795eeef91030c5862") { [weak self] (news, error) in
      guard let weakSelf = self, let delegate = weakSelf.delegate else { return }

          guard let error = error else {
              if let news = news {
                  debugPrint("News List:", news)
                    weakSelf.newsList = news
                    weakSelf.delegate?.viewModel(weakSelf, didFetchData:
                    weakSelf.newsList)
              }
            
            SVProgressHUD.dismiss()
              return
          }
      delegate.viewModel(weakSelf, didEncounter: error)
      }
  }

}
