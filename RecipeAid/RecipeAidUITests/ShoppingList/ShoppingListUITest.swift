//
//  ShoppingListUITest.swift
//  RecipeAidUITests
//
//  Created by Meir Rosendorff on 2019/06/26.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import XCTest

class ShoppingListUITest: XCTestCase {

  var app: XCUIApplication!

  override func setUp() {
    super.setUp()

    app = XCUIApplication()
    app.launchArguments.append("-testing")
    continueAfterFailure = false
  }

  override func tearDown() {
    app = nil
    super.tearDown()
  }

  func testDateChangesWhenGoingForwardAndThenBack() {

    app.launch()

    app.tabBars.buttons["Shopping List"].tap()
    let currWeek = app.staticTexts[Identifiers.shoppingDateRange.rawValue].label

    app.buttons["right chevron"].tap()
    XCTAssertNotEqual(currWeek, app.staticTexts[Identifiers.shoppingDateRange.rawValue].label)

    app.buttons["left chevron"].tap()
    XCTAssertEqual(currWeek, app.staticTexts[Identifiers.shoppingDateRange.rawValue].label)
  }

  func testDateChangesWhenGoingBackAndThenForward() {

    app.launch()

    app.tabBars.buttons["Shopping List"].tap()
    let currWeek = app.staticTexts[Identifiers.shoppingDateRange.rawValue].label

    app.buttons["left chevron"].tap()
    XCTAssertNotEqual(currWeek, app.staticTexts[Identifiers.shoppingDateRange.rawValue].label)

    app.buttons["right chevron"].tap()
    XCTAssertEqual(currWeek, app.staticTexts[Identifiers.shoppingDateRange.rawValue].label)
  }

  func testNoShoppingLabelNotVisableWhenHasShoppingItems() {

    app.launch()

    app.tabBars.buttons["Shopping List"].tap()

    XCTAssertFalse(app.staticTexts[Identifiers.noShopping.rawValue].exists)
  }

  func testNoShoppingLabelIsVisableWhenNoShopping() {

    app.launchArguments.append("-forceEmptyReturns")
    app.launch()

    app.tabBars.buttons["Shopping List"].tap()

    XCTAssertTrue(app.staticTexts[Identifiers.noShopping.rawValue].exists)
  }

  func testItemCorrectlyLooksSelectedAndDeselected() {

    app.launch()
    app.tabBars.buttons["Shopping List"].tap()

    XCTAssertFalse(app.otherElements["\(Identifiers.textBoxBlackout.rawValue)-true"].exists)
    XCTAssertTrue(app.otherElements["\(Identifiers.textBoxBlackout.rawValue)-false"].exists)
  }

  func testBoughtItemAppearsDeselectedAfterSelection() {

    app.launch()

    app.tabBars.buttons["Shopping List"].tap()

    XCUIApplication().tables.staticTexts["Item Bought"].tap()

    XCTAssertFalse(app.otherElements["\(Identifiers.textBoxBlackout.rawValue)-true"].exists)
    XCTAssertFalse(app.otherElements["\(Identifiers.textBoxBlackout.rawValue)-false"].exists)
  }

  func testNotBoughtItemAppearsSelectedAfterSelection() {

    app.launch()

    app.tabBars.buttons["Shopping List"].tap()

    XCUIApplication().tables.staticTexts["Item NotBought"].tap()

    XCTAssertTrue(app.otherElements["\(Identifiers.textBoxBlackout.rawValue)-true"].exists)
    XCTAssertTrue(app.otherElements["\(Identifiers.textBoxBlackout.rawValue)-false"].exists)
  }
}
