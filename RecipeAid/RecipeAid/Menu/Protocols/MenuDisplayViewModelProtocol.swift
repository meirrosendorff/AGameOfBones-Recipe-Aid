//
//  MenuDisplayViewModelProtocal.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/06/04.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//
import Foundation

protocol MenuDisplayViewModelProtocol {

  var dateString: String { get }
  var recipeName: String { get }
  var ingredients: [String] { get }
  var recipeSource: String { get }
  var recipeImageURL: String { get }

  func getMealOptions() -> [String]
  func updateMeal(meal: String, onComplete: @escaping (MenueDisplayViewModel, Bool) -> Void)
  func getImageFromURL(_ url: String, onComplete: @escaping (Data) -> Void)
}
