//
//  RecipeDetailsViewModelTests.swift
//  RecipeAidTests
//
//  Created by Meir Rosendorff on 2019/06/19.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import Foundation

@testable import RecipeAid
import XCTest

class RecipeDetailsViewModelTests: XCTestCase {

  var viewModel: RecipeDetailsViewModelProtocol!

  override func setUp() {

    viewModel = RecipeDetailsViewModel(recipe: dummyRecipe)
    super.setUp()
  }

  override func tearDown() {

    viewModel = nil
    super.tearDown()
  }

  func testNumIngredientsReturnsCorrectIngredientNumber() {

    XCTAssertEqual(viewModel.numIngredients, 10)
  }

  func testGetIngredientsReturnsCorrectIngredients() {

    for pos in 0..<10 {
      XCTAssertEqual(viewModel.getIngredient(at: pos), "Ingredient \(pos)")
    }
  }

  func testNameReturnsCorrectName() {

    XCTAssertEqual(viewModel.name, "name")
  }

  func testServingsReturnsCorrectServingsString() {

    XCTAssertEqual(viewModel.servings, "Servings: 42")
  }

  func testCaloriesReturnsCorrectCaloriesString() {

    XCTAssertEqual(viewModel.calories, "Calories: 42")
  }

  func testSourceURLReturnsCorrectSourceString() {

    XCTAssertEqual(viewModel.sourceURL, "sourceURL")
  }

  func testRecipeIDReturnsCorrectID() {
    XCTAssertEqual(viewModel.recipeID, "uri")
  }
}
