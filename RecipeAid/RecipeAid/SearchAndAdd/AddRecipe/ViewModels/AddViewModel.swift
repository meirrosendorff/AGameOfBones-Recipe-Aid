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
  var repo: PersistantStorageRepoProtocol

  init() {

    repo = CoreDataStorageRepo()
    mealTypes = MealTypes.allCases.map({ $0.description() })
  }

  func addMeal(recipe: Recipe, mealType: String, date: Date) {

    for meal in MealTypes.allCases where meal.description() == mealType {
      repo.saveMeal(withRecipe: recipe, forDate: date, forMeal: meal)
      break
    }
  }
}
