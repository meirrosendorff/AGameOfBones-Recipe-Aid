//
//  EdamamRecipeAPIRepositoryProtocal.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/06/06.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import Foundation

protocol EdamamRecipeAPIRepositoryProtocol {
  func getRecipe(forID recipeID: String, onComplete: @escaping (Swift.Result<Recipe, RecipeError>) -> Void)
  func buildRecipe(_ jsonArr: [[String: Any]]) -> Swift.Result<Recipe, RecipeError>
}
