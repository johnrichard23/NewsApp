//
//  LogoutController.swift
//  NewsApp
//
//  Created by Rodolfo Alamer on 29/07/2021.
//  Copyright © 2021 Richard John Alamer. All rights reserved.
//

import UIKit
import LBTATools

protocol LogoutViewProtocol: NSObjectProtocol {
  func logout()
}

class LogoutController: LBTAFormController {
  weak var delegate: LogoutViewProtocol?
  
  private let titleLabel = UILabel(text: R.string.localizable.logoutConfirmationTitle(),
                                   font: R.font.sfProTextSemibold(size: 24),
                                   textColor: .black,
                                   textAlignment: .center, numberOfLines: 1)
  private let subtitleLabel = UILabel(text: R.string.localizable.logoutConfirmationSubtitle(),
                                      font: R.font.sfProTextRegular(size: 14),
                                      textColor: .darkGray,
                                      textAlignment: .center, numberOfLines: 2)
  private let topButton = UIButton(title: R.string.localizable.logoutTitle(),
                                   titleColor: .white,
                                   font: R.font.sfProTextSemibold(size: 16) ?? UIFont.systemFont(ofSize: 16),
                                   backgroundColor: .blue,
                                   target: self, action: #selector(handleTopButton))
  private let bottomButton = UIButton(title: R.string.localizable.cancel(),
                                      titleColor: .blue,
                                      font: R.font.sfProTextSemibold(size: 16) ?? UIFont.systemFont(ofSize: 16),
                                      backgroundColor: .white,
                                      target: self, action: #selector(handleBottomButton))
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  private func setup() {
    view.layer.cornerRadius = 20
    
    let headerStackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
    headerStackView.axis = .vertical
    headerStackView.distribution = .fillEqually
    headerStackView.constrainHeight(55)
    
    let buttonsStackView = UIStackView(arrangedSubviews: [topButton, bottomButton])
    buttonsStackView.distribution = .fillEqually
    buttonsStackView.axis = .vertical
    buttonsStackView.spacing = 10
    buttonsStackView.constrainHeight(100)
    topButton.layer.cornerRadius = 6
    bottomButton.layer.cornerRadius = 6
    bottomButton.layer.borderWidth = 2
    
    formContainerStackView.stack(headerStackView, buttonsStackView, spacing: 20).withMargins(.allSides(20))
  }
}

extension LogoutController {
  @objc private func handleTopButton() {
    dismiss(animated: true)
    delegate?.logout()
  }
  
  @objc private func handleBottomButton() {
    dismiss(animated: true)
  }
}

