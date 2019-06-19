//
//  AddRecipeTests.swift
//  RecipeAidTests
//
//  Created by Meir Rosendorff on 2019/06/19.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//
@testable import RecipeAid
import XCTest

class AddRecipeTests: XCTestCase {

  var viewModel: AddViewModelProtocol!

  override func setUp() {

    super.setUp()
    viewModel = AddViewModel()
  }

  override func tearDown() {

    viewModel = nil
    super.tearDown()
  }

  func testIngredientSetIsNonEmpty() {

    XCTAssertFalse(viewModel.mealTypes.isEmpty)
  }

  //Will test add method once some logic is added
}
