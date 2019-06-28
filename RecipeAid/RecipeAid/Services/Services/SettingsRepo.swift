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
  private let unwantedFoodsKey: String

  init() {
    userDefaults = UserDefaults.standard
    restrictionsKey = UserDefaultsKeys.dietryRestrictionsDict.rawValue
    minCaloriesKey = UserDefaultsKeys.minCalories.rawValue
    maxCaloriesKey = UserDefaultsKeys.maxCalories.rawValue
    minTimesKey = UserDefaultsKeys.minTime.rawValue
    maxTimesKey = UserDefaultsKeys.maxTime.rawValue
    unwantedFoodsKey = UserDefaultsKeys.unwantedFoodsArray.rawValue
  }

  func getRestrictions() -> [(String, Bool)] {

    let dict = userDefaults.object(forKey: restrictionsKey) as? [String: Bool] ?? [String: Bool]()

    var restrictions: [(String, Bool)] = []
    for (key, isSelected) in dict {
      let name = DietaryRestrictions.getDietryRestriction(fromKey: key)?.description() ?? ""
      restrictions.append((name, isSelected))
    }

    return restrictions
  }

  func setRestrictions(restrictions: [(String, Bool)]) {

//    let restrictionsToSave = restrictions.reduce(into: [:]) {
//
//      guard let key = DietaryRestrictions.getDietryRestriction(fromDescription: $1.0).webKey() else { return }
//      $0[key] = $1.1
//    }

    var restrictionsToSave = [String: Bool]()

    for set in restrictions {
      if let restriction = DietaryRestrictions.getDietryRestriction(fromDescription: set.0)?.webKey() {
        restrictionsToSave[restriction] = set.1
      }
    }

    print(restrictionsToSave)
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

    let foods = userDefaults.object(forKey: unwantedFoodsKey) as? [String] ?? []
    return foods
  }

  func setUnwatedFoods(foods: [String]) {

    userDefaults.set(foods, forKey: unwantedFoodsKey)
  }
}
