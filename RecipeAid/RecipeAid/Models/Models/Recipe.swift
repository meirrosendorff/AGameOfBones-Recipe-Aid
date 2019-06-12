//
//  RecipeItem.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/06/04.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//
import Foundation

struct Recipe: Equatable {
  let uri: String
  let label: String
  let image: String
  let source: String
  let url: String
  let yield: Double
  let ingredientLines: [String]
  let calories: Double

  static func == (lhs: Recipe, rhs: Recipe) -> Bool {
    let uriEqual = lhs.uri == rhs.uri
    let labelEqual = lhs.label == rhs.label
    let imageEqual = lhs.image == rhs.image
    let urlEqual = lhs.url == rhs.url
    let yieldEqual = lhs.yield == rhs.yield
    let caloriesEqual = lhs.calories == rhs.calories
    let sourceEqual = lhs.source == rhs.source
    let ingredientsEqual = lhs.ingredientLines == rhs.ingredientLines

    let result = uriEqual && labelEqual && imageEqual && urlEqual &&
      yieldEqual && caloriesEqual && sourceEqual && ingredientsEqual

    return result
  }
}
