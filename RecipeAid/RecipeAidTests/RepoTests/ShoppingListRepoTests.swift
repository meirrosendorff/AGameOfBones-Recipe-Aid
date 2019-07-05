//
//  ShoppingListRepoTests.swift
//  RecipeAidTests
//
//  Created by Meir Rosendorff on 2019/07/05.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import XCTest
import Cuckoo
@testable import RecipeAid

class ShoppingListRepoTests: XCTestCase {

  var sut: ShoppingListRepo!
  var repo: MockCoreDataStorageRepo!

  override func setUp() {

    sut = ShoppingListRepo()
    repo = MockCoreDataStorageRepo()
    sut.repo = repo
    super.setUp()
  }

  override func tearDown() {
    sut = nil
    repo = nil
    super.tearDown()
  }

  func testGetShoppingListCallsCoreDataStorageRepoGetShoppingList() {
    let today = Date()
    let days = 42
    let items = [ShoppingItem(itemID: "42", itemName: "item", isBought: true)]

    stub(repo) { stub in
      when(stub.getShoppingItems(forDate: equal(to: today), forDays: days, onComplete: anyClosure()))
        .then({_, _, onComplete in
        onComplete(items)
      })
    }

    sut.getShoppingList(from: today, forDays: days, onComplete: { itemsReturned in

      XCTAssertEqual(itemsReturned.count, 1)
      XCTAssertEqual(itemsReturned[0].itemID, items[0].itemID)
      XCTAssertEqual(itemsReturned[0].itemName, items[0].itemName)
      XCTAssertEqual(itemsReturned[0].isBought, items[0].isBought)
    })

    verify(repo, times(1)).getShoppingItems(forDate: equal(to: today), forDays: days, onComplete: anyClosure())
  }

  func testSaveItemUpdatesItemToCoreDataStorageRepo() {

    let item = ShoppingItem(itemID: "42", itemName: "item", isBought: true)

    stub(repo) { stub in
      when(stub.updateShoppingItem(equal(to: item))).thenDoNothing()
    }

    sut.saveItem(item: item)

    verify(repo, times(1)).updateShoppingItem(equal( to: item))
  }
}
