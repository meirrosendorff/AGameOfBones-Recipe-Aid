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
  private let validMealTypes: [String]

  init() {

    meals = [:]
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

  func addRecipe(_ recipe: Recipe, for meal: String) throws {

    if !isValidMealType(meal: meal) {
      throw RecipeError.invalidMealTypeIdentifier("in MenuForDay.addRecipe with mealtype: \(meal)")
    }
    meals[meal] = recipe
  }

  private func isValidMealType(meal: String) -> Bool {
    return validMealTypes.contains(meal)
  }

  func getRecipe(forMeal meal: String) -> Result<Recipe, RecipeError> {

    if !isValidMealType(meal: meal) {

      return .failure(.invalidMealTypeIdentifier("in MenuForDay.getRecipe with mealtype: \(meal)"))
    }

    if let recipeInDictionary = meals[meal], let recipe = recipeInDictionary {

      return .success(recipe)

    } else {

      return .failure(
        .noMealExistsForGivenIdentifier("in MenuForDay.getRecipe with mealType \(meal)"))
    }
  }
}
