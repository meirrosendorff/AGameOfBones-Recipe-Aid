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

  override func setInteger(value: Int, forKey key: String) {

    switch key {
    case "maxCalories":
      maxCalorioesSetCount += 1
    case "minCalories":
      minCaloriesSetCount += 1
    case "maxtimes":
      maxTimesSetCount += 1
    case "minTime":
      minTimesSetCount += 1
    }
  }

  override func object(forKey key: String) -> Int {

    switch key {
    case "maxCalories":
      maxCalorioesGetCount += 1
      return 0
    case "minCalories":
      minCaloriesGetCount += 1
      return 1
    case "maxtimes":
      maxTimesGetCount += 1
      return 2
    case "minTime":
      minTimesGetCount += 1
      return 3
    }
  }

  override func setValue(_ value: Any?, forKey key: String) {

    switch key {
    case "restrictionOptionsArray":
      restrictionsSetCount += 1
    case "excludedFoodsArray":
      excludedFoodsSetCount += 1
    }
  }

  override func object(forKey defaultName: String) -> Any? {

    switch key {
    case "restrictionOptionsArray":
      restrictionsGetCount += 1
      return [("a", true), ("b", false), ("c", true)]
    case "excludedFoodsArray":
      excludedFoodsGetCount += 1
      return ["a", "b", "c"]
    }
  }
}
