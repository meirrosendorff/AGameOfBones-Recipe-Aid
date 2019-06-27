//
//  PersistantStorageRepoProtocol.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/06/26.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import Foundation

protocol PersistantStorageRepoProtocol {

  func saveMeal(withRecipe: Recipe, forDate: Date, forMeal: MealTypes)
  func getRecipeID(forDate date: Date, forMeal meal: MealTypes, onComplete: @escaping (String) -> Void)
  func getShoppingItems(forDate date: Date, forDays: Int, onComplete: @escaping ([ShoppingItem]) -> Void)
  func updateShoppingItem(_ item: ShoppingItem)
}
