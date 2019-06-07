//
//  File.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/06/06.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import Foundation

protocol MenuForDayProtocol {

  func getRecipe(forMeal meal: String) -> Result<Recipe, RecipeError>
  func addRecipe(_ recipe: Recipe, for meal: String)
  func getMealOptions() -> [String]
}
