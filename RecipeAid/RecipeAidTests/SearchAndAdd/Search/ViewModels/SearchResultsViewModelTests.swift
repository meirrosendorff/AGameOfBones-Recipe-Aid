//
//  SearchResultsViewModelTests.swift
//  RecipeAidTests
//
//  Created by Meir Rosendorff on 2019/06/19.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import Foundation

@testable import RecipeAid
import XCTest
import Hippolyte

class SearchResultsViewModelTests: XCTestCase {

  var model: SearchResultsModelMock!
  var repo: EdamamRecipeAPIRepositoryMock!
  var viewModel: SearchResultsViewModel!
  var examplesearchResult: [Recipe]!
  var exampleRecipe: Recipe!
  var basicQuery: String!
  var basicSecondQuery: String!

  override func setUp() {
    super.setUp()
    model = SearchResultsModelMock()
    repo = EdamamRecipeAPIRepositoryMock(returnsValidResponse: true)
    viewModel = SearchResultsViewModel()
    viewModel.model = model
    viewModel.repo = repo
    examplesearchResult = soupSearchRecipeSet
    exampleRecipe = dummyRecipe
    basicQuery = "query"
    basicSecondQuery = "different query"
  }

  override func tearDown() {
    model = nil
    repo = nil
    viewModel = nil
    examplesearchResult = nil
    exampleRecipe = nil
    super.tearDown()
  }

  func testNumResultsReturnsCorrectNumberOfResults() {

    XCTAssertEqual(0, viewModel.numResults, "Incorrect numResults for empty results")

    model.addNewSearchResults(results: soupSearchRecipeSet)

    XCTAssertEqual(examplesearchResult.count, viewModel.numResults, "Incorrect numResults for filled results")

    model.addNewSearchResults(results: [iceCreamRecipe])

    XCTAssertEqual(1, viewModel.numResults, "Incorrect numResults for refilled results")
  }

  func testGetNextSearchResultReturnsFalseWhenNoResults() {

    repo.recipeSetToReturn = []

    let expectation = self.expectation(description: "Should return false")

    var result = true

    viewModel.getNextSearchResults(for: basicQuery, onComplete: { resultsFound in
      result = resultsFound
      expectation.fulfill()
    })

    waitForExpectations(timeout: 2, handler: nil)

    XCTAssertFalse(result)
  }

  func testGetNextSearchResultReturnsTrueWhenHasResults() {

    let expectation = self.expectation(description: "Should return true")

    var result = false

    viewModel.getNextSearchResults(for: basicQuery, onComplete: { resultsFound in
      result = resultsFound
      expectation.fulfill()
    })

    waitForExpectations(timeout: 2, handler: nil)

    XCTAssertTrue(result)
  }

  func testGetNextSearchResultSetsNoRecipeFoundTextWhenNoResults() {

    repo.recipeSetToReturn = []
    let noRecipeString = "No recipes found for \(basicQuery ?? "")"

    let expectation = self.expectation(description: "Should return false")

    viewModel.getNextSearchResults(for: basicQuery, onComplete: { _ in
      expectation.fulfill()
    })

    waitForExpectations(timeout: 2, handler: nil)

    XCTAssertEqual(noRecipeString, viewModel.noResults)
  }

  func testGetNextSearchResultCallsAddNewSearchResultsWhenNewSearchIsMade() {

    let firstExpectation = self.expectation(description: "Should Perform Search")

    viewModel.getNextSearchResults(for: basicQuery, onComplete: { _ in
      firstExpectation.fulfill()
    })

    waitForExpectations(timeout: 3, handler: nil)

    XCTAssertEqual(model.addNewSearchResultsMethodCalls, 1)
    XCTAssertEqual(model.addMoreResultsToSetMethodCalls, 0)

    let secondExpectation = self.expectation(description: "Should Perform Search")

    viewModel.getNextSearchResults(for: basicSecondQuery, onComplete: { _ in
      secondExpectation.fulfill()
    })
    waitForExpectations(timeout: 3, handler: nil)

    XCTAssertEqual(model.addNewSearchResultsMethodCalls, 2)
    XCTAssertEqual(model.addMoreResultsToSetMethodCalls, 0)
  }

