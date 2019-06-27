//
//  ShoppingListViewModel.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/06/25.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import Foundation

class ShoppingListViewModel: ShoppingListViewModelProtocol {

  var dateRangeText: String
  var hasShopping: Bool { return shoppingItems.count > 0 }
  var shoppingListSize: Int { return shoppingItems.count }
  var baseDate: Date
  private var weekOffset: Int
  private var weekSize: Int
  private var currentWeek: Date
  private var shoppingItems: [ShoppingItem]
  var repo: ShoppingListRepoProtocol

  init() {
    baseDate = Date()
    dateRangeText = ""
    weekOffset = 0
    weekSize = 7
    shoppingItems = []
    repo = ShoppingListRepo()
    currentWeek = Date()
  }

  private func updateWeek(offSet: Int) {

    let gregorian = Calendar(identifier: .gregorian)
    guard let currSunday =
      gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: baseDate)) else { return }
    guard let sunday = gregorian.date(byAdding: .day, value: weekSize * offSet, to: currSunday) else { return }
    guard let saterday = gregorian.date(byAdding: .day, value: weekSize - 1, to: sunday) else { return }

    self.currentWeek = sunday

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEE dd MMM yyyy"

    let weekStart = dateFormatter.string(from: sunday)
    let weekEnd = dateFormatter.string(from: saterday)

    dateRangeText = "\(weekStart) - \(weekEnd)"
  }

  func updateShopping(onComplete: @escaping (ShoppingListViewModelProtocol) -> Void) {

    updateWeek(offSet: weekOffset)
    fetchShopping(onComplete: onComplete)
  }

  func updateShoppingForNextWeek(onComplete: @escaping (ShoppingListViewModelProtocol) -> Void) {

    weekOffset += 1
    updateWeek(offSet: weekOffset)
    fetchShopping(onComplete: onComplete)
  }

  func updateShoppingForLastWeek(onComplete: @escaping (ShoppingListViewModelProtocol) -> Void) {

    weekOffset -= 1
    updateWeek(offSet: weekOffset)
    fetchShopping(onComplete: onComplete)
  }

  private func fetchShopping(onComplete: @escaping (ShoppingListViewModelProtocol) -> Void) {

    repo.getShoppingList(from: currentWeek, forDays: weekSize, onComplete: { list in
      self.shoppingItems = list.sorted(by: { $0.itemName < $1.itemName })
      onComplete(self)
    })
  }

  func itemIsBaught(at pos: Int) -> Bool {

    return shoppingItems[pos].isBought
  }

  func getItemName(at pos: Int) -> String {

    return shoppingItems[pos].itemName
  }

  func selectItem(at pos: Int) {

    shoppingItems[pos].changeStatus()
    repo.saveItem(item: shoppingItems[pos])
  }
}
