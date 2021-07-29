//
//  BaseTestCase.swift
//  NewsAppUITests
//
//  Created by Rodolfo Alamer on 29/07/2021.
//  Copyright © 2021 Richard John Alamer. All rights reserved.
//

import XCTest

@testable import NewsApp

class BaseTestCase: XCTestCase {
  
  var app: XCUIApplication!
  
  override func setUp() {
    super.setUp()
    
    continueAfterFailure = false
    
    app = XCUIApplication()
    
    // UI tests must launch the application that they test. Doing this in setup will
    // make sure it happens for each test method.
    app.launch()
    
  }
  
  // Put teardown code here. This method is called after the invocation of each test method in the class.
  override func tearDown() {
    app = nil
    super.tearDown()
  }
  
  func dismissKeyboard() {
    
    // Dismiss keyboard by tapping its toolbar Done button.
    // Note that this toolbar is automatically created for us by IQKeyboardManager lib.
    let kbToolbarDoneButton = app.buttons["Toolbar Done Button"]
    XCTAssertTrue(kbToolbarDoneButton.exists && kbToolbarDoneButton.isHittable)
    kbToolbarDoneButton.tap()
  }
  
}

