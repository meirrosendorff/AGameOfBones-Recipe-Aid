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
import Cuckoo

class EdamamRecipeAPIRepositorySearchTests: XCTestCase {

  func stubURL(url: URL, result: Data) {

    var stub = StubRequest(method: .GET, url: url)
    var response = StubResponse()
    let body = result
    response.body = body
    stub.response = response
    Hippolyte.shared.add(stubbedRequest: stub)
    Hippolyte.shared.start()
  }

  func stubForEmptySettings() {
    stub(settingsRepoMock) { stub in
      when(stub.getCaloriesRange()).thenReturn((0, 0))
      when(stub.getTimesRange()).thenReturn((0, 0))
      when(stub.getRestrictions()).thenReturn([(String, Bool)]())
      when(stub.getUnwantedFoods()).thenReturn([String]())
    }
  }

  var correctSearchResult: [Recipe]!
  var repo: EdamamRecipeAPIRepository!
  var data: Data!
  var settingsRepoMock: MockSettingsRepo!

  override func setUp() {

    super.setUp()
    correctSearchResult = soupSearchRecipeSet
    repo = EdamamRecipeAPIRepository()
    settingsRepoMock = MockSettingsRepo()
    repo.settingsRepo = settingsRepoMock
    let exampleRecipeRequestJson = "exampleSearchResult"
    let bundle = Bundle(for: type(of: self))
    let path = bundle.path(forResource: exampleRecipeRequestJson, ofType: "json")!
    data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
  }

  override func tearDown() {

    correctSearchResult = nil
    repo = nil
    data = nil
    settingsRepoMock = nil
    super.tearDown()
  }

  func testPerformSearchReturnsCorrectSetOfSearchResults() {

    guard let url = URL(string: "https://api.edamam.com/search" +
      "?app_id=7eaa9edb&app_key=7b82a875c1c90b7f360a2356f54f2dc1" +
      "&q=Soup&from=0&to=10") else { return }
     stubURL(url: url, result: data)

    stubForEmptySettings()

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

    stubForEmptySettings()

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

    stubForEmptySettings()

    let start = 42
    let end = 42
    guard let url = URL(string: "https://api.edamam.com/search" +
      "?app_id=7eaa9edb&app_key=7b82a875c1c90b7f360a2356f54f2dc1" +
      "&q=Soup&from=\(start)&to=\(end)") else { return }

    stubURL(url: url, result: data)

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

  func testBuildQueryFromSettingsReturnsEmptyWhenNothingSet() {

    stubForEmptySettings()

    let emptyQuery = ""

    let query = repo.buildQueryStringFromSettings()

    XCTAssertEqual(query, emptyQuery)
  }

  func testBuildQueryFromSettingsReturnsTimesQueryCorrectly() {

    stubForEmptySettings()
    let range = (0, 42)

    stub(settingsRepoMock) { stub in
      when(stub.getTimesRange()).thenReturn(range)
    }

    let query = repo.buildQueryStringFromSettings()

    XCTAssertEqual(query, "&time=\(range.0)-\(range.1)")
  }

  func testBuildQueryFromSettingsOnlyReturnsRestrictionsThatAreEnabled() {

    stubForEmptySettings()

    let restrictions = [(DietaryRestrictions.alcoholFree.description(), true),
                        (DietaryRestrictions.lowCarb.description(), false),
                        (DietaryRestrictions.lowFat.description(), true)]

    stub(settingsRepoMock) { stub in
      when(stub.getRestrictions()).thenReturn(restrictions)
    }

    let query = repo.buildQueryStringFromSettings()

    XCTAssertEqual(
      query, "&\(DietaryRestrictions.alcoholFree.webKey())&\(DietaryRestrictions.lowFat.webKey())")
  }

  func testFilterResultsFromSettingsDoesNotDeleteResultsWhenEmptySettings() {

    stubForEmptySettings()

    let recipes = [dummyRecipe]

    let recipesReturned = repo.filterResultsFromSettings(recipes)

    XCTAssertEqual(recipesReturned.count, 1)
  }

  func testFilterResultsFromSettingsRemovesRecipesWithCaloriesLessThanMin() {

    stubForEmptySettings()

    let min = Int(dummyRecipe.calories + 1)
    let max = Int(dummyRecipe.calories + 2)

    stub(settingsRepoMock) { stub in
      when(stub.getCaloriesRange()).thenReturn((min, max))
    }

    let recipes = [dummyRecipe]

    let recipesReturned = repo.filterResultsFromSettings(recipes)

    XCTAssertEqual(recipesReturned.count, 0)
  }

  func testFilterResultsFromSettingsRemovesRecipesWithCaloriesGreaterThanMax() {

    stubForEmptySettings()

    let min = Int(dummyRecipe.calories - 2)
    let max = Int(dummyRecipe.calories - 1)

    stub(settingsRepoMock) { stub in
      when(stub.getCaloriesRange()).thenReturn((min, max))
    }

    let recipes = [dummyRecipe]

    let recipesReturned = repo.filterResultsFromSettings(recipes)

    XCTAssertEqual(recipesReturned.count, 0)
  }

  func testFilterResultsFromSettingsLeavesRecipesWithValidCalories() {

    stubForEmptySettings()

    let recipes = [dummyRecipe]

    let min = Int(dummyRecipe.calories - 1)
    let max = Int(dummyRecipe.calories + 1)

    stub(settingsRepoMock) { stub in
      when(stub.getCaloriesRange()).thenReturn((min, max))
    }

    let recipesReturned = repo.filterResultsFromSettings(recipes)

    XCTAssertEqual(recipesReturned.count, 1)
  }

  func testFilterResultsRemovesAllRecipesWithIngredientStringContainingANonAllowedFood() {

    stubForEmptySettings()

    let recipes = [dummyRecipe]

    let unwantedFoods = ["Ingredient"]

    stub(settingsRepoMock) { stub in
      when(stub.getUnwantedFoods()).thenReturn(unwantedFoods)
    }

    let recipesReturned = repo.filterResultsFromSettings(recipes)

    XCTAssertEqual(recipesReturned.count, 0)
  }

  func testFilterResultsLeavesAllRecipesWithIngredientStringContainingANonAllowedFood() {

    stubForEmptySettings()

    let recipes = [dummyRecipe]

    let unwantedFoods = ["This is not in any of the ingredients"]

    stub(settingsRepoMock) { stub in
      when(stub.getUnwantedFoods()).thenReturn(unwantedFoods)
    }

    let recipesReturned = repo.filterResultsFromSettings(recipes)

    XCTAssertEqual(recipesReturned.count, 1)
  }
}
