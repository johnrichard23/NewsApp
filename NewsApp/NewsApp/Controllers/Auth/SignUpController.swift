//
//  SignUpController.swift
//  NewsApp
//
//  Created by Richard John Alamer on 28/07/2021.
//  Copyright © 2021 Richard John Alamer. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD
import XLPagerTabStrip
import MaterialComponents.MaterialTextFields

class SignUpController: CustomScrollViewController {
  @IBOutlet weak var emailTextField: MDCTextField!
  @IBOutlet weak var passwordTextField: MDCTextField!
  
  private var emailTextFieldController: MDCTextInputControllerOutlined!
  private var passwordTextFieldController: MDCTextInputControllerOutlined!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
}

extension SignUpController {
  private func setup() {
    setupTextFields()
  }
  
  private func setupTextFields() {
    emailTextFieldController = DefaultTextInputControllerOutlined(textInput: emailTextField)
    passwordTextFieldController = DefaultTextInputControllerOutlined(textInput: passwordTextField)
    setupPasswordTextField()
  }
  
  private func setupPasswordTextField() {
    passwordTextField.autocorrectionType = .no
    passwordTextField.textContentType = UITextContentType(rawValue: "unspecified")
    passwordTextField.clearButtonMode = .never
  }
}

extension SignUpController {
  @IBAction func createAccountButtonTapped(_ sender: Any) {
    guard let email = emailTextField.text?.trimmed, email.isEmail else {
      return emailTextFieldController.presentPopoverError(with: "Please enter a valid email address")
    }
    
    guard let password = passwordTextField.text, !password.isEmpty else {
      return passwordTextFieldController.presentPopoverError(with: "Please enter a password")
    }
    
    SVProgressHUD.show()
    App.shared.sessionService.register(email: email, password: password) { error in
      if let error = error {
        return SVProgressHUD.showDismissableError(with: error.localizedDescription)
      }
      SVProgressHUD.dismiss()
    }
  }
}

extension SignUpController: IndicatorInfoProvider {
  func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
    return IndicatorInfo(title: "Sign Up")
  }
}
