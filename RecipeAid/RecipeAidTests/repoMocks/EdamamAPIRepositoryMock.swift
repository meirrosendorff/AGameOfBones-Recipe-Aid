//
//  EdamamAPIRepositoryMock.swift
//  RecipeAidTests
//
//  Created by Meir Rosendorff on 2019/06/18.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import Foundation
@testable import RecipeAid

class EdamamRecipeAPIRepositoryMock: EdamamRecipeAPIRepositoryProtocol {

  var recipeName = ""

  var numCallsForGetRecipeMethod = 0
  var numCallsforPerformSearchMethod = 0
  var recipeSetToReturn: [Recipe]?
  var lastSearchRange = (0, 0)

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

  func performSearch(
    forQuery query: String,
    resultRange: (Int, Int),
    onComplete: @escaping (Result<[Recipe], RecipeError>) -> Void) {

    numCallsforPerformSearchMethod += 1
    lastSearchRange = resultRange

    if returnsValidResponse {

      if let toReturn = recipeSetToReturn {
        onComplete(.success(toReturn))
        return
      }

      let recipe = [Recipe(
        uri: query,
        label: query,
        image: query,
        source: query,
        url: query,
        yield: 0,
        ingredientLines: [recipeName],
        calories: 0)]

      onComplete(.success(recipe))
      return
    } else {
      onComplete(.failure(.errorFetchingRecipe("")))
      return
    }
  }
}
