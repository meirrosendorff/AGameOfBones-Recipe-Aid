//
//  MenuDisplayViewModelTests.swift
//  RecipeAidTests
//
//  Created by Meir Rosendorff on 2019/06/11.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import XCTest
import Hippolyte
@testable import RecipeAid

class MenuDisplayViewModelTests: XCTestCase {

  var menu: MenuForDayMock!
  var repo: EdamamRecipeAPIRepositoryMock!
  var viewModel: MenuDisplayViewModelMock!
  var validMealTypes: [String]!
  var date: Date!

  override func setUp() {

    menu = MenuForDayMock()
    validMealTypes = menu.getMealOptions()
    repo = EdamamRecipeAPIRepositoryMock(returnsValidResponse: true)
    date = Date()
    viewModel = MenuDisplayViewModelMock(forDate: date, repo: repo, menu: menu)
    super.setUp()
  }

  override func tearDown() {
    menu = nil
    validMealTypes = nil
    repo = nil
    viewModel = nil
    date = nil
    Hippolyte.shared.stop()
    super.tearDown()
  }

  func testUpdateMealChecksIfMealIsInModelAndWhenNotItThenFetchesFromRepo() {
    let validMealType = validMealTypes[0]
    let expectation = self.expectation(description: "fetching Recipe Should Succeed")

    viewModel.updateMeal(meal: validMealType, onComplete: { _, resultsUpdated in

      expectation.fulfill()

      XCTAssert(resultsUpdated)
      XCTAssertEqual(self.menu.numCallsForGetRecipeMethod, 1)
      XCTAssertEqual(self.menu.numCallsForAddRecipeMethod, 1)
      XCTAssertEqual(self.repo.numCallsForGetRecipeMethod, 1)
      })

    waitForExpectations(timeout: 5, handler: nil)
  }

  func testUpdateMealChecksIfMealIsInModelAndWhenIsDoesNotFetchFromRepoOrAddIt() {

    let validMealType = validMealTypes[0]
    let firstExpectation = self.expectation(description: "Adding Recipe First Time to Model")

    viewModel.updateMeal(meal: validMealType, onComplete: { _, _ in

      firstExpectation.fulfill()
    })

    waitForExpectations(timeout: 5, handler: nil)

    let secondExpectation = self.expectation(description: "Adding Recipe Second Time to Repo")

    viewModel.updateMeal(meal: validMealType, onComplete: { _, resultsUpdated in

      secondExpectation.fulfill()

      XCTAssert(resultsUpdated)
      XCTAssertEqual(self.menu.numCallsForGetRecipeMethod, 2)
      XCTAssertEqual(self.menu.numCallsForAddRecipeMethod, 1)
      XCTAssertEqual(self.repo.numCallsForGetRecipeMethod, 1)
    })

    waitForExpectations(timeout: 5, handler: nil)
  }

  func testUpdateMealUpdatesDetailsWhenItRecievesMealFromRepo() {

    let validMealType = validMealTypes[0]
    let expectation = self.expectation(description: "Adding Recipe To repo")

    viewModel.updateMeal(meal: validMealType, onComplete: { resultViewModel, _ in

      expectation.fulfill()

      XCTAssertEqual(resultViewModel.recipeSource, validMealType)
      XCTAssertEqual(resultViewModel.recipeImageURL, validMealType)
      XCTAssertEqual(resultViewModel.recipeName, validMealType)
      XCTAssertEqual(resultViewModel.ingredients, [validMealType])
    })

    waitForExpectations(timeout: 5, handler: nil)
  }

  func testUpdateMealUpdatesDetailsWhenItRecievesMealFromModel() {

    let firstMeal = validMealTypes[0]
    let secondMeal = validMealTypes[1]

    let firstExpectation = self.expectation(description: "Adding Recipe First Time to Model")

    viewModel.updateMeal(meal: firstMeal, onComplete: { _, _ in

      firstExpectation.fulfill()
    })
    waitForExpectations(timeout: 5, handler: nil)

    let secondExpectation = self.expectation(description: "Adding Second Recipe to model")

    viewModel.updateMeal(meal: secondMeal, onComplete: { _, _ in

      secondExpectation.fulfill()
    })
    waitForExpectations(timeout: 5, handler: nil)

    let thirdExpectation = self.expectation(description: "Readding first recipe, should take from model")

    viewModel.updateMeal(meal: firstMeal, onComplete: { resultViewModel, resultsUpdated in

      thirdExpectation.fulfill()

      XCTAssert(resultsUpdated)
      XCTAssertEqual(self.menu.numCallsForGetRecipeMethod, 3)
      XCTAssertEqual(self.menu.numCallsForAddRecipeMethod, 2)
      XCTAssertEqual(self.repo.numCallsForGetRecipeMethod, 2)
      XCTAssertEqual(resultViewModel.recipeSource, firstMeal)
      XCTAssertEqual(resultViewModel.recipeImageURL, firstMeal)
      XCTAssertEqual(resultViewModel.recipeName, firstMeal)
      XCTAssertEqual(resultViewModel.ingredients, [firstMeal])
    })

    waitForExpectations(timeout: 5, handler: nil)
  }

