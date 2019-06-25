//
//  MenuUITests.swift
//  MenuUITests
//
//  Created by Meir Rosendorff on 2019/06/12.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import XCTest

class MenuUITests: XCTestCase {

  var app: XCUIApplication!
  override func setUp() {

    continueAfterFailure = false
    let app = XCUIApplication()
    let urlBase = "https://api.edamam.com/search?app_id=7eaa9edb&app_key=7b82a875c1c90b7f360a2356f54f2dc1" +
    "&r=http%3A%2F%2Fwww.edamam.com%2Fontologies%2Fedamam.owl%23recipe_"
    let breakfastFileName = "breakfastJsonExample"
    let breakfastURL = urlBase + "7a844b79a5df3f11e822cc229bfb3981"
    let lunchFileName = "lunchJsonExample"
    let lunchUrl = urlBase + "e9c30bda6b789283d22cff594d17ff73"
    let dinnerFileName = "dinnerJsonExample"
    let dinnerURL = urlBase + "b373d8987afb5808439ff243c16ccb63"

    let stub = lunchUrl + " " + lunchFileName +
      " " + dinnerURL + " " +  dinnerFileName +
      " " + breakfastURL + " " + breakfastFileName
    app.launchArguments.append("-networkStubs")
    app.launchArguments.append(stub)
    app.launch()
  }

  override func tearDown() {

    app = nil
  }

  func setDatePickerTo(_ app: XCUIApplication, day: String, month: String, year: String) {
    let dateComponent = Calendar.current.dateComponents([.day, .month, .year], from: Date())
    let formatter = DateFormatter()
    formatter.dateFormat = "MMMM"
    let monthText = formatter.string(from: Date())
    let yearText = String(dateComponent.year!)
    let dayText = String(dateComponent.day!)

    let picker = app.datePickers
    picker.pickerWheels[dayText].adjust(toPickerWheelValue: day)
    picker.pickerWheels[monthText].adjust(toPickerWheelValue: month)
    picker.pickerWheels[yearText].adjust(toPickerWheelValue: year)
  }
  func testNoRecipeLabelIsShownAndRecipeDetailsContainerIsHiddenWhenNoRecipeExists() {

    let app = XCUIApplication()
    app.tabBars.buttons["Menu"].tap()

    setDatePickerTo(app, day: "15", month: "June", year: "2019")
    app.buttons["Confirm"].tap()
    XCTAssertTrue(app.staticTexts[Identifiers.noRecipeLabel.rawValue].exists)
    XCTAssertFalse(app.otherElements[Identifiers.recipeDetailsContainer.rawValue].exists)
  }

  func testNoRecipeLabelIsHiddenAndRecipeDetailsContainerIsShownWhenRecipeExists() {
    let app = XCUIApplication()
    app.tabBars.buttons["Menu"].tap()
    setDatePickerTo(app, day: "14", month: "June", year: "2019")

    app.buttons["Confirm"].tap()

    sleep(1)

    XCTAssertFalse(app.staticTexts[Identifiers.noRecipeLabel.rawValue].exists)
    XCTAssertTrue(app.otherElements[Identifiers.recipeDetailsContainer.rawValue].exists)
  }

  func testNoRecipeLabelGetsHiddenAndDetailsContainerGetsShownWhenChangingMealsToRecipeExists() {
    let app = XCUIApplication()
    app.tabBars.buttons["Menu"].tap()
    setDatePickerTo(app, day: "15", month: "June", year: "2019")
    app.buttons["Confirm"].tap()
    app.segmentedControls.buttons["Lunch"].tap()

    XCTAssertFalse(app.staticTexts[Identifiers.noRecipeLabel.rawValue].exists)
    XCTAssertTrue(app.otherElements[Identifiers.recipeDetailsContainer.rawValue].exists)
  }

