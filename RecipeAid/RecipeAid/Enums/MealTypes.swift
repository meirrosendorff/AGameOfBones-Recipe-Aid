//
//  MealTypes.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/06/26.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import Foundation

enum MealTypes: CaseIterable {

  case breakfast
  case lunch
  case dinner

  func description() -> String {
    switch self {
    case .breakfast:
      return "Breakfast"
    case .lunch:
      return "Lunch"
    case .dinner:
      return "Dinner"
    }
  }

  func storageKey() -> String {
    switch self {
    case .breakfast:
      return "breakfast"
    case .lunch:
      return "lunch"
    case .dinner:
      return "dinner"
    }
  }

  static func getMealForDescription(description: String) -> MealTypes? {

    for meal in self.allCases where meal.description() == description {
      return meal
    }
    return nil
  }
}
