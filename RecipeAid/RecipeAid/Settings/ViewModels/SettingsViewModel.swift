//
//  SettingsViewModel.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/06/21.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import Foundation

class SettingsViewModel: SettingsViewModelProtocol {

  var model: SettingsModel
  var repo: SettingsRepoProtocol
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
    repo = SettingsRepo()
    model = SettingsModel()
    setProfileData()
    updateSettings()
  }

  private func setProfileData() {
    //not sure where this data will be fetched from yet
    model.profilePic = "background"
    model.userName = "User Name"
    model.emailAddress = "user.name@emailadress.com"
  }

  private func fetchRestrictions() {

    let restrictions = repo.getRestrictions()

    model.restrictions = restrictions
  }

  private func fetchCalories() {

    let range = repo.getCaloriesRange()
    model.minCalories = range.0
    model.maxCalories = range.1
  }

  private func fetchTimes() {

    let range = repo.getTimesRange()
    model.minTime = range.0
    model.maxTime = range.1
  }

  private func fetchUnwantedFoods() {

    let foodArray = repo.getUnwantedFoods()

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

    repo.setRestrictions(restrictions: model.restrictions)
    repo.setCaloriesRange(calories: (model.minCalories, model.maxCalories))
    repo.setTimesRange(times: (model.minTime, model.maxTime))

    let excludedFoods = unwantedFoods.split(separator: ",").map {
      $0.trimmingCharacters(in: .whitespaces)
    }
    repo.setUnwatedFoods(foods: excludedFoods)
    updateSettings()
  }

  func updateSettings() {

    fetchRestrictions()
    fetchCalories()
    fetchTimes()
    fetchUnwantedFoods()
  }
}
