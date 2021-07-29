//
//  LoginController.swift
//  NewsApp
//
//  Created by Rodolfo Alamer on 28/07/2021.
//  Copyright © 2021 Richard John Alamer. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SVProgressHUD
import XLPagerTabStrip
import MaterialComponents.MaterialTextFields

class LoginController: CustomScrollViewController {
  @IBOutlet weak var emailTextField: MDCTextField!
  @IBOutlet weak var passwordTextField: MDCTextField!
  
  private var emailTextFieldController: MDCTextInputControllerOutlined!
  private var passwordTextFieldController: MDCTextInputControllerOutlined!
  
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
}

extension LoginController {
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

extension LoginController {
  @IBAction func loginButtonTapped(_ sender: Any) {
    guard let email = emailTextField.text?.trimmed, email.isEmail else {
      return emailTextFieldController.presentPopoverError(with: "Please enter a valid email address")
    }
    
    guard let password = passwordTextField.text, !password.isEmpty else {
      return passwordTextFieldController.presentPopoverError(with: "Please enter your password")
    }
    
    SVProgressHUD.show()
    App.shared.sessionService.login(email: email, password: password) { error in
      if let error = error {
        return SVProgressHUD.showDismissableError(with: error.localizedDescription)
      }
      SVProgressHUD.dismiss()
    }
  }
}

extension LoginController: IndicatorInfoProvider {
  func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
    return IndicatorInfo(title: "Log In")
  }
}

