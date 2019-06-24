//
//  SettingsViewModelProtocol.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/06/21.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import Foundation

protocol SettingsViewModelProtocol {

  var numRestrictions: Int { get }
  var profilePic: String { get }
  var userName: String { get }
  var emailAddress: String { get }
  var minCalories: String { get }
  var maxCalories: String { get }
  var minTime: String { get }
  var maxTime: String { get }
  var unwantedFoods: String { get}
  func restrictionName(at pos: Int) -> String
  func restrictionIsSelected(at pos: Int) -> Bool
  func selectRestriction(at pos: Int)
  func deselectRestriction(at pos: Int)
  func setCalories(min: String, max: String) throws
  func setTimes(min: String, max: String) throws
  func setUnwatedFoods(foods: String)
  func save()
  func updateSettings()
}
