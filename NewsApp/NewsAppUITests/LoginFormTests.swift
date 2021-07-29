//
//  LoginFormTests.swift
//  NewsAppUITests
//
//  Created by Rodolfo Alamer on 29/07/2021.
//  Copyright © 2021 Richard John Alamer. All rights reserved.
//

import XCTest

@testable import NewsApp

class LoginFormTests: BaseLoginFormTestCase {

  func testEmailFormUsingUnregisteredEmailAddress() {
    // Find the Email field and supply the unregistered email address.
    let emailTextField = app.textFields["Email"]
    XCTAssertTrue(emailTextField.exists && emailTextField.isHittable)
    emailTextField.tap()
    emailTextField.typeText("test@gmail.com")

    dismissKeyboard()

    let startButton = app.buttons["Next"]
    XCTAssertTrue(startButton.exists && startButton.isHittable)
    startButton.tap()

    // Assert that we're at the Registration screen.
    XCTAssertTrue(app.navigationBars["Create Account"].exists)
  }
  
  func testEmailFormUsingRegisteredEmailAddress() {
    fillEmailFormWithRegisteredEmailAddressAndHitNextButton()
    
    XCTAssertTrue(app.secureTextFields["Password"].exists)
    XCTAssertTrue(app.buttons["Login"].exists)
  }

  func testLoginFormUsingInvalidPassword() {
    fillEmailFormWithRegisteredEmailAddressAndHitNextButton()
    
    let passwordTextField = app.secureTextFields["Password"]
    XCTAssertTrue(passwordTextField.exists && passwordTextField.isHittable)
    passwordTextField.tap()
    passwordTextField.typeText("!@#$!@#$")
    
    let loginButton = app.buttons["Login"]
    XCTAssertTrue(loginButton.exists && loginButton.isHittable)
    loginButton.tap()
    
    // TODO Assert alert message
  }
  
  func testLoginFormUsingValidPassword() {
    fillEmailFormWithRegisteredEmailAddressAndHitNextButton()

    let passwordTextField = app.secureTextFields["Password"]
    XCTAssertTrue(passwordTextField.exists && passwordTextField.isHittable)
    passwordTextField.tap()
    passwordTextField.typeText("test123")

    let loginButton = app.buttons["Login"]
    XCTAssertTrue(loginButton.exists && loginButton.isHittable)
    loginButton.tap()
  }
  
}
