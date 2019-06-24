//
//  SettingsRepo.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/06/24.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import Foundation

class SettingsRepo: SettingsRepoProtocol {

  var userDefaults: UserDefaults
  private let restrictionsKey: String
  private let minCaloriesKey: String
  private let maxCaloriesKey: String
  private let minTimesKey: String
  private let maxTimesKey: String
  private let excludedFoodsKey: String

  init() {
    userDefaults = UserDefaults.standard
    restrictionsKey = "restrictionOptionsArray"
    minCaloriesKey = "minCalories"
    maxCaloriesKey = "maxCalories"
    minTimesKey = "minTimes"
    maxTimesKey = "maxTimes"
    excludedFoodsKey = "excludedFoodsArray"
  }

  func getRestrictions() -> [(String, Bool)] {

    let dict = userDefaults.object(forKey: restrictionsKey) as? [String: Bool] ?? [String: Bool]()

    var restrictions: [(String, Bool)] = []
    for (name, isSelected) in dict {
      restrictions.append((name, isSelected))
    }

    return restrictions
  }

  func setRestrictions(restrictions: [(String, Bool)]) {

    let restrictionsToSave = restrictions.reduce(into: [:]) { $0[$1.0] = $1.1 }
    userDefaults.set(restrictionsToSave, forKey: restrictionsKey)
  }

  func getCaloriesRange() -> (Int, Int) {

    let min = userDefaults.integer(forKey: minCaloriesKey)
    let max = userDefaults.integer(forKey: maxCaloriesKey)

    return (min, max)
  }

  func setCaloriesRange(calories: (Int, Int)) {

    userDefaults.set(calories.0, forKey: minCaloriesKey)
    userDefaults.set(calories.1, forKey: maxCaloriesKey)
  }

  func getTimesRange() -> (Int, Int) {

    let min = userDefaults.integer(forKey: minTimesKey)
    let max = userDefaults.integer(forKey: maxTimesKey)

    return (min, max)
  }

  func setTimesRange(times: (Int, Int)) {

    userDefaults.set(times.0, forKey: minTimesKey)
    userDefaults.set(times.1, forKey: maxTimesKey)
  }

  func getUnwantedFoods() -> [String] {

    let foods = userDefaults.object(forKey: excludedFoodsKey) as? [String] ?? []
    return foods
  }

  func setUnwatedFoods(foods: [String]) {

    userDefaults.set(foods, forKey: excludedFoodsKey)
  }
}
