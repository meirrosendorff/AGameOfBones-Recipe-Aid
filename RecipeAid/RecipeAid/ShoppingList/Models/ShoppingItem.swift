//
//  ShoppingItem.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/06/25.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import Foundation

class ShoppingItem {

  var mealID: Int
  var itemName: String
  var isBought: Bool

  init(mealID: Int, itemName: String, isBought: Bool) {

    self.mealID = mealID
    self.itemName = itemName
    self.isBought = isBought
  }

  func changeStatus() {
    isBought = !isBought
  }
}
