//
//  SettingsUITest.swift
//  RecipeAidUITests
//
//  Created by Meir Rosendorff on 2019/06/25.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import XCTest

class SettingsUITest: XCTestCase {

  var app: XCUIApplication!
  let restrictionNames = DietaryRestrictions.allCases.map { $0.description() }

  override func setUp() {
    continueAfterFailure = false
    app = XCUIApplication()
    app.launchArguments.append("-resetUserSetting")
    app.launchArguments.append("-testing")
    app.launch()
  }

  override func tearDown() {
    app = nil
    super.tearDown()
  }

  func checkBlackoutViews(app: XCUIApplication) -> [String: Bool] {

    var viewsExistDictionary = [String: Bool]()

    for name in restrictionNames {
      viewsExistDictionary[name] = app.otherElements["\(name)-\(Identifiers.textBoxBlackout.rawValue)"].exists
    }

    return viewsExistDictionary
  }

  func testDietryRestrictionAppearSelectedAfterSelection() {

    let restrictionToCheck = 1
    app.tabBars.buttons["Settings"].tap()
    app.collectionViews.cells.otherElements.containing(
      .staticText, identifier: restrictionNames[restrictionToCheck]).children(matching: .button).element.tap()

    let viewsExistDictionary = checkBlackoutViews(app: app)

    XCTAssertFalse(viewsExistDictionary[restrictionNames[restrictionToCheck]] ?? false,
                  "\(restrictionNames[restrictionToCheck]) is unchecked")

    for restriction in restrictionNames where restriction != restrictionNames[restrictionToCheck] {

      XCTAssertTrue(viewsExistDictionary[restriction] ?? true, "\(restriction) is checked")
    }
  }

  func testDietryRestrictionIsUnchekedAfterSelectionAndThenDeselection() {

    let restrictionToCheck = 1
    app.tabBars.buttons["Settings"].tap()
    let checkbox = app.collectionViews.cells.otherElements.containing(
      .staticText, identifier: restrictionNames[restrictionToCheck]).children(matching: .button).element

    checkbox.tap()
    checkbox.tap()

    let viewsExistDictionary = checkBlackoutViews(app: app)

    for restriction in restrictionNames {

      XCTAssertTrue(viewsExistDictionary[restriction] ?? true, "\(restriction) is checked")
    }
  }

  func testCheckedBoxesRemainCheckedAfterClickingSave() {

    let restrictionToCheck = 1
    app.tabBars.buttons["Settings"].tap()
    app.collectionViews.cells.otherElements.containing(
      .staticText, identifier: restrictionNames[restrictionToCheck]).children(matching: .button).element.tap()

    app.buttons["Save"].tap()

    let viewsExistDictionary = checkBlackoutViews(app: app)

    XCTAssertFalse(viewsExistDictionary[restrictionNames[restrictionToCheck]] ?? false,
                   "\(restrictionNames[restrictionToCheck]) is unchecked")

    for restriction in restrictionNames where restriction != restrictionNames[restrictionToCheck] {

      XCTAssertTrue(viewsExistDictionary[restriction] ?? true, "\(restriction) is checked")
    }
  }

  func testErrorAlertWhenNonNumberEnteredIntoMinCalories() {

    app.tabBars.buttons["Settings"].tap()
    app.textFields[Identifiers.minCalories.rawValue].tap()
    app.textFields[Identifiers.minCalories.rawValue].typeText("Not Text")
    app.buttons["Save"].tap()

    XCTAssertTrue(app.alerts["Error Saving"].staticTexts["Calories must be a number!"].exists)
  }

  func testErrorAlertWhenNonNumberEnteredIntoMaxCalories() {

    app.tabBars.buttons["Settings"].tap()
    app.textFields[Identifiers.maxCalories.rawValue].tap()
    app.textFields[Identifiers.maxCalories.rawValue].typeText("Not Text")
    app.buttons["Save"].tap()

    XCTAssertTrue(app.alerts["Error Saving"].staticTexts["Calories must be a number!"].exists)
  }

  func testErrorAlertWhenNonNumberEnteredIntoMinTime() {

    app.tabBars.buttons["Settings"].tap()
    app.textFields[Identifiers.minTime.rawValue].tap()
    app.textFields[Identifiers.minTime.rawValue].typeText("Not Text")
    app.buttons["Save"].tap()

    XCTAssertTrue(app.alerts["Error Saving"].staticTexts["Time must be a number!"].exists)
  }

