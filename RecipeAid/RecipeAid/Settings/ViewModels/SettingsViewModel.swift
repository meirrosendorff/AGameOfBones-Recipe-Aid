//
//  SettingsViewModel.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/06/21.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import Foundation

class SettingsViewModel: SettingsViewModelProtocol {

  private let model: SettingsModel
  var profilePic: String { return model.profilePic }
  var userName: String { return model.userName }
  var emailAddress: String { return model.emailAddress }
  var minCalories: String { return model.minCalories > 0 ? String(model.minCalories) : "" }
  var maxCalories: String { return model.maxCalories > 0 ? String(model.maxCalories) : ""  }
  var minTime: String { return model.minTime > 0 ? String(model.minTime) : "" }
  var maxTime: String { return model.maxTime > 0 ? String(model.maxTime) : "" }
  var unwantedFoods: String { return model.unwantedFoods.joined(separator: ", ") }

  var numRestrictions: Int { return model.numRestrictions }

  init() {
    model = SettingsModel()
    setProfileData()
    updateSettingsFromUserDefaults()
  }

  private func setProfileData() {
    //not sure where this data will be fetched from yet
    model.profilePic = "background"
    model.userName = "User Name"
    model.emailAddress = "user.name@emailadress.com"
  }

  private func getRestrictionsFromUserDefaults() {

    let dict =
      UserDefaults.standard.object(forKey: "restrictionOptionsArray") as? [String: Bool] ?? [String: Bool]()

    var restrictions: [(String, Bool)] = []
    for (name, isSelected) in dict {
      restrictions.append((name, isSelected))
    }

    model.setRestrictions(restrictions: restrictions)
  }

  private func getCaloriesFromUserDefaults() {

    model.minCalories = UserDefaults.standard.integer(forKey: "minCalories")
    model.maxCalories = UserDefaults.standard.integer(forKey: "maxCalories")
  }

  private func getTimesFromUserDefaults() {

    model.minTime = UserDefaults.standard.integer(forKey: "minTime")
    model.maxTime = UserDefaults.standard.integer(forKey: "maxTime")
  }

  private func getUnwantedFoodsFromUserDefaults() {

    let foodArray = UserDefaults.standard.object(forKey: "excludedFoodsArray") as? [String] ?? []

    model.unwantedFoods = foodArray
  }

  func restrictionName(at pos: Int) -> String {
    return model.restrictionName(at: pos)
  }

  func restrictionIsSelected(at pos: Int) -> Bool {
    return model.restrictionIsSelected(at: pos)
  }

  func selectRestriction(at pos: Int) {
    model.selectRestriction(at: pos)
  }

  func deselectRestriction(at pos: Int) {
    model.deselectRestriction(at: pos)
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

    model.minCalories = values.0
    model.maxCalories = values.1
  }

  func setTimes(min: String, max: String) throws {

    let values = try getValidNumbers(min: min, max: max)

    model.minTime = values.0
    model.maxTime = values.1
  }

  func setUnwatedFoods(foods: String) {
    model.unwantedFoods = foods.split(separator: ",").map {
      $0.trimmingCharacters(in: .whitespaces)
    }
  }

  func save() {

    let restrictionsToSave = model.restrictions.reduce(into: [:]) { $0[$1.0] = $1.1 }
    UserDefaults.standard.set(restrictionsToSave, forKey: "restrictionOptionsArray")

    UserDefaults.standard.set(model.minCalories, forKey: "minCalories")
    UserDefaults.standard.set(model.maxCalories, forKey: "maxCalories")
    UserDefaults.standard.set(model.minTime, forKey: "minTime")
    UserDefaults.standard.set(model.maxTime, forKey: "maxTime")

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
