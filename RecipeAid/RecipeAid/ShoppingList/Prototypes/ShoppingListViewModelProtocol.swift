//
//  ShoppingListViewModelProtocol.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/06/25.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import Foundation

protocol ShoppingListViewModelProtocol {

  var dateRangeText: String { get }
  var hasShopping: Bool { get }
  var shoppingListSize: Int { get }

  func updateShopping(onComplete: @escaping (ShoppingListViewModelProtocol) -> Void)
  func updateShoppingForNextWeek(onComplete: @escaping (ShoppingListViewModelProtocol) -> Void)
  func updateShoppingForLastWeek(onComplete: @escaping (ShoppingListViewModelProtocol) -> Void)
  func itemIsBaught(at pos: Int) -> Bool
  func getItemName(at pos: Int) -> String
  func selectItem(at pos: Int)
}