  func testErrorAlertWhenNonNumberEnteredIntoMaxTime() {

    app.tabBars.buttons["Settings"].tap()
    app.textFields[Identifiers.maxTime.rawValue].tap()
    app.textFields[Identifiers.maxTime.rawValue].typeText("Not Text")
    app.buttons["Save"].tap()

    XCTAssertTrue(app.alerts["Error Saving"].staticTexts["Time must be a number!"].exists)
  }

  func testErrorAlertWhenMinTimeGreaterThanMaxTime() {

    app.tabBars.buttons["Settings"].tap()
    app.textFields[Identifiers.maxTime.rawValue].tap()
    app.textFields[Identifiers.maxTime.rawValue].typeText("42")
    app.textFields[Identifiers.minTime.rawValue].tap()
    app.textFields[Identifiers.minTime.rawValue].typeText("100")
    app.buttons["Save"].tap()

    XCTAssertTrue(
      app.alerts["Error Saving"].staticTexts["minimum Time must be less than maximum"].exists)
  }

  func testErrorAlertWhenMinCaloriesGreaterThanMaxCalories() {

    app.tabBars.buttons["Settings"].tap()
    app.textFields[Identifiers.maxCalories.rawValue].tap()
    app.textFields[Identifiers.maxCalories.rawValue].typeText("42")
    app.textFields[Identifiers.minCalories.rawValue].tap()
    app.textFields[Identifiers.minCalories.rawValue].typeText("100")
    app.buttons["Save"].tap()

    XCTAssertTrue(
      app.alerts["Error Saving"].staticTexts["minimum Calories must be less than maximum"].exists)
  }

  func testSuccesfullySavedAlertPopsUpAndThenDissapearsAfterSaving() {

    app.tabBars.buttons["Settings"].tap()
    app.buttons["Save"].tap()

    XCTAssertTrue(app.alerts["Saved"].exists)

    sleep(1)

    XCTAssertFalse(app.alerts["Saved"].exists)
  }

  func testTextFieldCorrectlyPopulatedAfterSave() {

    let minCalories = "42"
    let maxcalories = "100"
    let minTime = "100"
    let maxTime = "142"
    let unwantedFoods = "broccoli, alcohol free beverages, spinach"

    app.tabBars.buttons["Settings"].tap()

    let minCaloriesTextField = app.textFields[Identifiers.minCalories.rawValue]
    minCaloriesTextField.tap()
    minCaloriesTextField.typeText(minCalories)

    let maxCaloriesTextField = app.textFields[Identifiers.maxCalories.rawValue]
    maxCaloriesTextField.tap()
    maxCaloriesTextField.typeText(maxcalories)

    let minTimeTextField = app.textFields[Identifiers.minTime.rawValue]
    minTimeTextField.tap()
    minTimeTextField.typeText(minTime)

    let maxTimeTextField = app.textFields[Identifiers.maxTime.rawValue]
    maxTimeTextField.tap()
    maxTimeTextField.typeText(maxTime)

    let unwantedFoodsTextField = app.textFields[Identifiers.unwantedFoods.rawValue]
    unwantedFoodsTextField.tap()
    unwantedFoodsTextField.typeText(unwantedFoods)

    app.buttons["Save"].tap()

    XCTAssertEqual(minCaloriesTextField.value as? String, minCalories)
    XCTAssertEqual(maxCaloriesTextField.value as? String, maxcalories)
    XCTAssertEqual(minTimeTextField.value as? String, minTime)
    XCTAssertEqual(maxTimeTextField.value as? String, maxTime)
    XCTAssertEqual(unwantedFoodsTextField.value as? String, unwantedFoods)
  }

  func testKeyboardDissapearsAfterTappingOnScreen() {

    let app = XCUIApplication()
    app.tabBars.buttons["Settings"].tap()
    app.textFields[Identifiers.maxCalories.rawValue].tap()

    app.children(matching: .window).element(boundBy: 0).tap()

    sleep(2)
    XCTAssertFalse(app.keys["0"].exists)
  }

  func testLogoutLogsOut() {

    let app = XCUIApplication()
    app.tabBars.buttons["Settings"].tap()
    app.buttons[Identifiers.logout.rawValue].tap()

    XCTAssertFalse(app.navigationBars["Settings"].exists)
  }
}
