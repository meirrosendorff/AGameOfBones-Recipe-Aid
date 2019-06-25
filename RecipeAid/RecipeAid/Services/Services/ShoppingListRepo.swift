//let gregorian = Calendar(identifier: .gregorian)
//  ShoppingListRepo.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/06/25.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import Foundation

class ShoppingListRepo: ShoppingListRepoProtocol {

  func getShoppingList(from: Date, forDays: Int, onComplete: @escaping ([ShoppingItem]) -> Void) {

    let gregorian = Calendar(identifier: .gregorian)
    let startDate = gregorian.date(bySettingHour: 0, minute: 0, second: 0, of: from) ?? from
    let fakeItemList = [
      ShoppingItem(mealID: 1, itemName: "Item", isBought: false),
      ShoppingItem(mealID: 1, itemName: "Item", isBought: false),
      ShoppingItem(mealID: 1, itemName: "Item", isBought: true),
      ShoppingItem(mealID: 1, itemName: "Item", isBought: true),
      ShoppingItem(mealID: 1, itemName: "Item", isBought: false),
      ShoppingItem(mealID: 1, itemName: "Item", isBought: true),
      ShoppingItem(mealID: 1, itemName: "Item", isBought: false),
      ShoppingItem(mealID: 1, itemName: "Item", isBought: false)
    ]

    if Int(startDate.timeIntervalSinceNow)/1000 % 2 == 0 {
      onComplete([])
      return
    }
    onComplete(fakeItemList)
  }

  func saveItem(item: ShoppingItem) {
  }
}