  func testGetNextSearchResultCallsAddMoreResultsToSearchWhenTwoCallsForSameQueryMade() {

    let firstExpectation = self.expectation(description: "Should Perform Search")

    viewModel.getNextSearchResults(for: basicQuery, onComplete: { _ in
      firstExpectation.fulfill()
    })
    waitForExpectations(timeout: 3, handler: nil)

    XCTAssertEqual(model.addNewSearchResultsMethodCalls, 1)
    XCTAssertEqual(model.addMoreResultsToSetMethodCalls, 0)

    let secondExpectation = self.expectation(description: "Should Perform Search")

    viewModel.getNextSearchResults(for: basicQuery, onComplete: { _ in
      secondExpectation.fulfill()
    })
    waitForExpectations(timeout: 3, handler: nil)

    XCTAssertEqual(model.addNewSearchResultsMethodCalls, 1)
    XCTAssertEqual(model.addMoreResultsToSetMethodCalls, 1)
  }

  func testGetNextSearchResultCorrectlyUpdatesSearchRangeWhenTwoCallsForSameQueryMade() {

    let firstRange = (0, 10)
    let secondRange = (10, 20)

    let firstExpectation = self.expectation(description: "Should Perform Search")

    viewModel.getNextSearchResults(for: basicQuery, onComplete: { _ in
      firstExpectation.fulfill()
    })
    waitForExpectations(timeout: 3, handler: nil)

    XCTAssertEqual(repo.lastSearchRange.0, firstRange.0)
    XCTAssertEqual(repo.lastSearchRange.1, firstRange.1)

    let secondExpectation = self.expectation(description: "Should Perform Search")

    viewModel.getNextSearchResults(for: basicQuery, onComplete: { _ in
      secondExpectation.fulfill()
    })
    waitForExpectations(timeout: 3, handler: nil)

    XCTAssertEqual(repo.lastSearchRange.0, secondRange.0)
    XCTAssertEqual(repo.lastSearchRange.1, secondRange.1)
  }

  func testGetNextSearchResultCorrectlyUpdatesSearchRangeWhenNewSearchMade() {

    let range = (0, 10)

    let firstExpectation = self.expectation(description: "Should Perform Search")

    viewModel.getNextSearchResults(for: basicQuery, onComplete: { _ in
      firstExpectation.fulfill()
    })
    waitForExpectations(timeout: 3, handler: nil)

    XCTAssertEqual(repo.lastSearchRange.0, range.0)
    XCTAssertEqual(repo.lastSearchRange.1, range.1)

    let secondExpectation = self.expectation(description: "Should Perform Search")

    viewModel.getNextSearchResults(for: basicSecondQuery, onComplete: { _ in
      secondExpectation.fulfill()
    })
    waitForExpectations(timeout: 3, handler: nil)

    XCTAssertEqual(repo.lastSearchRange.0, range.0)
    XCTAssertEqual(repo.lastSearchRange.1, range.1)
  }

  func testGetNextSearchResultsReturnsFalseWhenRecievesAnError() {

    repo.returnsValidResponse = false

    var result = true

    let expectation = self.expectation(description: "should fail Search")

    viewModel.getNextSearchResults(for: basicQuery, onComplete: { resultsFound in
      result = resultsFound
      expectation.fulfill()
    })

    waitForExpectations(timeout: 2, handler: nil)

    XCTAssertFalse(result)
  }

  func testGetResultSourceReturnsCorrectly() {

    model.addNewSearchResults(results: [exampleRecipe])

    XCTAssertEqual(viewModel.getResultSource(forPos: 0), exampleRecipe.source)
  }

  func testGetResultNameReturnsCorrectly() {

    model.addNewSearchResults(results: [exampleRecipe])

    XCTAssertEqual(viewModel.getResultName(forPos: 0), exampleRecipe.label)
  }

  func testGetResultServingsReturnsCorrectly() {

    model.addNewSearchResults(results: [exampleRecipe])

    XCTAssertEqual(viewModel.getResultServings(forPos: 0), "Servings: 42")
  }

  func testGetResultCaloriesReturnsCorrectly() {

    model.addNewSearchResults(results: [exampleRecipe])

    XCTAssertEqual(viewModel.getResultCalories(forPos: 0), "Calories: 42")
  }

  func testGetNextSearchResultCorrectlySetsResults() {

    repo.recipeSetToReturn = examplesearchResult

    let expectation = self.expectation(description: "Should return true")

    viewModel.getNextSearchResults(for: basicQuery, onComplete: { _ in
      expectation.fulfill()
    })

    waitForExpectations(timeout: 2, handler: nil)

    for pos in 0..<examplesearchResult.count {
      XCTAssertEqual(examplesearchResult[pos].label, viewModel.getResultName(forPos: pos))
    }
  }

