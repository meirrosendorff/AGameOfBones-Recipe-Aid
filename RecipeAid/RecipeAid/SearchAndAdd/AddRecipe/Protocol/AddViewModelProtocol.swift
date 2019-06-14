//
//  AddViewModelProtocol.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/06/14.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import Foundation

protocol AddViewModelProtocol {

  var mealTypes: [String] { get }
  func addMeal(recipeID: String, mealType: String, date: Date)
}
