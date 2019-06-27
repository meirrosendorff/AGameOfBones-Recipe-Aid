//
//  ShoppingItem.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/06/25.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import Foundation

class ShoppingItem {

  let itemID: String
  let itemName: String
  var isBought: Bool

  init(itemID: String, itemName: String, isBought: Bool) {

    self.itemID = itemID
    self.itemName = itemName
    self.isBought = isBought
  }

  func changeStatus() {
    isBought = !isBought
  }
}
