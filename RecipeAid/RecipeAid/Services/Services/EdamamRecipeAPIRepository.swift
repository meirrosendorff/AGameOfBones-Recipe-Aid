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

  func getRecipe(forID recipeID: String, onComplete: @escaping (Swift.Result<Recipe, RecipeError>) -> Void) {

    if recipeID == "" {
      onComplete(.failure(.emptyRecipeID("in EdamamRecipeAPIRepository.getRecipe")))
      return
    }

    let recipeID = "http%3A%2F%2Fwww.edamam.com%2Fontologies%2Fedamam.owl%23recipe_\(recipeID)"
    let requestURL = "\(baseURL)?app_id=\(appId)&app_key=\(appKey)&r=\(recipeID)"

    guard let url = URL(string: requestURL) else {
      onComplete(.failure(.urlBuildError("in EdamamRecipeAPIRepository.getRecipe for url: \(requestURL)")))
      return
    }

    Alamofire.request(url, method: .get).validate().responseJSON { response in

      guard let data = response.data else {
        onComplete(.failure(
          .errorFetchingRecipe("""
            in EdamamRecipeAPIRepository.getRecipe for url: \(requestURL)
            with error \(String(describing: response.result.error))
            """)))
        return
      }

      do {
        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])

        guard let jsonArray = jsonResponse as? [[String: Any]] else {
          onComplete(.failure(
            .invalidJsonObjectRecieved("in EdamamRecipeAPIRepository.getRecipe for url: \(requestURL)")))
          return
        }

        if jsonArray.isEmpty {

          return onComplete(.failure(.emptyJSONRecieved(
            "in EdamamRecipeAPIRepository.buildRecipe,You have run out of requests to the API or invalid RecipeID")))
        }

        let result = self.buildRecipe(jsonArray)
        onComplete(result)

      } catch {

        onComplete(.failure(
          .invalidJsonObjectRecieved("""
            in EdamamRecipeAPIRepository.getRecipe for url: \(requestURL)
            with error \(String(describing: response.result.error))
            """)))
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
}
