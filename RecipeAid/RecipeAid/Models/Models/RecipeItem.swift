//
//  RecipeItem.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/06/04.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//
import Foundation

struct Recipe {
  let uri: String
  let label: String
  let image: String
  let source: String
  let url: String
  let yield: Double
  let ingredientLines: [String]
  let calories: Double
}
