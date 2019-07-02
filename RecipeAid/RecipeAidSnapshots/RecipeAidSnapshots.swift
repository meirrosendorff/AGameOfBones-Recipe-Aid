//
//  RecipeAidSnapshots.swift
//  RecipeAidSnapshots
//
//  Created by Meir Rosendorff on 2019/07/02.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import XCTest

class RecipeAidSnapshots: XCTestCase {

  var app: XCUIApplication!

  override func setUp() {
    app = XCUIApplication()
    continueAfterFailure = false
    setupSnapshot(app)
    app.launch()
  }

  override func tearDown() {
    super.tearDown()
  }

  func testSearchAndAddRunThrough() {

    let app = XCUIApplication()
    app.otherElements["SearchBar"].children(matching: .searchField).element.tap()

    let searchBar = app.otherElements[Identifiers.searchBar.rawValue]
    searchBar.tap()
    searchBar.typeText("Breakfast")

    snapshot("1: Search")

    app.keyboards.buttons["Search"].tap()

    snapshot("2: Search Results")
    app.tables.staticTexts["Breakfast Sausage Puffs recipes"].tap()
    sleep(30)
    snapshot("3: Recipe Details")
    app.buttons["See Full Instructions"].tap()

    sleep(30)
    snapshot("4: Full Instructions")

    app.navigationBars.buttons["Details"].tap()
    app.navigationBars["Details"].buttons["Add"].tap()

    let dateComponent = Calendar.current.dateComponents([.day, .month, .year], from: Date())
    let formatter = DateFormatter()
    formatter.dateFormat = "MMMM"
    let monthText = formatter.string(from: Date())
    let yearText = String(dateComponent.year!)
    let dayText = String(dateComponent.day!)

    let nextWeek = Calendar.current.date(byAdding: .day, value: 7, to: Date())!
    let nextWeekComponents = Calendar.current.dateComponents([.day, .month, .year], from: nextWeek)

    let nextWeekMonth = formatter.string(from: nextWeek)
    let nextWeekYear = String(nextWeekComponents.year!)
    let nextWeekDay = String(nextWeekComponents.day!)

    let picker = app.datePickers
    picker.pickerWheels[dayText].adjust(toPickerWheelValue: nextWeekDay)
    picker.pickerWheels[monthText].adjust(toPickerWheelValue: nextWeekMonth)
    picker.pickerWheels[yearText].adjust(toPickerWheelValue: nextWeekYear)

    snapshot("5: Add Recipe To Menu")

    app.buttons["Confirm"].tap()
  }
}
