//let gregorian = Calendar(identifier: .gregorian)
//  ShoppingListRepo.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/06/25.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import Foundation

class ShoppingListRepo: ShoppingListRepoProtocol {

  var repo: PersistantStorageRepoProtocol

  init() {
    repo = CoreDataStorageRepo()
  }

  func getShoppingList(from: Date, forDays: Int, onComplete: @escaping ([ShoppingItem]) -> Void) {

    if CommandLine.arguments.contains("-testing") {
      if CommandLine.arguments.contains("-forceEmptyReturns") {
        onComplete([])
        return
      } else {
        let fakeItemList = [ShoppingItem(itemID: "", itemName: "Item Bought", isBought: false),
                            ShoppingItem(itemID: "", itemName: "Item NotBought", isBought: true)]
        onComplete(fakeItemList)
        return
      }
    }

    repo.getShoppingItems(forDate: from, forDays: forDays, onComplete: { shoppingList in
      onComplete(shoppingList)
    })
  }

  func saveItem(item: ShoppingItem) {
    if CommandLine.arguments.contains("-testing") { return }

    repo.updateShoppingItem(item)
  }
}
