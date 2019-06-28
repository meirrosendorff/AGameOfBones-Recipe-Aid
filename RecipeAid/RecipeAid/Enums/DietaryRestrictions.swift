//
//  DietaryRestrictions.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/06/28.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import Foundation

enum DietaryRestrictions: CaseIterable {

  case alcoholFree
  case highProtein
  case lowCarb
  case lowFat
  case lowSuger
  case nutFree
  case vegan
  case vegetarian

  func description() -> String {
    switch self {
    case .alcoholFree:
      return "Alcohol Free"
    case .highProtein:
      return "High Protein"
    case .lowCarb:
      return "Low Carbs"
    case .lowFat:
      return "Low Fat"
    case .lowSuger:
      return "Low Suger"
    case .nutFree:
      return "Nut Free"
    case .vegan:
      return "Vegan"
    case .vegetarian:
      return "Vegetarian"
    }
  }

  func webKey() -> String {
    switch self {
    case .alcoholFree:
      return "health=alcohol-free"
    case .highProtein:
      return "diet=high-protein"
    case .lowCarb:
      return "diet=low-carb"
    case .lowFat:
      return "diet=low-fat"
    case .lowSuger:
      return "health=low-sugar"
    case .nutFree:
      return "health=tree-nut-free"
    case .vegan:
      return "health=vegan"
    case .vegetarian:
      return "health=vegetarian"
    }
  }

  static func getDietryRestriction(fromKey key: String) -> DietaryRestrictions? {
    for restriction in allCases where restriction.webKey() == key {
      return restriction
    }
    return nil
  }

  static func getDietryRestriction(fromDescription description: String) -> DietaryRestrictions? {
    for restriction in allCases where restriction.description() == description {
      return restriction
    }
    return nil
  }
}
