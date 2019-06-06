//
//  MenuForDay.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/06/04.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//
import  Foundation

class MenuForDay: MenuForDayProtocol {

  private var meals: [String: Recipe?]
  private var date: Date
  var dateString: String {

      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "d MMM yyyy"
      return dateFormatter.string(from: date)

  }
  private let edamamRecipeAPI: EdamamRecipeAPIRepository
  private let validMealTypes: [String]

  init(_ date: Date) {

    meals = [:]
    self.date = date
    edamamRecipeAPI = EdamamRecipeAPIRepository()
    validMealTypes = ["Breakfast", "Lunch", "Dinner"]
    setupMeals()

  }

  private func setupMeals() {

    for type in validMealTypes {
      meals[type] = nil
    }
  }

  func getMealOptions() -> [String] {
    return validMealTypes
  }

  func getRecipe(forMeal meal: String, onComplete: @escaping (Result<Recipe, RecipeError>) -> Void) {

    if !validMealTypes.contains(meal) {

      onComplete(.failure(.invalidMealTypeIdentifier("in MenuForDay.getRecipe with mealtype: \(meal)")))
      return
    }

    if let recipeInDictionary = meals[meal], let recipe = recipeInDictionary {

      onComplete(.success(recipe))

    } else if let recipeID = dates[date.timeIntervalSince1970]?[meal], recipeID != "" {

      edamamRecipeAPI.getRecipe(forID: recipeID, onComplete: { result in

        switch result {
        case .success(let recipe):
          self.meals[meal] = recipe
          onComplete(result)
        default:
          onComplete(result)
        }

      })
      return

    } else {

      onComplete(.failure(
        .noMealExistsForGivenIdentifier("in MenuForDay.getRecipe with mealType \(meal) on \(dateString)")))

    }
  }
}
