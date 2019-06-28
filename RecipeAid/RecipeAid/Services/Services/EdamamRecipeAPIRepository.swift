//
//  EdamamRecipeAPI.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/06/05.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class EdamamRecipeAPIRepository: EdamamRecipeAPIRepositoryProtocol {

  private let baseURL = "https://api.edamam.com/search"
  private let appId = "7eaa9edb"
  private let appKey = "7b82a875c1c90b7f360a2356f54f2dc1"
  var settingsRepo: SettingsRepoProtocol

  init() {
    settingsRepo = SettingsRepo()
  }

  func performSearch(
    forQuery query: String,
    resultRange: (Int, Int),
    onComplete: @escaping (Swift.Result<[Recipe], RecipeError>) -> Void) {

    if query == "" {
      onComplete(.success([]))
      return
    }

    var requestURL = "\(baseURL)?app_id=\(appId)&app_key=\(appKey)&q=\(query)&from=\(resultRange.0)&to=\(resultRange.1)"
    requestURL += buildQueryStringFromSettings()

    getJsonResponse(for: requestURL, onComplete: { result in

      switch result {

      case .success(let jsonArray):
        var toReturn = [Recipe]()

        guard let results = jsonArray[0]["hits"] as? [[String: Any]] else {
          return
        }

        for result in results {
          guard let recipe = result["recipe"] as? [String: Any] else {
            continue
          }
          let attemptToParse = self.buildRecipe([recipe])

          switch attemptToParse {

          case .success(let parsedRecipe):
            toReturn.append(parsedRecipe)

          case .failure(let error):
            print(String(describing: error))
          }
        }

        onComplete(.success(self.filterResultsFromSettings(toReturn)))
        return
      case .failure(let error):
        onComplete(.failure(error))
        return
      }
    })
  }

  func getRecipe(forID recipeID: String, onComplete: @escaping (Swift.Result<Recipe, RecipeError>) -> Void) {

    if recipeID == "" {
      onComplete(.failure(.emptyRecipeID("in EdamamRecipeAPIRepository.getRecipe")))
      return
    }

    let recipeID = recipeID.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
    let requestURL = "\(baseURL)?app_id=\(appId)&app_key=\(appKey)&r=\(recipeID)"

    getJsonResponse(for: requestURL, onComplete: { result in

      switch result {
      case .success(let jsonArray):
        let result = self.buildRecipe(jsonArray)
        onComplete(result)
        return
      case .failure(let error):
        onComplete(.failure(error))
        return
      }
      })
  }

  private func getJsonResponse(
    for urlString: String,
    onComplete: @escaping (Swift.Result<[[String: Any]], RecipeError>) -> Void) {

    guard let url = URL(string: urlString) else {
      onComplete(.failure(.urlBuildError("in EdamamRecipeAPIRepository.getJsonResponse for url: \(urlString)")))
      return
    }

    Alamofire.request(url, method: .get).validate().responseJSON { response in

      guard let data = response.data else {
        onComplete(.failure(
          .errorFetchingRecipe("""
            in EdamamRecipeAPIRepository.getJsonResponse for url: \(urlString)
            with error \(String(describing: response.result.error))
            """)))
        return
      }

      do {
        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])

        var jsonArray = [[String: Any]]()

        if let attempToParse = jsonResponse as? [String: Any] {
          jsonArray = [attempToParse]
        } else if let attempToParse = jsonResponse as? [[String: Any]] {
          jsonArray = attempToParse
        } else {
          onComplete(.failure(
            .invalidJsonObjectRecieved("in EdamamRecipeAPIRepository.getJsonResponse for url: \(urlString)")))
          return
        }

        if jsonArray.isEmpty {

          onComplete(.failure(.emptyJSONRecieved(
            "in EdamamRecipeAPIRepository.getJsonResponse,You have run out of requests to the API")))
          return
        }

        onComplete(.success(jsonArray))
        return
      } catch {

        onComplete(.failure(
          .invalidJsonObjectRecieved("""
            in EdamamRecipeAPIRepository.getRecipe for url: \(urlString)
            with error \(String(describing: response.result.error))
            """)))
        return
      }
    }
  }

  func buildRecipe(_ jsonArr: [[String: Any]]) -> Swift.Result<Recipe, RecipeError> {

    guard let label = jsonArr[0]["label"] as? String else {
      return .failure(.unableToBuildRecipeMissingValues("label"))
    }
    guard let uri = jsonArr[0]["uri"] as? String else {
      return .failure(.unableToBuildRecipeMissingValues("uri"))
    }
    guard let image = jsonArr[0]["image"] as? String else {
      return .failure(.unableToBuildRecipeMissingValues("image"))
    }
    guard let source = jsonArr[0]["source"] as? String else {
      return .failure(.unableToBuildRecipeMissingValues("source"))
    }
    guard let url = jsonArr[0]["url"] as? String else {
      return .failure(.unableToBuildRecipeMissingValues("url"))
    }
    guard let yield = jsonArr[0]["yield"] as? Double else {
      return .failure(.unableToBuildRecipeMissingValues("yield"))
    }
    guard let ingredientLines = jsonArr[0]["ingredientLines"] as? [String] else {
      return .failure(.unableToBuildRecipeMissingValues("ingredientLines"))
    }
    guard let calories = jsonArr[0]["calories"] as? Double else {
      return .failure(.unableToBuildRecipeMissingValues("calories"))
    }

    let recipe = Recipe(
      uri: uri,
      label: label,
      image: image,
      source: source,
      url: url,
      yield: yield,
      ingredientLines: ingredientLines,
      calories: calories
    )
    return .success(recipe)
  }

  func buildQueryStringFromSettings() -> String {

    let timesRange = settingsRepo.getTimesRange()
    let dietryRestrictions = settingsRepo.getRestrictions().sorted(by: { $0.0 < $1.0 })

    var queryString = ""

    if timesRange != (0, 0) {
      queryString += "$time=\(timesRange.0)-\(timesRange.1)"
    }
    for restriction in dietryRestrictions where restriction.1 {
      if let restriction = DietaryRestrictions.getDietryRestriction(fromDescription: restriction.0)?.webKey() {
        queryString += "&\(restriction)"
      }
    }

    return queryString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
  }

  func filterResultsFromSettings(_ recipeSet: [Recipe]) -> [Recipe] {

    let caloriesRange = settingsRepo.getCaloriesRange()
    let unwantedFoods = settingsRepo.getUnwantedFoods()

    let validRecipes = recipeSet.filter { recipe in

      if caloriesRange != (0, 0) {
        if recipe.calories < Double(caloriesRange.0) || recipe.calories > Double(caloriesRange.1) {
          return false
        }
      }

      for food in unwantedFoods {
        for ingredient in recipe.ingredientLines where ingredient.lowercased().contains(food.lowercased()) {
          return false
        }
      }

      return true
    }

    return validRecipes
  }
}
