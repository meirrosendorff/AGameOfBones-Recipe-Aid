//
//  UserDefaultsMock.swift
//  RecipeAidTests
//
//  Created by Meir Rosendorff on 2019/06/24.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import Foundation

class UserDefaultsMock: UserDefaults {

  var minCaloriesGetCount = 0
  var maxCalorioesGetCount = 0
  var minTimesGetCount = 0
  var maxTimesGetCount = 0
  var restrictionsGetCount = 0
  var excludedFoodsGetCount = 0

  var minCaloriesSetCount = 0
  var maxCalorioesSetCount = 0
  var minTimesSetCount = 0
  var maxTimesSetCount = 0
  var restrictionsSetCount = 0
  var excludedFoodsSetCount = 0

  var lastRestrictionsSaved = [String: Bool]()

  override func set(_ value: Int, forKey key: String) {

    switch key {
    case UserDefaultsKeys.maxCalories.rawValue:
      maxCalorioesSetCount += 1
    case UserDefaultsKeys.minCalories.rawValue:
      minCaloriesSetCount += 1
    case UserDefaultsKeys.maxTime.rawValue:
      maxTimesSetCount += 1
    case UserDefaultsKeys.minTime.rawValue:
      minTimesSetCount += 1
    default:
      return
    }
  }

  override func integer(forKey defaultName: String) -> Int {

    switch defaultName {
    case UserDefaultsKeys.maxCalories.rawValue:
      maxCalorioesGetCount += 1
      return 0
    case UserDefaultsKeys.minCalories.rawValue:
      minCaloriesGetCount += 1
      return 1
    case UserDefaultsKeys.maxTime.rawValue:
      maxTimesGetCount += 1
      return 2
    case UserDefaultsKeys.minTime.rawValue:
      minTimesGetCount += 1
      return 3
    default:
      return -1
    }
  }

  override func set(_ value: Any?, forKey defaultName: String) {
    switch defaultName {
    case UserDefaultsKeys.dietryRestrictionsDict.rawValue:
      lastRestrictionsSaved = value as? [String: Bool] ?? [:]
      restrictionsSetCount += 1
    case UserDefaultsKeys.unwantedFoodsArray.rawValue:
      excludedFoodsSetCount += 1
    default:
      return
    }
  }

  override func object(forKey defaultName: String) -> Any? {

    switch defaultName {
    case UserDefaultsKeys.dietryRestrictionsDict.rawValue:
      restrictionsGetCount += 1
      return String(describing: ["a": true, "b": false, "c": true])
    case UserDefaultsKeys.unwantedFoodsArray.rawValue:
      excludedFoodsGetCount += 1
      return ["a", "b", "c"]
    default:
      return nil
    }
  }
}
