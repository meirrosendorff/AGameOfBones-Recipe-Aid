//
//  UserDefaultsKeys.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/06/25.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import Foundation

enum UserDefaultsKeys: String {

  case alreadySetUp = "DefaultsAlreadySetUp"
  case minCalories = "minCalories"
  case maxCalories = "maxCalories"
  case minTime = "minTime"
  case maxTime = "maxTime"
  case dietryRestrictionsDict = "dietryRestrictionsDict"
  case unwantedFoodsArray = "unwantedFoodsArray"
  case userToken = "userLoginToken"
  case isLoggedIn = "isLoggedIn"
  case userID = "userid"
  case userEmail = "userEmail"
  case username = "username"
  case isAdmin = "userIsAdmin"
}
