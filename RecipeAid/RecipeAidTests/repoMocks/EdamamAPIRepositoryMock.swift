//
//  EdamamAPIRepositoryMock.swift
//  RecipeAidTests
//
//  Created by Meir Rosendorff on 2019/06/18.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import Foundation
@testable import RecipeAid

func checkEqual(_ left: (Int, Int), _ right: (Int, Int)) -> Bool {
  print("\(left) == \(right)")
  return left.0 == right.0 && left.1 == right.1
}

class EdamamRecipeAPIRepositoryMock: EdamamRecipeAPIRepositoryProtocol {

  var recipeName = ""

  var numCallsForGetRecipeMethod = 0
  var numCallsforPerformSearchMethod = 0
  var numResultsToReturn = 10
  var recipeSetToReturn: [Recipe]?
  var searchRanges = [(Int, Int)]()
  var lastSearchRange: (Int, Int) { return searchRanges.count > 0 ? searchRanges[searchRanges.count - 1] : (0, 0)}

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
    searchRanges.append(resultRange)

    if returnsValidResponse {

      if let toReturn = recipeSetToReturn {
        onComplete(.success(toReturn))
        return
      }

      let toReturn = Recipe(
        uri: query,
        label: query,
        image: query,
        source: query,
        url: query,
        yield: 0,
        ingredientLines: [recipeName],
        calories: 0)

      let recipe = [Recipe] (repeating: toReturn, count: numResultsToReturn)

      onComplete(.success(recipe))
      return
    } else {
      onComplete(.failure(.errorFetchingRecipe("")))
      return
    }
  }
}
