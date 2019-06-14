//
//  addViewModel.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/06/14.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import Foundation

class AddViewModel: AddViewModelProtocol {
  var mealTypes: [String]

  init() {
    mealTypes = ["Breakfast", "Lunch", "Dinner"]
  }

  func addMeal(recipeID: String, mealType: String, date: Date) {
    //Add recipe to persistant storage once it is set up.
    print("Adding Recipe for meal: \(mealType), for recipe: \(recipeID), on date: \(date.description)")
  }
}
