//
//  SettingsViewModel.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/06/21.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import Foundation

class SettingsViewModel: SettingsViewModelProtocol {

  var profilePic: String
  var userName: String
  var emailAddress: String
  var minCalories: String { return minCaloriesInt > 0 ? String(minCaloriesInt) : "" }
  var maxCalories: String { return maxCaloriesInt > 0 ? String(maxCaloriesInt) : ""  }
  var minTime: String { return minTimeInt > 0 ? String(minTimeInt) : "" }
  var maxTime: String { return maxTimeInt > 0 ? String(maxTimeInt) : "" }
  var unwantedFoods: String
  var restrictions: [(String, Bool)]
  private var minCaloriesInt: Int
  private var maxCaloriesInt: Int
  private var minTimeInt: Int
  private var maxTimeInt: Int

  var numRestrictions: Int { return restrictions.count }

  init() {

    profilePic = ""
    userName = ""
    emailAddress = ""
    minCaloriesInt = 0
    maxCaloriesInt = 0
    minTimeInt = 0
    maxTimeInt = 0
    unwantedFoods = ""
    restrictions = []

    setProfileData()
    updateSettingsFromUserDefaults()
  }

  private func setProfileData() {
    //not sure where this data will be fetched from yet
    profilePic = "background"
    userName = "User Name"
    emailAddress = "user.name@emailadress.com"
  }

  private func getRestrictionsFromUserDefaults() {

    let dict =
      UserDefaults.standard.object(forKey: "restrictionOptionsArray") as? [String: Bool] ?? [String: Bool]()

    restrictions = []
    for (name, isSelected) in dict {
      restrictions.append((name, isSelected))
    }
    restrictions.sort {$0.0 > $1.0}
  }

  private func getCaloriesFromUserDefaults() {

    minCaloriesInt = UserDefaults.standard.integer(forKey: "minCalories")
    maxCaloriesInt = UserDefaults.standard.integer(forKey: "maxCalories")
  }

  private func getTimesFromUserDefaults() {

    minTimeInt = UserDefaults.standard.integer(forKey: "minTime")
    maxTimeInt = UserDefaults.standard.integer(forKey: "maxTime")
  }

  private func getUnwantedFoodsFromUserDefaults() {

    let foodArray = UserDefaults.standard.object(forKey: "excludedFoodsArray") as? [String] ?? []

    unwantedFoods = foodArray.joined(separator: ", ")
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

  private func getValidNumbers(min: String, max: String) throws -> (Int, Int) {

    guard let minAttempt = Double(min != "" ? min : "0") else {
      throw RecipeError.invalidNumberString("min Calories not a number")
    }

    guard let maxAttempt = Double(max != "" ? max : "0") else {
      throw RecipeError.invalidNumberString("max Calories not a number")
    }

    if minAttempt > maxAttempt {
      throw RecipeError.minMaxError("min calories greater than max calories")
    }

    return (Int(minAttempt), Int(maxAttempt))
  }

  func setCalories(min: String, max: String) throws {

    let values = try getValidNumbers(min: min, max: max)

    minCaloriesInt = values.0
    maxCaloriesInt = values.1
  }

  func setTimes(min: String, max: String) throws {

    let values = try getValidNumbers(min: min, max: max)

    minTimeInt = values.0
    maxTimeInt = values.1
  }

  func setUnwatedFoods(foods: String) {
    unwantedFoods = foods
  }

  func save() {

    let restrictionsToSave = restrictions.reduce(into: [:]) { $0[$1.0] = $1.1 }
    UserDefaults.standard.set(restrictionsToSave, forKey: "restrictionOptionsArray")

    UserDefaults.standard.set(minCaloriesInt, forKey: "minCalories")
    UserDefaults.standard.set(maxCaloriesInt, forKey: "maxCalories")
    UserDefaults.standard.set(minTimeInt, forKey: "minTime")
    UserDefaults.standard.set(maxTimeInt, forKey: "maxTime")

    let excludedFoodsArray = unwantedFoods.split(separator: ",").map {
      $0.trimmingCharacters(in: .whitespaces)
    }
    UserDefaults.standard.set(excludedFoodsArray, forKey: "excludedFoodsArray")

    updateSettingsFromUserDefaults()
  }

  private func updateSettingsFromUserDefaults() {

    getRestrictionsFromUserDefaults()
    getCaloriesFromUserDefaults()
    getTimesFromUserDefaults()
    getUnwantedFoodsFromUserDefaults()
  }
}
