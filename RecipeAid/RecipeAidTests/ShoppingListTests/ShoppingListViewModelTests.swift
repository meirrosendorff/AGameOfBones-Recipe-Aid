//
//  ShoppingListViewModelTests.swift
//  RecipeAidTests
//
//  Created by Meir Rosendorff on 2019/06/26.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import XCTest
import Cuckoo
@testable import RecipeAid

class ShoppingListViewModelTests: XCTestCase {

  var viewModel: ShoppingListViewModel!
  var repo: MockShoppingListRepo!
  var baseDate: Date!
  var argumentCaptor: ArgumentCaptor<AnyObject>!
  let thisWeek = "28/04/2019"
  let nextWeek = "05/05/2019"
  let lastWeek = "21/04/2019"
  var thisWeekList: [ShoppingItem]!
  var lastWeekList: [ShoppingItem]!
  var nextWeekList: [ShoppingItem]!
  var formatter = DateFormatter()

  override func setUp() {
    super.setUp()

    formatter.dateFormat = "dd/MM/yyyy"
    repo = MockShoppingListRepo()
    argumentCaptor = ArgumentCaptor<AnyObject>()
    baseDate = formatter.date(from: "04/05/2019")
    viewModel = ShoppingListViewModel()
    viewModel.baseDate = baseDate
    viewModel.repo = repo
    thisWeekList = [ShoppingItem(itemID: "", itemName: self.thisWeek, isBought: true),
                    ShoppingItem(itemID: "", itemName: "Second Item", isBought: false)]
    nextWeekList = [ShoppingItem(itemID: "", itemName: self.nextWeek, isBought: true)]
    lastWeekList = [ShoppingItem(itemID: "", itemName: self.lastWeek, isBought: true)]
    stubSaveItem()
    stubGetShoppingList()
  }

  override func tearDown() {
    viewModel = nil
    repo = nil
    baseDate = nil
    super.tearDown()
  }

  func stubGetShoppingList() {

    stub(repo) { stub in

      let thisWeekDate = formatter.date(from: thisWeek) ?? Date()
      when(stub.getShoppingList(
        from: equal(to: thisWeekDate), forDays: 7, onComplete: anyClosure())).then({ _, _, closure in

          closure(self.thisWeekList)
        })

      let nextWeekDate = formatter.date(from: nextWeek) ?? Date()
      when(stub.getShoppingList(
        from: equal(to: nextWeekDate), forDays: 7, onComplete: anyClosure())).then({ _, _, closure in

          closure(self.nextWeekList)
        })

      let lastWeekDate = formatter.date(from: lastWeek) ?? Date()
      when(stub.getShoppingList(
        from: equal(to: lastWeekDate), forDays: 7, onComplete: anyClosure())).then({ _, _, closure in

          closure(self.lastWeekList)
        })
    }
  }

  func stubSaveItem() {

    stub(repo) { stub in

      when(stub.saveItem(
        item: equal(to: self.thisWeekList[0]))).thenDoNothing()

      when(stub.saveItem(
        item: equal(to: self.thisWeekList[1]))).thenDoNothing()

      when(stub.saveItem(
        item: equal(to: self.lastWeekList[0]))).thenDoNothing()

      when(stub.saveItem(
        item: equal(to: self.nextWeekList[0]))).thenDoNothing()
    }
  }

  func testDateRangeTextReturnedCorrectlyForCurrentDate() {

    viewModel.updateShopping(onComplete: { viewModel in
      XCTAssertEqual(viewModel.dateRangeText, "Sun 28 Apr 2019 - Sat 04 May 2019")
    })
  }

  func testDateRangeTextReturnedCorrectlyForNextWeek() {

    viewModel.updateShoppingForNextWeek(onComplete: { viewModel in
      XCTAssertEqual(viewModel.dateRangeText, "Sun 05 May 2019 - Sat 11 May 2019")
    })
  }

