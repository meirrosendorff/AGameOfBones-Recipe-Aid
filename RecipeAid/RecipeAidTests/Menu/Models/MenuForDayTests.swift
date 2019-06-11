//
//  MenuForDayTests.swift
//  RecipeAidTests
//
//  Created by Meir Rosendorff on 2019/06/11.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import XCTest
@testable import RecipeAid

class MenuForDayTests: XCTestCase {

  var model: MenuForDay!
  var recipe: Recipe!
  var validMealType: String!

  override func setUp() {
    model = MenuForDay()
    validMealType = model.getMealOptions()[0]
    recipe  = Recipe(
      uri: "http://www.edamam.com/ontologies/edamam.owl#recipe_dc0bd9f18c68a5710d0fc3fda6512b7b",
      label: "Mont Blanc Ice-Cream Squares",
      image: "https://www.edamam.com/web-img/266/2661363453d5be1fba4af484b956829c.jpg",
      source: "BBC Good Food",
      url: "http://www.bbcgoodfood.com/recipes/8235/",
      yield: 14.0,
      ingredientLines: [ "FOR THE PURÉE",
                         "4 egg whites",
                         "50.0ml double cream",
                         "2 x 1-litre tubs good-quality vanilla icecream (we used Waitrose Seriously Creamy)",
                         "Ingredients FOR THE MERINGUE",
                         "50.0g walnuts",
                         "5 marrons glaces or candied chestnuts , halved",
                         "FOR THE ICE CREAM", "250.0g golden caster sugar",
                         "435.0g can chestnut purée (we used Merchant Gourmet)" ],
      calories: 7586.821023526832)
    super.setUp()
  }

  override func tearDown() {
    model = nil
    recipe = nil
    validMealType = nil
    super.tearDown()
  }

  func testGetRecipeReturnsInvalidMealTypeIdentifierWhenGivenInvalidMealType() {

    let invalidMealType = "InvalidMeal"

    let response = model.getRecipe(forMeal: invalidMealType)

    switch response {
    case .failure(let error):
      switch error {
      case .invalidMealTypeIdentifier:
        return
      default:
        XCTFail("Error other than RecipeError.invalidMealTypeIdentifier when given invalid meal type")
      }
    case .success:
      XCTFail("returns recipe when given an invalid meal type")
    }
  }

  func testGetRecipeReturnsNoMealExistsForGivenIdentifierWhenValidIdentifierWithNoPresetMealIsGiven() {

    let validMealType = "Breakfast"

    let response = model.getRecipe(forMeal: validMealType)

    switch response {
    case .failure(let error):
      switch error {
      case .noMealExistsForGivenIdentifier:
        return
      default:
        XCTFail("Error other than RecipeError.noMealExistsForGivenIdentifier when valid Identifier with no preset meal")
      }
    case .success:
      XCTFail("returns recipe when given valid identifier but with no recipe set for that identifier")
    }
  }

  func testAddRecipeThrowsInvalidMealTypeIdentifierWhenGivenInvalidMealType() {

    let invalidMealType = "InvalidMeal"

    do {
      try model.addRecipe(recipe, for: invalidMealType)
      XCTFail("No error Thrown for invalid meal type")
    } catch RecipeError.invalidMealTypeIdentifier {
      return
    } catch {
      XCTFail("Error other than RecipeError.invalidMealTypeIdentifier thrown when given invalid meal type")
    }
  }

  func testAddRecipeDoesNotThrowErrorWhenGivenValidRecipeType() {

    do {
      try model.addRecipe(recipe, for: validMealType)
      return
    } catch {
      XCTFail("Error Thrown When Valid Meal Type Given")
    }
  }

  func testRecipeCanBeFetchedForMealIdentifierAfterAddingIt() {

    try? model.addRecipe(recipe, for: validMealType)

    let result = model.getRecipe(forMeal: validMealType)

    switch result {
    case .success(let recipeRecieved):
      XCTAssertEqual(recipe, recipeRecieved)
    case .failure:
      XCTFail("Fails to get recipe after adding that recipe with valid meal type")
    }
  }

  func testAddingMultipleRecipesAndThenReadingThemGivesValidResults() {

    let mealTypes = model.getMealOptions()

    for type in mealTypes {

      let currRecipe = Recipe(
        uri: "",
        label: type,
        image: "",
        source: "",
        url: "",
        yield: 0,
        ingredientLines: [],
        calories: 0)

      try? model.addRecipe(currRecipe, for: type)
    }

    for type in mealTypes {

      let currRecipe = Recipe(
        uri: "",
        label: type,
        image: "",
        source: "",
        url: "",
        yield: 0,
        ingredientLines: [],
        calories: 0)

      let result = model.getRecipe(forMeal: type)

      switch result {
      case .success(let recipeRecieved):
        XCTAssertEqual(recipeRecieved, currRecipe)
      default:
        XCTFail("Returned error when recipe was expected")
      }
    }
  }

}
