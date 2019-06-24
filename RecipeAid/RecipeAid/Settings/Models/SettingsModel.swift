//
//  SettingsModel.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/06/21.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import Foundation

class SettingsModel {

  var profilePic: String
  var userName: String
  var emailAddress: String
  var minCalories: Int
  var maxCalories: Int
  var minTime: Int
  var maxTime: Int
  var unwantedFoods: [String]
  private var restrictionsSet: [(String, Bool)]
  var restrictions: [(String, Bool)] {
    set {
      restrictionsSet = []
      restrictionsSet = newValue
      restrictionsSet.sort {$0.0 < $1.0}
    }
    get {
      return restrictionsSet
    }
  }
  var numRestrictions: Int { return restrictionsSet.count }

  init() {
    profilePic = ""
    userName = ""
    emailAddress = ""
    minCalories = 0
    maxCalories = 0
    minTime = 0
    maxTime = 0
    unwantedFoods = []
    restrictionsSet = []
  }

  func restrictionName(at pos: Int) -> String {
    return restrictions[pos].0
  }

  func restrictionIsSelected(at pos: Int) -> Bool {
    return restrictions[pos].1
  }

  func selectRestriction(at pos: Int) {
    restrictions[pos].1 = true
  }

  func deselectRestriction(at pos: Int) {
    restrictions[pos].1 = false
  }
}
