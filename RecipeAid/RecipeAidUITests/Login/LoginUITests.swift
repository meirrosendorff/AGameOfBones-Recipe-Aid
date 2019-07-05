//
//  LoginUITests.swift
//  RecipeAidUITests
//
//  Created by Meir Rosendorff on 2019/07/05.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import XCTest

class LoginUITests: XCTestCase {

  var app: XCUIApplication!

  override func setUp() {
    super.setUp()
    app = XCUIApplication()
    continueAfterFailure = false
    app.launchArguments.append("-logout")
  }

  override func tearDown() {
    app = nil
    super.tearDown()
  }

  func testLoginGivesErrorMessageWhenNoUserNamePresent() {

    app.launch()
    app.buttons[Identifiers.login.rawValue].tap()

    XCTAssertTrue(app.staticTexts[Identifiers.errorLogingIn.rawValue].exists)
  }

  func testLoginGivesErrorMessageWhenNoPasswordEntered() {

    app.launch()
    let usernameTextField = app.textFields[Identifiers.usernameTextField.rawValue]
    usernameTextField.tap()
    usernameTextField.typeText("username")

    app.buttons[Identifiers.login.rawValue].tap()

    XCTAssertTrue(app.staticTexts[Identifiers.errorLogingIn.rawValue].exists)
  }

  func testSuccesfullyLogsInWhenGivenValidUsernameAndPassword() {

    let loginURL = "https://recipeaid-server.vapor.cloud/auth/users/login"
    let detailsURL = "https://recipeaid-server.vapor.cloud/auth/users/details"
    let loginFile = "login"
    let detailsFile = "details"

    let stub = loginURL + " " + loginFile + " " + "json" +
      " " + detailsURL + " " + detailsFile + " " + "json"
    app.launchArguments.append("-networkStubs")
    app.launchArguments.append(stub)

    app.launch()
    let usernameTextField = app.textFields[Identifiers.usernameTextField.rawValue]
    usernameTextField.tap()
    usernameTextField.typeText("username")
    let passwordTextField = app.secureTextFields[Identifiers.passwordTextField.rawValue]
    passwordTextField.tap()
    passwordTextField.typeText("password")

    app.buttons[Identifiers.login.rawValue].tap()

    XCTAssertTrue(app.navigationBars["Recipe Aid"].exists)
  }

  func testLoginGivesErrorWhenInvalidUserNameOrPassword() {

    let loginURL = "https://justToStartStubbingSoRequestFails.com"
    let loginFile = "login"

    let stub = loginURL + " " + loginFile + " " + "json"
    app.launchArguments.append("-networkStubs")
    app.launchArguments.append(stub)

    app.launch()
    let usernameTextField = app.textFields[Identifiers.usernameTextField.rawValue]
    usernameTextField.tap()
    usernameTextField.typeText("username")
    let passwordTextField = app.secureTextFields[Identifiers.passwordTextField.rawValue]
    passwordTextField.tap()
    passwordTextField.typeText("password")

    app.buttons[Identifiers.login.rawValue].tap()
    XCTAssertTrue(app.staticTexts[Identifiers.errorLogingIn.rawValue].exists)
  }
}