  func testGetViewModelForRecipeReturnsCorrectViewModel() {

    repo.recipeSetToReturn = examplesearchResult

    let expectation = self.expectation(description: "Should return true")

    viewModel.getNextSearchResults(for: basicQuery, onComplete: { _ in
      expectation.fulfill()
    })

    waitForExpectations(timeout: 2, handler: nil)

    let nextViewModel = viewModel.getViewModelForRecipe(at: 5)

    XCTAssertEqual(nextViewModel.name, examplesearchResult[5].label)
  }

  func testGetResultImageDoesNotCallOnCompleteIfNoUrlFoundForPos() {

    let pos = 42

    let expectation = self.expectation(description: "Should not be called")
    expectation.isInverted = true

    viewModel.getResultImage(forPos: pos, onComplete: { _ in
      expectation.fulfill()
    })

    waitForExpectations(timeout: 2, handler: nil)
  }

  func testGetResultImageDoesNotCallOnCompleteIfErrorReturned() {

    repo.recipeSetToReturn = [exampleRecipe]

    guard let url = URL(string: exampleRecipe.image) else { return }
    var stub = StubRequest(method: .GET, url: url)
    let response = StubResponse(error: RecipeError.unableToFetchImage("") as NSError)
    stub.response = response
    Hippolyte.shared.add(stubbedRequest: stub)
    Hippolyte.shared.start()

    let firstExpectation = self.expectation(description: "Should return true")

    viewModel.getNextSearchResults(for: basicQuery, onComplete: { _ in
      firstExpectation.fulfill()
    })

    waitForExpectations(timeout: 2, handler: nil)

    let secondExpectation = self.expectation(description: "Fetching image should fail")
    secondExpectation.isInverted = true

    viewModel.getResultImage(forPos: 0) { _ in
      secondExpectation.fulfill()
    }

    waitForExpectations(timeout: 2, handler: nil)

    addTeardownBlock {
      Hippolyte.shared.stop()
    }
  }

  func testGetResultImageReturnsCorrectImageForValidQuery() {

    repo.recipeSetToReturn = examplesearchResult
    var imageRecieved = Data()

    let urlString = "https://www.edamam.com/web-img/bab/bab4ee2d4ce0e0bbb626f098069ee98e.JPG"
    guard let url = URL(string: urlString) else { return }
    var stub = StubRequest(method: .GET, url: url)
    var response = StubResponse()
    let body = "Heres Your Image".data(using: .utf8)!
    response.body = body
    stub.response = response
    Hippolyte.shared.add(stubbedRequest: stub)
    Hippolyte.shared.start()

    let firstExpectation = self.expectation(description: "Should return true")

    viewModel.getNextSearchResults(for: basicQuery, onComplete: { _ in
      firstExpectation.fulfill()
    })

    waitForExpectations(timeout: 2, handler: nil)

    let secondExpectation = self.expectation(description: "Fetching image")

    viewModel.getResultImage(forPos: 0) { data in
      imageRecieved = data
      secondExpectation.fulfill()
    }

    waitForExpectations(timeout: 2, handler: nil)

    XCTAssertEqual(imageRecieved, body)

    addTeardownBlock {
      Hippolyte.shared.stop()
    }
  }

  func testWhenResultsSizeLessThanMinSearchRangeIncreasesAndANewSearchIsMadeUntillReachingAMax() {

    let expectation = self.expectation(description: "Should make multiple calls")
    let firstRange = (0, 10)
    let secondRange = (0, 20)
    let thirdRange = (0, 40)
    let fourthRange = (0, 80)

    repo.numResultsToReturn = 1

    viewModel.getNextSearchResults(for: basicQuery, onComplete: { _ in
      expectation.fulfill()
    })

    waitForExpectations(timeout: 2, handler: nil)

    XCTAssertEqual(repo.numCallsforPerformSearchMethod, 4)
    XCTAssertTrue(checkEqual(repo.searchRanges[0], firstRange))
    XCTAssertTrue(checkEqual(repo.searchRanges[1], secondRange))
    XCTAssertTrue(checkEqual(repo.searchRanges[2], thirdRange))
    XCTAssertTrue(checkEqual(repo.searchRanges[3], fourthRange))
  }
}
