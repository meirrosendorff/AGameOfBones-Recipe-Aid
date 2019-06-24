//
//  SettingsRepoProtocol.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/06/24.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import Foundation

protocol SettingsRepoProtocol {

  func getRestrictions() -> [(String, Bool)]
  func setRestrictions(restrictions: [(String, Bool)])
  func getCaloriesRange() -> (Int, Int)
  func setCaloriesRange(calories: (Int, Int))
  func getTimesRange() -> (Int, Int)
  func setTimesRange(times: (Int, Int))
  func getUnwantedFoods() -> [String]
  func setUnwatedFoods(foods: [String])
}