  func testNoRecipeLabelGetsHiddenAndDetailsContainerGetsShownWhenChangingMealsToNoRecipeExists() {
    let app = XCUIApplication()
    app.tabBars.buttons["Menu"].tap()
    setDatePickerTo(app, day: "14", month: "June", year: "2019")
    app.buttons["Confirm"].tap()
    app.segmentedControls.buttons["Dinner"].tap()

    XCTAssertTrue(app.staticTexts[Identifiers.noRecipeLabel.rawValue].exists)
    XCTAssertFalse(app.otherElements[Identifiers.recipeDetailsContainer.rawValue].exists)
  }

  func testRecipeDetailsCorrectlyFilledInWhenOpeningViewHasRecipe() {
    let app = XCUIApplication()
    app.tabBars.buttons["Menu"].tap()
    setDatePickerTo(app, day: "14", month: "June", year: "2019")
    app.buttons["Confirm"].tap()

    XCTAssertEqual(app.staticTexts[Identifiers.recipeName.rawValue].label, "breakfast Title")
    XCTAssertEqual(app.tables[Identifiers.ingredientTableView.rawValue].staticTexts.count, 5)
    for index in 1...5 {
      XCTAssertTrue(
        app.staticTexts["ingredient-breakfast-\(index)"].exists,
        "ingredient-breakfast-\(index) does not exist"
      )
    }
  }

  func testRecipeDetailsCorrectlyFilledInWhenMovingToViewHasRecipe() {
    let app = XCUIApplication()
    app.tabBars.buttons["Menu"].tap()
    setDatePickerTo(app, day: "14", month: "June", year: "2019")
    app.buttons["Confirm"].tap()
    app.segmentedControls.buttons["Lunch"].tap()

    XCTAssertEqual(app.staticTexts[Identifiers.recipeName.rawValue].label, "lunch Title")
    XCTAssertEqual(app.tables[Identifiers.ingredientTableView.rawValue].staticTexts.count, 10)
    for index in 1...10 {
      XCTAssertTrue(
        app.staticTexts["ingredient-lunch-\(index)"].exists,
        "ingredient-lunch-\(index) does not exist"
      )
    }
    for index in 1...5 {
      XCTAssertFalse(
        app.staticTexts["ingredient-breakfast-\(index)"].exists,
        "ingredient-breakfast-\(index) exists but shouldn't"
      )
    }
  }

  func testRecipeDetailsCorrectlyFilledInWhenMovingToViewHasRecipeAndThenBack() {
    let app = XCUIApplication()
    app.tabBars.buttons["Menu"].tap()
    setDatePickerTo(app, day: "14", month: "June", year: "2019")
    app.buttons["Confirm"].tap()
    app.segmentedControls.buttons["Lunch"].tap()
    app.segmentedControls.buttons["Breakfast"].tap()
    XCTAssertEqual(app.staticTexts[Identifiers.recipeName.rawValue].label, "breakfast Title")
    XCTAssertEqual(app.tables[Identifiers.ingredientTableView.rawValue].staticTexts.count, 5)
    for index in 1...5 {
      XCTAssertTrue(
        app.staticTexts["ingredient-breakfast-\(index)"].exists,
        "ingredient-breakfast-\(index) does not exist"
      )
    }
    for index in 1...10 {
      XCTAssertFalse(
        app.staticTexts["ingredient-lunch-\(index)"].exists,
        "ingredient-lunch-\(index) exists but shouldn't"
      )
    }
  }

  func testRecipeDetailsCorrectlyFilledWhenMovingFromScreenWithNoMeal() {
    let app = XCUIApplication()
    app.tabBars.buttons["Menu"].tap()
    setDatePickerTo(app, day: "15", month: "June", year: "2019")
    app.buttons["Confirm"].tap()
    app.segmentedControls.buttons["Lunch"].tap()

    XCTAssertEqual(app.staticTexts[Identifiers.recipeName.rawValue].label, "lunch Title")
    XCTAssertEqual(app.tables[Identifiers.ingredientTableView.rawValue].staticTexts.count, 10)
    for index in 1...10 {
      XCTAssertTrue(
        app.staticTexts["ingredient-lunch-\(index)"].exists,
        "ingredient-lunch-\(index) does not exist"
      )
    }
  }
}
