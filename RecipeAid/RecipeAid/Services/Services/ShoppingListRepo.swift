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

    if CommandLine.arguments.contains("-testing") {
      if CommandLine.arguments.contains("-forceEmptyReturns") {
        onComplete([])
        return
      } else {
        let fakeItemList = [ShoppingItem(mealID: 1, itemName: "Item Bought", isBought: false),
                            ShoppingItem(mealID: 1, itemName: "Item NotBought", isBought: true)]
        onComplete(fakeItemList)
        return
      }
    }
  }

  func saveItem(item: ShoppingItem) {
    if CommandLine.arguments.contains("-testing") { return }
  }
}