  func testUpdateMealDoesNotUpdateVariablesOrAddRecipeToModelWhenRepoReturnsError() {

    let firstMeal = validMealTypes[0]
    let secondMeal = validMealTypes[1]

    let firstExpectation = self.expectation(description: "Adding Recipe First Time to Model")

    viewModel.updateMeal(meal: firstMeal, onComplete: { _, _ in

      firstExpectation.fulfill()
    })
    waitForExpectations(timeout: 5, handler: nil)
    repo.returnsValidResponse = false
    let expectation = self.expectation(description: "fetching Recipe Should fail")

    viewModel.updateMeal(meal: secondMeal, onComplete: { resultViewModel, resultsUpdated in

      expectation.fulfill()

      XCTAssertFalse(resultsUpdated)
      XCTAssertEqual(self.menu.numCallsForGetRecipeMethod, 2)
      XCTAssertEqual(self.menu.numCallsForAddRecipeMethod, 1)
      XCTAssertEqual(self.repo.numCallsForGetRecipeMethod, 2)
      XCTAssertEqual(resultViewModel.recipeSource, firstMeal)
      XCTAssertEqual(resultViewModel.recipeImageURL, firstMeal)
      XCTAssertEqual(resultViewModel.recipeName, firstMeal)
      XCTAssertEqual(resultViewModel.ingredients, [firstMeal])
    })

    waitForExpectations(timeout: 5, handler: nil)
  }

  func testUpdateMealDoesNotUpdateVariablesOrAddRecipeToModelOrCallRepoWhenModelGetRecipeReturnsError() {

    let firstMeal = validMealTypes[0]
    let secondMeal = validMealTypes[1]

    let firstExpectation = self.expectation(description: "Adding Recipe First Time to Model")

    viewModel.updateMeal(meal: firstMeal, onComplete: { _, _ in

      firstExpectation.fulfill()
    })
    waitForExpectations(timeout: 5, handler: nil)
    menu.getRecipeReturnsError = true
    let expectation = self.expectation(description: "fetching Recipe Should fail")

    viewModel.updateMeal(meal: secondMeal, onComplete: { resultViewModel, resultsUpdated in

      expectation.fulfill()

      XCTAssertFalse(resultsUpdated)
      XCTAssertEqual(self.menu.numCallsForGetRecipeMethod, 2)
      XCTAssertEqual(self.menu.numCallsForAddRecipeMethod, 1)
      XCTAssertEqual(self.repo.numCallsForGetRecipeMethod, 1)
      XCTAssertEqual(resultViewModel.recipeSource, firstMeal)
      XCTAssertEqual(resultViewModel.recipeImageURL, firstMeal)
      XCTAssertEqual(resultViewModel.recipeName, firstMeal)
      XCTAssertEqual(resultViewModel.ingredients, [firstMeal])
    })

    waitForExpectations(timeout: 5, handler: nil)
  }
  func testUpdateMealDoesNotUpdateVariablesOrAddRecipeToModelOrCallRepoWhenModelAddRecipeReturnsError() {

    let firstMeal = validMealTypes[0]
    let secondMeal = validMealTypes[1]

    let firstExpectation = self.expectation(description: "Adding Recipe First Time to Model")

    viewModel.updateMeal(meal: firstMeal, onComplete: { _, _ in

      firstExpectation.fulfill()
    })
    waitForExpectations(timeout: 5, handler: nil)
    menu.addRecipeReturnsError = true
    let expectation = self.expectation(description: "fetching Recipe Should fail")

    viewModel.updateMeal(meal: secondMeal, onComplete: { resultViewModel, resultsUpdated in

      expectation.fulfill()

      XCTAssertFalse(resultsUpdated)
      XCTAssertEqual(self.menu.numCallsForGetRecipeMethod, 2)
      XCTAssertEqual(self.menu.numCallsForAddRecipeMethod, 2)
      XCTAssertEqual(self.repo.numCallsForGetRecipeMethod, 2)
      XCTAssertEqual(resultViewModel.recipeSource, firstMeal)
      XCTAssertEqual(resultViewModel.recipeImageURL, firstMeal)
      XCTAssertEqual(resultViewModel.recipeName, firstMeal)
      XCTAssertEqual(resultViewModel.ingredients, [firstMeal])
    })

    waitForExpectations(timeout: 5, handler: nil)
  }

  func testDateStringGetterReturnsDateInCorrectFormat() {

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "d MMM yyyy"

    let dateString = dateFormatter.string(from: date)

    XCTAssertEqual(dateString, viewModel.dateString)
  }

  func testGetMealOptionsReturnsNonEmptyArray() {

    XCTAssertFalse(viewModel.getMealOptions().isEmpty)
  }

  func testGetImageFromURLFetchesCorrectImage() {

    let imageToGet = "check this cool image"
    let urlAsString = "https://www.edamam.com/web-img/266/2661363453d5be1fba4af484b956829c.jpg"
    guard let url = URL(string: urlAsString) else { return }
    var stub = StubRequest(method: .GET, url: url)
    var response = StubResponse()
    let body = imageToGet.data(using: .utf8)!
    response.body = body
    stub.response = response
    Hippolyte.shared.add(stubbedRequest: stub)
    Hippolyte.shared.start()

    let expectation = self.expectation(description: "Should Fetch Image")

    viewModel.getImageFromURL(urlAsString, onComplete: { dataRecieved in

      expectation.fulfill()
      XCTAssertEqual(body, dataRecieved)
    })

    waitForExpectations(timeout: 5, handler: nil)
  }

  func testGetImageFromURLDoesNotCallCompletionHandlerWhenErrorFetchingImage() {

    let urlAsString = "https://www.edamam.com/web-img/266/2661363453d5be1fba4af484b956829c.jpg"
    guard let url = URL(string: urlAsString) else { return }
    var stub = StubRequest(method: .GET, url: url)
    let response = StubResponse(error: RecipeError.unableToFetchImage("") as NSError)
    stub.response = response
    Hippolyte.shared.add(stubbedRequest: stub)
    Hippolyte.shared.start()

    let expectation = self.expectation(description: "Should Fail to Fetch Image")
    expectation.isInverted = true

    viewModel.getImageFromURL(urlAsString, onComplete: { data in
      print(String(describing: data))
      expectation.fulfill()
    })

    waitForExpectations(timeout: 2, handler: nil)
  }
}
