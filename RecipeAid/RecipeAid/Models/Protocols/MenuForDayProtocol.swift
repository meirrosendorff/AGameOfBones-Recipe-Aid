//
//  File.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/06/06.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import Foundation

protocol MenuForDayProtocol {

  var dateString: String { get }
  func getRecipe(forMeal meal: String, onComplete: @escaping (Result<Recipe, RecipeError>) -> Void)
  func getMealOptions() -> [String]
}
