//
//  coreDataStorageRepoTests.swift
//  RecipeAidTests
//
//  Created by Meir Rosendorff on 2019/06/27.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import Foundation
import XCTest
import CoreData

@testable import RecipeAid

class CoreDataStorageRepoTests: XCTestCase {

  var repo: CoreDataStorageRepo!
  var mockDate: Date!
  var coreDataMock: CoreDataMock!

  override func setUp() {
    super.setUp()

    coreDataMock = CoreDataMock()
    repo = CoreDataStorageRepo()
    repo.managedContextSet = true
    repo.persistentContainer = coreDataMock.mockPersistantContainer

    let cal: Calendar = Calendar(identifier: .gregorian)
    var components = DateComponents()
    components.year = 2019
    components.month = 6
    components.day = 15
    components.calendar = cal
    components.hour = 0
    components.minute = 0
    components.second = 0
    mockDate = cal.date(from: components)
  }

  override func tearDown() {
    repo = nil
    coreDataMock = nil
    super.tearDown()
  }

  func testSaveMealSavesAMeal() {

    let recipeToSave = dummyRecipe
    let dateToSave = Date()
    let mealTypeToSave = MealTypes.breakfast

    let shouldBeEmptyMealSet = coreDataMock.fetchRecordsForEntity(Entities.menuEntity.rawValue)
    XCTAssertEqual(shouldBeEmptyMealSet.count, 0)

    repo.saveMeal(withRecipe: recipeToSave, forDate: dateToSave, forMeal: mealTypeToSave)
    let mealSet = coreDataMock.fetchRecordsForEntity(Entities.menuEntity.rawValue)

    XCTAssertEqual(mealSet.count, 1)

    let recipe = coreDataMock.getRecipeSetFromMenu(menuObj: mealSet[0])
    XCTAssertEqual(recipe[0].recipeType, mealTypeToSave.storageKey())
    XCTAssertTrue(coreDataMock.checkRecipesEqual(recipe[0], recipeToSave))
  }

  func testSaveMealOverwritesOldMealWhenNewRecipeSavedForSameRecipe() {

    let firstRecipeToSave = dummyRecipe
    let secondRecipeToSave = iceCreamRecipe
    let dateToSave = Date()
    let mealTypeToSave = MealTypes.breakfast

    repo.saveMeal(withRecipe: firstRecipeToSave, forDate: dateToSave, forMeal: mealTypeToSave)
    repo.saveMeal(withRecipe: secondRecipeToSave, forDate: dateToSave, forMeal: mealTypeToSave)
    let mealSet = coreDataMock.fetchRecordsForEntity(Entities.menuEntity.rawValue)

    XCTAssertEqual(mealSet.count, 1)
    let recipe = coreDataMock.getRecipeSetFromMenu(menuObj: mealSet[0])
    XCTAssertTrue(coreDataMock.checkRecipesEqual(recipe[0], secondRecipeToSave))
  }

  func testSaveMealAddNewMealOnSameDateButDifferentMealType() {

    let firstRecipeToSave = dummyRecipe
    let secondRecipeToSave = iceCreamRecipe
    let dateToSave = Date()
    let firstMealTypeToSave = MealTypes.breakfast
    let secondMealTypeToSave = MealTypes.lunch

    repo.saveMeal(withRecipe: firstRecipeToSave, forDate: dateToSave, forMeal: firstMealTypeToSave)
    repo.saveMeal(withRecipe: secondRecipeToSave, forDate: dateToSave, forMeal: secondMealTypeToSave)
    let mealSet = coreDataMock.fetchRecordsForEntity(Entities.menuEntity.rawValue)

    XCTAssertEqual(mealSet.count, 1)

    let recipes = coreDataMock.getRecipeSetFromMenu(menuObj: mealSet[0])

    for recipe in recipes where recipe.recipeType == firstMealTypeToSave.storageKey() {
      XCTAssertTrue(coreDataMock.checkRecipesEqual(recipe, firstRecipeToSave))
    }

    for recipe in recipes where recipe.recipeType == secondMealTypeToSave.storageKey() {
      XCTAssertTrue(coreDataMock.checkRecipesEqual(recipe, secondRecipeToSave))
    }
  }

