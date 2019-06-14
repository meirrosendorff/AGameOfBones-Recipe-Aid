//
//  RecipeDetailsViewModelProtocol.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/06/14.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import Foundation

protocol RecipeDetailsViewModelProtocol {

  var numIngredients: Int { get }
  var name: String { get }
  var servings: String { get }
  var calories: String { get }
  var sourceURL: String { get }
  var recipeID: String { get }
  func getIngredient(at pos: Int) -> String
  init(recipe: Recipe)
}
