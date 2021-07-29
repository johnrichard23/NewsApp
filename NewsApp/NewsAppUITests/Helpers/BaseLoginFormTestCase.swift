//
//  BaseLoginFormTestCase.swift
//  NewsAppUITests
//
//  Created by Rodolfo Alamer on 29/07/2021.
//  Copyright © 2021 Richard John Alamer. All rights reserved.
//

import XCTest

@testable import NewsApp

class BaseLoginFormTestCase: BaseTestCase {
  
  func fillEmailFormWithRegisteredEmailAddressAndHitNextButton() {
    
    // Find the Email field and supply the registered email address.
    let emailTextField = app.textFields["Email"]
    XCTAssertTrue(emailTextField.exists && emailTextField.isHittable)
    emailTextField.tap()
    emailTextField.typeText("example@domain.com")
    
    dismissKeyboard()
    
    let loginButton = app.buttons["Login"]
    XCTAssertTrue(loginButton.exists && loginButton.isHittable)
    loginButton.tap()
    
    XCTAssertTrue(app.buttons["Login"].exists)
  }
  
}
