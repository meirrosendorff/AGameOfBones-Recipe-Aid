//
//  SearchResultsModelTests.swift
//  RecipeAidTests
//
//  Created by Meir Rosendorff on 2019/06/18.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import Foundation

@testable import RecipeAid
import XCTest

class SearchResultsModelTests: XCTestCase {

  var model: SearchResultsModelProtocol!
  var recipeSet: [Recipe]!

  override func setUp() {

    super.setUp()
    recipeSet = soupSearchRecipeSet
    model = SearchResultsModel()
  }

  override func tearDown() {

    model = nil
    super.tearDown()
  }

  func testNumResultsReturnsCorrectSize() {

    let emptySize = 0
    let setSize = recipeSet.count
    let doubleSetSize = recipeSet.count * 2

    XCTAssertEqual(emptySize, model.numResults)

    model.addNewSearchResults(results: recipeSet)
    XCTAssertEqual(setSize, model.numResults)

    model.addMoreResultsToSet(newResults: recipeSet)
    XCTAssertEqual(doubleSetSize, model.numResults)
  }

  func testGetResultSourceReturnsCorrectResponse() {

    XCTAssertEqual("", model.getResultSource(forPos: 0))

    model.addNewSearchResults(results: recipeSet)

    for recipeNum in 0..<recipeSet.count {
      XCTAssertEqual(recipeSet[recipeNum].source, model.getResultSource(forPos: recipeNum))
    }
  }

  func testGetResultServingsReturnsCorrectResponse() {

    XCTAssertEqual(0, model.getResultServings(forPos: 0))

    model.addNewSearchResults(results: recipeSet)

    for recipeNum in 0..<recipeSet.count {
      XCTAssertEqual(recipeSet[recipeNum].yield, model.getResultServings(forPos: recipeNum))
    }

  }

  func testGetResultCaloriesReturnsCorrectResponse() {

    XCTAssertEqual(0, model.getResultCalories(forPos: 0))

    model.addNewSearchResults(results: recipeSet)

    for recipeNum in 0..<recipeSet.count {
      XCTAssertEqual(recipeSet[recipeNum].calories, model.getResultCalories(forPos: recipeNum))
    }
  }

  func testGetResultImageUrlReturnsCorrectResponse() {

    XCTAssertEqual("", model.getResultImageUrl(forPos: 0))

    model.addNewSearchResults(results: recipeSet)

    for recipeNum in 0..<recipeSet.count {
      XCTAssertEqual(recipeSet[recipeNum].image, model.getResultImageUrl(forPos: recipeNum))
    }
  }

  func testGetResultNameReturnsCorrectResponse() {

    XCTAssertEqual("", model.getResultName(forPos: 0))

    model.addNewSearchResults(results: recipeSet)

    for recipeNum in 0..<recipeSet.count {
      XCTAssertEqual(recipeSet[recipeNum].label, model.getResultName(forPos: recipeNum))
    }
  }

  func testGetRecipeFetchesCorrectRecipe() {

    model.addNewSearchResults(results: recipeSet)

    for recipeNum in 0..<recipeSet.count {
      XCTAssertEqual(recipeSet[recipeNum], model.getRecipe(at: recipeNum))
    }
  }

  func testAddNewSearchResultsDeletesAllPreviousResults() {

    let singelRecipeSet = [iceCreamRecipe]
    model.addNewSearchResults(results: recipeSet)
    model.addNewSearchResults(results: singelRecipeSet)

    XCTAssertEqual(model.numResults, 1)

    XCTAssertEqual(iceCreamRecipe, model.getRecipe(at: 0))
  }
}
