//
//  RecipeDetailsViewModel.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/06/14.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import Foundation

class RecipeDetailsViewModel: RecipeDetailsViewModelProtocol {

  var recipe: Recipe
  var numIngredients: Int { return recipe.ingredientLines.count }
  var name: String { return recipe.label }
  var servings: String { return "Servings: \(Int(recipe.yield.rounded()))" }
  var calories: String {  return "Calories: \(Int(recipe.calories.rounded()))" }
  var sourceURL: String { return recipe.url }

  required init(recipe: Recipe) {
    self.recipe = recipe
  }

  func getIngredient(at pos: Int) -> String {
    return recipe.ingredientLines[pos]
  }
}
