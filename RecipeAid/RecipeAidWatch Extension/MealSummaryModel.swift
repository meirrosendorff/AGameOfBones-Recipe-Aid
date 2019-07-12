//
//  MealSummaryModel.swift
//  RecipeAidWatch Extension
//
//  Created by Meir Rosendorff on 2019/07/11.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import Foundation

struct MealSummaryModel: Codable {

  let mealPic: Data
  let foodName: String
  let mealType: String
}
