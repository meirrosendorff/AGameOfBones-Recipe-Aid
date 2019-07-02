//
//  SearchAndAddUITests.swift
//  RecipeAidUITests
//
//  Created by Meir Rosendorff on 2019/06/19.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import XCTest

class SearchAndAddUITests: XCTestCase {

  override func setUp() {
    super.setUp()

    let app = XCUIApplication()
    continueAfterFailure = false

    let urlBase = "https://api.edamam.com/search?app_id=7eaa9edb&app_key=7b82a875c1c90b7f360a2356f54f2dc1"
    let soupSearchBase = urlBase + "&q=Soup"

    let soupSearchFirstTenURL = soupSearchBase + "&from=0&to=10"
    let soupSearchFirstTenFile = "exampleSearchResultFirstTen"

    let soupSearchSecondTenURL = soupSearchBase + "&from=10&to=20"
    let soupSearchSecondTenFile = "exampleSearchResultSecondTen"

    let breadSearchURL = urlBase + "&q=Bread&from=0&to=10"
    let breadSearchFile = "exampleSearchResultSecondTen"

    let jsonFileType = "json"

    let toStub = soupSearchFirstTenURL + " " + soupSearchFirstTenFile + " " + jsonFileType +
      " " + soupSearchSecondTenURL + " " + soupSearchSecondTenFile + " " + jsonFileType +
      " " + breadSearchURL + " " + breadSearchFile + " " + jsonFileType

    app.launchArguments.append("-networkStubs")
    app.launchArguments.append(toStub)
    app.launchArguments.append("-resetUserSetting")
    app.launchArguments.append("-testing")
    app.launch()
  }

  override func tearDown() {
    super.tearDown()
  }

  private func performSearch(_ app: XCUIApplication, search: String) {

    let searchBar = app.otherElements[Identifiers.searchBar.rawValue]
    searchBar.tap()
    searchBar.typeText(search)
    app.keyboards.buttons["Search"].tap()
  }

  func testSearchWithEmptyStringDoesNothingOnSearchPage() {

    let app = XCUIApplication()

    performSearch(app, search: "")

    XCTAssertTrue(app.navigationBars["Recipe Aid"].exists)
  }

  func testSearchWithNoResultsOnsearchPageRedirectsToResultsPageWithNoResultsLabel() {

    let app = XCUIApplication()
    let search = "Bad Search"
    performSearch(app, search: search)

    XCTAssertTrue(app.navigationBars[search].exists)
    XCTAssertTrue(app.staticTexts["No recipes found for \(search)"].exists)
  }

  func testSearchWithResultsOnsearchPageRedirectsToResultsPageWithoutNoResultsLabel() {

    let app = XCUIApplication()
    let search = "Soup"

    performSearch(app, search: search)

    XCTAssertTrue(app.navigationBars[search].exists)
    XCTAssertFalse(app.staticTexts["No recipes found for \(search)"].exists)
  }

  func testSearchWithResultOnSearchPageRedirectsToResultsPageWithCorrectNumberOfResults() {

    let app = XCUIApplication()
    let search = "Soup"

    performSearch(app, search: search)

    let count = XCUIApplication().tables.element.children(matching: .cell).count
    XCTAssertEqual(count, 10)
  }

  func testNewResultsLoadWhenScrollUpIsPulled() {

    let app = XCUIApplication()
    let search = "Soup"

    performSearch(app, search: search)

    let table = XCUIApplication().tables
    table.element.swipeUp()
    table.element.swipeUp()

    let lastElementInTable = app.tables.staticTexts["Chicken Noodle Soup"]
    let startPoint = lastElementInTable.coordinate(withNormalizedOffset: CGVector())
    let endPoint = app.navigationBars[search].coordinate(withNormalizedOffset: CGVector())
    startPoint.press(forDuration: 0.1, thenDragTo: endPoint)

    let count = XCUIApplication().tables.element.children(matching: .cell).count
    XCTAssertEqual(count, 20)
  }

