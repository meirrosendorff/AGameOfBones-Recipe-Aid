//
//  ShoppingListRepoProtocol.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/06/25.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import Foundation

protocol ShoppingListRepoProtocol {

  func getShoppingList(from: Date, forDays: Int, onComplete: @escaping ([ShoppingItem]) -> Void)
  func saveItem(item: ShoppingItem)
}