  func testSaveMealForTwoDifferentDatesWillCreateTwoMenuObjects() {

    let firstRecipeToSave = dummyRecipe
    let secondRecipeToSave = iceCreamRecipe
    let firstDateToSave = Date()
    let cal = Calendar(identifier: .gregorian)
    let secondDateToSave = cal.date(byAdding: .day, value: 1, to: firstDateToSave)!
    let mealTypeToSave = MealTypes.breakfast

    repo.saveMeal(withRecipe: firstRecipeToSave, forDate: firstDateToSave, forMeal: mealTypeToSave)
    repo.saveMeal(withRecipe: secondRecipeToSave, forDate: secondDateToSave, forMeal: mealTypeToSave)
    let mealSet = coreDataMock.fetchRecordsForEntity(Entities.menuEntity.rawValue)

    XCTAssertEqual(mealSet.count, 2)

    let firstRecipeReturned = coreDataMock.getRecipeSetFromMenu(menuObj: mealSet[0])
    let secondRecipeReturned = coreDataMock.getRecipeSetFromMenu(menuObj: mealSet[1])

    XCTAssertNotEqual(firstRecipeReturned[0].recipeId, secondRecipeReturned[0].recipeId)

    if firstRecipeReturned[0].recipeId == firstRecipeToSave.uri {
      XCTAssertTrue(coreDataMock.checkRecipesEqual(firstRecipeReturned[0], firstRecipeToSave))
      XCTAssertTrue(coreDataMock.checkRecipesEqual(secondRecipeReturned[0], secondRecipeToSave))
    } else {
      XCTAssertTrue(coreDataMock.checkRecipesEqual(firstRecipeReturned[0], secondRecipeToSave))
      XCTAssertTrue(coreDataMock.checkRecipesEqual(secondRecipeReturned[0], firstRecipeToSave))
    }
  }

  func testGetRecipeIDReturnsEmptyStringIfNoRecipe() {

    let expectation = self.expectation(description: "should fetch empty string")
    var result = "Should become empty"

    repo.getRecipeID(forDate: mockDate, forMeal: MealTypes.breakfast, onComplete: { recipeID in
      expectation.fulfill()

      result = recipeID
    })

    XCTAssertEqual(result, "")
    waitForExpectations(timeout: 1, handler: nil)
  }

  func testGetRecipeIDReturnsCorrectIDWhenGivenCorrectDateAndMeal() {

    coreDataMock.addMockData(mockDate: mockDate)

    let expectation = self.expectation(description: "Fething RecipeID")
    var result = ""

    repo.getRecipeID(forDate: mockDate, forMeal: MealTypes.breakfast, onComplete: { recipeID in
      expectation.fulfill()

      result = recipeID
    })

    XCTAssertEqual(result, "testID0")
    waitForExpectations(timeout: 1, handler: nil)
  }

  func testGetRecipeIDReturnsEmptyStringWhenRecipeExistsOnDateButNotForThatMeal() {

    coreDataMock.addMockData(mockDate: mockDate)

    let expectation = self.expectation(description: "Should fail to fetch recipeID")
    var result = "Should be empty"

    repo.getRecipeID(forDate: mockDate, forMeal: MealTypes.dinner, onComplete: { recipeID in
      expectation.fulfill()

      result = recipeID
    })

    XCTAssertEqual(result, "")
    waitForExpectations(timeout: 1, handler: nil)
  }

  func testGetShoppingItemsReturnsEmptyListWhenNoItems() {

    let expectation = self.expectation(description: "Should fetch no items")
    var result = [ShoppingItem]()

    repo.getShoppingItems(forDate: mockDate, forDays: 42, onComplete: { items in
      expectation.fulfill()

      result = items
    })

    XCTAssertTrue(result.isEmpty)
    waitForExpectations(timeout: 1, handler: nil)
  }

  func testGetShoppingItemsReturnsCorrectItems() {

    coreDataMock.addMockData(mockDate: mockDate)

    let daysAhead = 4

    let expectation = self.expectation(description: "Should fetch 4 items")
    var result = [ShoppingItem]()

    repo.getShoppingItems(forDate: mockDate, forDays: daysAhead, onComplete: { items in
      result = items
      expectation.fulfill()
    })

    XCTAssertEqual(result.count, daysAhead)

    let names = result.map { $0.itemName }

    for iterator in 0..<daysAhead {
      XCTAssertTrue(names.contains("testItem\(iterator)"))
    }

    waitForExpectations(timeout: 1, handler: nil)
  }

  func testUpdateShoppingItemUpdatesTheCorrectItem() {

    coreDataMock.addMockData(mockDate: mockDate)

    let daysAhead = 1

    let expectation = self.expectation(description: "Should fetch 1 items")
    var result = [ShoppingItem]()

    repo.getShoppingItems(forDate: mockDate, forDays: daysAhead, onComplete: { items in
      result = items
      expectation.fulfill()
    })

    waitForExpectations(timeout: 1, handler: nil)

    let itemToUpdate = result[0]
    itemToUpdate.isBought = true

    repo.updateShoppingItem(itemToUpdate)

    let items = coreDataMock.fetchRecordsForEntity(Entities.shoppingItemEntity.rawValue)

    XCTAssertTrue(items.count > 0)

    for item in items  where (item.value(forKey: "itemName") as? String) == itemToUpdate.itemName {
      XCTAssertEqual(item.value(forKey: "boughtStatus")  as? Bool, true)
    }

  }
}
