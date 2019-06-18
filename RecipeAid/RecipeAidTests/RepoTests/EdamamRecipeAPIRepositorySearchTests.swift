//
//  EdamamRecipeAPIRepositorySearchTests.swift
//  RecipeAidTests
//
//  Created by Meir Rosendorff on 2019/06/18.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import XCTest

@testable import RecipeAid
import Hippolyte

class EdamamRecipeAPIRepositorySearchTests: XCTestCase {

  func stub(url: URL, result: Data) {

    var stub = StubRequest(method: .GET, url: url)
    var response = StubResponse()
    let body = result
    response.body = body
    stub.response = response
    Hippolyte.shared.add(stubbedRequest: stub)
    Hippolyte.shared.start()
  }

  var correctSearchResult: [Recipe]!
  var repo: EdamamRecipeAPIRepository!
  var data: Data!

  override func setUp() {

    super.setUp()
    correctSearchResult = soupSearchRecipeSet
    repo = EdamamRecipeAPIRepository()
    let exampleRecipeRequestJson = "exampleSearchResult"
    let bundle = Bundle(for: type(of: self))
    let path = bundle.path(forResource: exampleRecipeRequestJson, ofType: "json")!
    data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
  }

  override func tearDown() {

    correctSearchResult = nil
    repo = nil
    data = nil
    super.tearDown()
  }

  func testPerformSearchReturnsCorrectSetOfSearchResults() {

    guard let url = URL(string: "https://api.edamam.com/search" +
      "?app_id=7eaa9edb&app_key=7b82a875c1c90b7f360a2356f54f2dc1" +
      "&q=Soup&from=0&to=10") else { return }

    stub(url: url, result: data)

    let query = "Soup"
    let resultRange = (0, 10)
    let expectation = self.expectation(description: "Fetching a Recipe")

    repo.performSearch(forQuery: query, resultRange: resultRange, onComplete: { searchResult in

      expectation.fulfill()

      switch searchResult {
      case .failure:
        XCTFail("Returned Error when it should have fetched valid recipe")
      case .success(let recipeSet):
        XCTAssertEqual(recipeSet.count, soupSearchRecipeSet.count)

        for recipe in soupSearchRecipeSet {
          XCTAssertTrue(recipeSet.contains(recipe), "\(recipe.label) not contained in return set")
        }
      }
    })
    waitForExpectations(timeout: 5, handler: nil)

    addTeardownBlock {
      Hippolyte.shared.stop()
    }
  }

  func testPerformSearchReturnsEmptySetForEmptyQuery() {

    let emptyQuery = ""
    let resultRange = (0, 10)
    let expectation = self.expectation(description: "Fetching results for empty query")

    repo.performSearch(forQuery: emptyQuery, resultRange: resultRange, onComplete: { result in

      expectation.fulfill()

      switch result {
      case .failure:
        XCTFail("returned error for empty search query")
      case .success(let resultSet):
        XCTAssertTrue(resultSet.isEmpty)
      }
    })

    waitForExpectations(timeout: 5, handler: nil)

    addTeardownBlock {
      Hippolyte.shared.stop()
    }
  }

  func testPerformSearchsearchesForCorrectRange() {

    let start = 42
    let end = 42
    guard let url = URL(string: "https://api.edamam.com/search" +
      "?app_id=7eaa9edb&app_key=7b82a875c1c90b7f360a2356f54f2dc1" +
      "&q=Soup&from=\(start)&to=\(end)") else { return }

    stub(url: url, result: data)

    let query = "Soup"
    let resultRange = (start, end)
    let expectation = self.expectation(description: "Fetching a Recipe for range")

    repo.performSearch(forQuery: query, resultRange: resultRange, onComplete: { searchResult in

      expectation.fulfill()

      switch searchResult {
      case .failure(let error):
        print(error)
        XCTFail("Returned Error when it should have fetched valid recipe")
      case .success:
        return
      }
    })
    waitForExpectations(timeout: 5, handler: nil)

    addTeardownBlock {
      Hippolyte.shared.stop()
    }
  }
}
