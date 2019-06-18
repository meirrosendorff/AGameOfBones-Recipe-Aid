//
//  EdamamRecipeAPIRepository.swift
//  RecipeAidTests
//
//  Created by Meir Rosendorff on 2019/06/07.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import XCTest

@testable import RecipeAid
import Hippolyte

class EdamamRecipeAPIRepositoryGetRecipeTests: XCTestCase {

  func stub(url: URL, result: Data) {

    var stub = StubRequest(method: .GET, url: url)
    var response = StubResponse()
    let body = result
    response.body = body
    stub.response = response
    Hippolyte.shared.add(stubbedRequest: stub)
    Hippolyte.shared.start()
  }

  var repo: EdamamRecipeAPIRepository!
  var jsonArray: [[String: Any]]!
  var data: Data!
  var correctRecipe: Recipe!

  override func setUp() {
    super.setUp()

    let exampleRecipeRequestJson = "exampleRecipeRequest"
    let bundle = Bundle(for: type(of: self))
    let path = bundle.path(forResource: exampleRecipeRequestJson, ofType: "json")!
    data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
    let jsonResponse = try? JSONSerialization.jsonObject(with: data!, options: [])
    repo = EdamamRecipeAPIRepository()
    jsonArray = jsonResponse as? [[String: Any]]

    correctRecipe = iceCreamRecipe
  }

  override func tearDown() {
    repo = nil
    jsonArray = nil
    super.tearDown()
  }

  func testBuildRecipeReturnsCorrectRecipeWhenGivenValidJSON() {

    let result = repo.buildRecipe(jsonArray)

    switch result {
    case .failure:
      XCTFail("Failed to build a Recipe with Valid Data")
    case .success(let recipe):
      XCTAssertEqual(recipe, correctRecipe)
    }
  }

  func testBuildRecipeReturnsErrorWhenMissingLabel() {

    jsonArray[0].removeValue(forKey: "label")

    let result = repo.buildRecipe(jsonArray)

    switch result {
    case .failure(let error):
      XCTAssertNotNil(error)
    case .success:
      XCTFail("Returned Recipe When missing Label in JSON")
    }
  }

  func testBuildRecipeReturnsErrorWhenMissingUri() {

    jsonArray[0].removeValue(forKey: "uri")

    let result = repo.buildRecipe(jsonArray)

    switch result {
    case .failure(let error):
      XCTAssertNotNil(error)
    case .success:
      XCTFail("Returned Recipe When missing uri in JSON")
    }
  }

  func testBuildRecipeReturnsErrorWhenMissingImage() {

    jsonArray[0].removeValue(forKey: "image")

    let result = repo.buildRecipe(jsonArray)

    switch result {
    case .failure(let error):
      XCTAssertNotNil(error)
    case .success:
      XCTFail("Returned Recipe When missing image in JSON")
    }
  }

  func testBuildRecipeReturnsErrorWhenMissingSource() {

    jsonArray[0].removeValue(forKey: "source")

    let result = repo.buildRecipe(jsonArray)

    switch result {
    case .failure(let error):
      XCTAssertNotNil(error)
    case .success:
      XCTFail("Returned Recipe When missing source in JSON")
    }
  }

  func testBuildRecipeReturnsErrorWhenMissingUrl() {

    jsonArray[0].removeValue(forKey: "url")

    let result = repo.buildRecipe(jsonArray)

    switch result {
    case .failure(let error):
      XCTAssertNotNil(error)
    case .success:
      XCTFail("Returned Recipe When missing url in JSON")
    }
  }

  func testBuildRecipeReturnsErrorWhenMissingYield() {

    jsonArray[0].removeValue(forKey: "yield")

    let result = repo.buildRecipe(jsonArray)

    switch result {
    case .failure(let error):
      XCTAssertNotNil(error)
    case .success:
      XCTFail("Returned Recipe When missing yield in JSON")
    }
  }

  func testBuildRecipeReturnsErrorWhenMissingIngredientsLines() {

    jsonArray[0].removeValue(forKey: "ingredientLines")

    let result = repo.buildRecipe(jsonArray)

    switch result {
    case .failure(let error):
      XCTAssertNotNil(error)
    case .success:
      XCTFail("Returned Recipe When missing ingredientLines in JSON")
    }
  }

