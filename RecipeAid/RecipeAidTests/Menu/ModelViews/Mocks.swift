//
//  MenuForDayMock.swift
//  RecipeAidTests
//
//  Created by Meir Rosendorff on 2019/06/11.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import Foundation
@testable import RecipeAid

class MenuForDayMock: MenuForDay {

  var numCallsForAddRecipeMethod: Int
  var numCallsForGetRecipeMethod: Int
  var getRecipeReturnsError: Bool
  var addRecipeReturnsError: Bool

  override init() {
    numCallsForAddRecipeMethod = 0
    numCallsForGetRecipeMethod = 0
    getRecipeReturnsError = false
    addRecipeReturnsError = false
    super.init()
  }

  override func getRecipe(forMeal meal: String) -> Result<Recipe, RecipeError> {
    numCallsForGetRecipeMethod += 1
    if getRecipeReturnsError {
      return .failure(.errorFetchingRecipe(""))
    }
    return super.getRecipe(forMeal: meal)
  }

  override func addRecipe(_ recipe: Recipe, for meal: String) throws {
    numCallsForAddRecipeMethod += 1
    if addRecipeReturnsError {
      throw RecipeError.errorFetchingRecipe("")
    }
    do {
      try super.addRecipe(recipe, for: meal)
    } catch {
      throw error
    }
  }
}

class EdamamRecipeAPIRepositoryMock: EdamamRecipeAPIRepositoryProtocol {

  var recipeName = ""

  var numCallsForGetRecipeMethod = 0

  var returnsValidResponse: Bool

  init(returnsValidResponse: Bool) {
    self.returnsValidResponse = returnsValidResponse
  }

  func getRecipe(forID recipeID: String, onComplete: @escaping (Result<Recipe, RecipeError>) -> Void) {

    numCallsForGetRecipeMethod += 1

    recipeName = recipeID

    if returnsValidResponse {
      let recipe = Recipe(
        uri: recipeName,
        label: recipeName,
        image: recipeName,
        source: recipeName,
        url: recipeName,
        yield: 0,
        ingredientLines: [recipeName],
        calories: 0)

      onComplete(.success(recipe))
    } else {
      onComplete(.failure(.errorFetchingRecipe("")))
    }

  }

  func buildRecipe(_ jsonArr: [[String: Any]]) -> Result<Recipe, RecipeError> {

    if returnsValidResponse {
      let recipe = Recipe(
        uri: recipeName,
        label: recipeName,
        image: recipeName,
        source: recipeName,
        url: recipeName,
        yield: 0,
        ingredientLines: [recipeName],
        calories: 0)

      return .success(recipe)
    } else {
      return .failure(.errorFetchingRecipe(""))
    }
  }
}

class MenuDisplayViewModelMock: MenueDisplayViewModel {

  init(forDate date: Date, repo: EdamamRecipeAPIRepositoryProtocol, menu: MenuForDayProtocol) {
    super.init(forDate: date)
    self.repo = repo
    self.menu = menu
  }

  override func getRecipeIDToFetch(forMeal meal: String) -> Result<String, RecipeError> {
    return .success(meal)
  }
}