  func testDateRangeTextReturnedCorrectlyForLastWeek() {

    viewModel.updateShoppingForLastWeek(onComplete: { viewModel in
      XCTAssertEqual(viewModel.dateRangeText, "Sun 21 Apr 2019 - Sat 27 Apr 2019")
    })
  }

  func testUpdateShoppingForThisWeekCallsRepoWithCorrectDate() {

    viewModel.updateShopping(onComplete: {_ in})

    let thisWeekDate = formatter.date(from: thisWeek) ?? Date()

    verify(repo, times(1)).getShoppingList(from: equal(to: thisWeekDate), forDays: 7, onComplete: anyClosure())
  }

  func testUpdateShoppingForNextWeekCallsRepoWithCorrectDate() {

    viewModel.updateShopping(onComplete: {_ in})

    let nextWeekDate = formatter.date(from: thisWeek) ?? Date()

    verify(repo, times(1)).getShoppingList(from: equal(to: nextWeekDate), forDays: 7, onComplete: anyClosure())
  }

  func testUpdateShoppingForLastWeekCallsRepoWithCorrectDate() {

    viewModel.updateShopping(onComplete: {_ in})

    let lastWeekDate = formatter.date(from: thisWeek) ?? Date()

    verify(repo, times(1)).getShoppingList(from: equal(to: lastWeekDate), forDays: 7, onComplete: anyClosure())
  }

  func testHasShoppingReturnsTrueWhenThereAreItemsAndFalseOtherwise() {

    XCTAssertFalse(viewModel.hasShopping)

    viewModel.updateShoppingForNextWeek(onComplete: { viewModel in
      XCTAssertTrue(viewModel.hasShopping)
    })
  }

  func testShoppingListSizeReturnsListSize() {

    XCTAssertEqual(viewModel.shoppingListSize, 0)

    viewModel.updateShopping(onComplete: { viewModel in
      XCTAssertEqual(viewModel.shoppingListSize, 2)
    })
  }

  func testGetItemNameReturnsCorrectName() {

    viewModel.updateShopping(onComplete: { viewModel in
      XCTAssertEqual(viewModel.getItemName(at: 0), self.thisWeek)
      XCTAssertEqual(viewModel.getItemName(at: 1), "Second Item")
    })
  }

  func testShoppingListUpdatesAfterNextWeekUpdate() {

    viewModel.updateShopping(onComplete: {_ in})
    viewModel.updateShoppingForNextWeek(onComplete: { viewModel in
      XCTAssertEqual(viewModel.shoppingListSize, 1)
      XCTAssertEqual(viewModel.getItemName(at: 0), self.nextWeek)
    })
  }

  func testShoppingListUpdatesAfterNextLastpdate() {

    viewModel.updateShopping(onComplete: {_ in})
    viewModel.updateShoppingForLastWeek(onComplete: { viewModel in
      XCTAssertEqual(viewModel.shoppingListSize, 1)
      XCTAssertEqual(viewModel.getItemName(at: 0), self.lastWeek)
    })
  }

  func testItemIsBaughtReturnsCorrectly() {

    viewModel.updateShopping(onComplete: { viewModel in

      XCTAssertTrue(viewModel.itemIsBaught(at: 0))
      XCTAssertFalse(viewModel.itemIsBaught(at: 1))
    })
  }

  func testSelectItemChangesItemsItemIsBoughtValue() {

    viewModel.updateShopping(onComplete: { _ in })
    viewModel.selectItem(at: 0)
    viewModel.selectItem(at: 1)

    XCTAssertFalse(viewModel.itemIsBaught(at: 0))
    XCTAssertTrue(viewModel.itemIsBaught(at: 1))
  }

  func testItemIsBoughtCallsRepoWithCorrectItem () {

    viewModel.updateShopping(onComplete: { _ in })
    viewModel.selectItem(at: 0)
    viewModel.selectItem(at: 1)

    verify(repo, times(1)).saveItem(item: equal(to: thisWeekList[0]))
    verify(repo, times(1)).saveItem(item: equal(to: thisWeekList[1]))
  }
}