  func testBuildRecipeReturnsErrorWhenMissingCalories() {

    jsonArray[0].removeValue(forKey: "calories")

    let result = repo.buildRecipe(jsonArray)

    switch result {
    case .failure(let error):
      XCTAssertNotNil(error)
    case .success:
      XCTFail("Returned Recipe When missing calories in JSON")
    }
  }

  func testGetRecipeReturnsEmptyRecipeIDErrorWhenGivenEmptyRecipeID() {

    let emptyID = ""

    let expectation = self.expectation(description: "Should Error Out")

    repo.getRecipe(forID: emptyID, onComplete: { result in

      expectation.fulfill()

      switch result {
      case .success:
        XCTFail("returned recipe when given empty recipeID")
      case .failure(let error):
        switch error {
        case .emptyRecipeID:
          return
        default:
          XCTFail("Returned error other than RecipeError.emptyRecipeID when given empty recipeID")
        }
      }
    })

    waitForExpectations(timeout: 5, handler: nil)

    addTeardownBlock {
      Hippolyte.shared.stop()
    }
  }

  func testGetRecipeReturnsValidRecipeWhenGivenValidRecipeID() {

    guard let url = URL(string: "https://api.edamam.com/search" +
      "?app_id=7eaa9edb&app_key=7b82a875c1c90b7f360a2356f54f2dc1" +
      "&r=http%3A%2F%2Fwww.edamam.com%2Fontologies%2Fedamam.owl%23" +
      "recipe_dc0bd9f18c68a5710d0fc3fda6512b7b") else { return }

    stub(url: url, result: data)

    let validID = "dc0bd9f18c68a5710d0fc3fda6512b7b"

    let expectation = self.expectation(description: "Feching Recipe Details")

    repo.getRecipe(forID: validID, onComplete: { result in
      expectation.fulfill()

      switch result {
      case .failure:
        XCTFail("Returned Error when attempting to fetch valid recipe")
      case .success(let recipe):
        XCTAssertEqual(recipe, self.correctRecipe)
      }
    })

    waitForExpectations(timeout: 5, handler: nil)

    addTeardownBlock {
      Hippolyte.shared.stop()
    }
  }

  func testGetRecipeReturnsEmptyJsonRecievedErrorWhenRecievingEmptyJsonResponse () {

    guard let url = URL(string: "https://api.edamam.com/search" +
      "?app_id=7eaa9edb&app_key=7b82a875c1c90b7f360a2356f54f2dc1" +
      "&r=http%3A%2F%2Fwww.edamam.com%2Fontologies%2Fedamam.owl%23" +
      "recipe_invalidID") else { return }

    stub(url: url, result: "[]".data(using: .utf8)!)

    let invalidID = "invalidID"

    let expectation = self.expectation(description: "Feching Recipe Details should fail")

    repo.getRecipe(forID: invalidID, onComplete: { result in

      expectation.fulfill()

      switch result {
      case .failure(let error):
        switch error {
        case .emptyJSONRecieved (let error):
          XCTAssertNotNil(error)
        default:
          XCTFail("Returned error other than RecipeError.emptyJSONRecieved when recieving empty JSON")
        }
      case .success:
        XCTFail("Returned recipe when given empty Json, expected an error")
      }
    })

    waitForExpectations(timeout: 5, handler: nil)

    addTeardownBlock {
      Hippolyte.shared.stop()
    }
  }

  func testGetRecipeReturnsInavlidJsonRecievedErrorWhenRecievingInvalidJsonResponse () {

    guard let url = URL(string: "https://api.edamam.com/search" +
      "?app_id=7eaa9edb&app_key=7b82a875c1c90b7f360a2356f54f2dc1" +
      "&r=http%3A%2F%2Fwww.edamam.com%2Fontologies%2Fedamam.owl%23" +
      "recipe_invalidID") else { return }

    stub(url: url, result: "invalid json response".data(using: .utf8)!)

    let invalidID = "invalidID"

    let expectation = self.expectation(description: "Feching Recipe Details should fail")

    repo.getRecipe(forID: invalidID, onComplete: { result in
      expectation.fulfill()

      switch result {
      case .failure(let error):
        switch error {
        case .invalidJsonObjectRecieved:
          return
        default:
          XCTFail("Returned error other than RecipeError.invalidJsonObjectRecieved when recieving empty JSON")
        }
      case .success:
        XCTFail("Returned recipe when given invalid Json, expected an error")
      }
    })

    waitForExpectations(timeout: 5, handler: nil)

    addTeardownBlock {
      Hippolyte.shared.stop()
    }
  }
}
