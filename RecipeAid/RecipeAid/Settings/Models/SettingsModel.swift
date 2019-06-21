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
  var restrictions: [(String, Bool)]
  var numRestrictions: Int { return restrictions.count }

  init() {
    profilePic = ""
    userName = ""
    emailAddress = ""
    minCalories = 0
    maxCalories = 0
    minTime = 0
    maxTime = 0
    unwantedFoods = []
    restrictions = []
  }

  func setRestrictions(restrictions: [(String, Bool)]) {
    self.restrictions = []
    self.restrictions = restrictions
    self.restrictions.sort {$0.0 > $1.0}
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
