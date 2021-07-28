//
//  TransparentNavController.swift
//  NewsApp
//
//  Created by Rodolfo Alamer on 27/07/2021.
//  Copyright © 2021 Richard John Alamer. All rights reserved.
//

import UIKit

class TransparentNavController: UINavigationController {

    init(title: String, rootViewController: UIViewController, prefersLargeTitle: Bool = false) {
        super.init(rootViewController: rootViewController)
        self.navigationItem.title = title
        if #available(iOS 11.0, *) {
            self.navigationBar.prefersLargeTitles = prefersLargeTitle
        } else {
            
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
      super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.backgroundColor = .white
        view.backgroundColor = .white
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = .white
        navigationBar.shadowImage = UIImage()
        navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
}