  func testNewSearchWithNoResultsFromResultsPageSetsNoResultsLabel() {

    let app = XCUIApplication()
    let goodSearch = "Soup"
    let badSearch = "Bad Search"

    performSearch(app, search: goodSearch)

    performSearch(app, search: badSearch)

    XCTAssertTrue(app.navigationBars[badSearch].exists)
    XCTAssertTrue(app.staticTexts["No recipes found for \(badSearch)"].exists)
  }

  func testNewSearchWithResultsFromResultsPageMakesNewSearch() {

    let app = XCUIApplication()
    let goodSearchFirst = "Soup"
    let goodSearchSecond = "Bread"

    performSearch(app, search: goodSearchFirst)

    performSearch(app, search: goodSearchSecond)

    let count = XCUIApplication().tables.element.children(matching: .cell).count

    XCTAssertTrue(app.navigationBars[goodSearchSecond].exists)
    XCTAssertFalse(app.staticTexts["No recipes found for \(goodSearchSecond)"].exists)
    XCTAssertEqual(count, 10)
  }

  func assertDetailsPageIsCorrect(
    _ app: XCUIApplication,
    recipeName: String,
    servings: Int,
    calories: Int) {

    XCTAssertEqual(app.staticTexts[Identifiers.recipeName.rawValue].label,
                   recipeName)
    XCTAssertEqual(app.staticTexts[Identifiers.caloriesLabel.rawValue].label,
                   "Calories: \(calories)")
    XCTAssertEqual(app.staticTexts[Identifiers.servingsLabel.rawValue].label,
                   "Servings: \(servings)")
  }

  func testSelectingElementGoesToDetailsPageWithElementDetails() {

    let app = XCUIApplication()
    let search = "Soup"

    performSearch(app, search: search)

    let table = app.tables

    table.staticTexts["Cleansing Ginger-Chicken Soup"].tap()

    assertDetailsPageIsCorrect(app,
                               recipeName: "Cleansing Ginger-Chicken Soup",
                               servings: 8,
                               calories: 261)

    app.navigationBars["Details"].buttons["Soup"].tap()

    app.tables.cells["Matzo Ball Soup, Servings: 4, Calories: 648, Martha Stewart"].staticTexts["Matzo Ball Soup"].tap()

    assertDetailsPageIsCorrect(app,
                               recipeName: "Matzo Ball Soup",
                               servings: 4,
                               calories: 648)
  }

  func testAddButtonTakesToAddPageAndConfirmReturnsToDetailsPage() {

    let app = XCUIApplication()
    let search = "Soup"

    performSearch(app, search: search)

    let table = app.tables

    table.staticTexts["Cleansing Ginger-Chicken Soup"].tap()

    app.navigationBars["Details"].buttons["Add"].tap()

    XCTAssertTrue(app.navigationBars["Add Recipe"].exists)

    app.buttons["Confirm"].tap()

    XCTAssertTrue(app.navigationBars["Details"].exists)
  }

  func testSeeFullInstructionsButtonOpensWebViewWithInstructions() {

    let app = XCUIApplication()
    let search = "Soup"

    performSearch(app, search: search)

    let table = app.tables

    table.staticTexts["Cleansing Ginger-Chicken Soup"].tap()

    app.buttons[Identifiers.fullInstructionsLabel.rawValue].tap()

    sleep(3)

    XCTAssertTrue(app.navigationBars["TestTitle"].otherElements["TestTitle"].exists)
  }

  func testKeyboardDissapearsAfterTappingOnScreen() {

    let app = XCUIApplication()
    app.otherElements[Identifiers.searchBar.rawValue].tap()

    app.children(matching: .window).element(boundBy: 0).tap()

    sleep(2)

    XCTAssertFalse(app.keyboards.buttons["Search"].exists)
  }
}
