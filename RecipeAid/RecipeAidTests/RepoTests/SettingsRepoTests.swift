//
//  SettingsRepoTests.swift
//  RecipeAidTests
//
//  Created by Meir Rosendorff on 2019/06/24.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import XCTest
@testable import RecipeAid

class SettingsRepoTests: XCTestCase {

  var userDefaultsMock: UserDefaultsMock!
  var repo: SettingsRepo!

  override func setUp() {
    super.setUp()
    userDefaultsMock = UserDefaultsMock()
    repo = SettingsRepo()
    repo.userDefaults = userDefaultsMock
  }

  override func tearDown() {
    super.tearDown()
  }

  func testGetRestrictionsOnlyFetchesRestrictions() {

    _ = repo.getRestrictions()

    XCTAssertEqual(userDefaultsMock.minCaloriesGetCount, 0)
    XCTAssertEqual(userDefaultsMock.maxCalorioesGetCount, 0)
    XCTAssertEqual(userDefaultsMock.minTimesGetCount, 0)
    XCTAssertEqual(userDefaultsMock.maxTimesGetCount, 0)
    XCTAssertEqual(userDefaultsMock.restrictionsGetCount, 1)
    XCTAssertEqual(userDefaultsMock.excludedFoodsGetCount, 0)

    XCTAssertEqual(userDefaultsMock.minCaloriesSetCount, 0)
    XCTAssertEqual(userDefaultsMock.maxCalorioesSetCount, 0)
    XCTAssertEqual(userDefaultsMock.minTimesSetCount, 0)
    XCTAssertEqual(userDefaultsMock.maxTimesSetCount, 0)
    XCTAssertEqual(userDefaultsMock.restrictionsSetCount, 0)
    XCTAssertEqual(userDefaultsMock.excludedFoodsSetCount, 0)
  }

  func testSetRestrictionsOnlySetsRestrictions() {

    _ = repo.setRestrictions(restrictions: [])

    XCTAssertEqual(userDefaultsMock.minCaloriesGetCount, 0)
    XCTAssertEqual(userDefaultsMock.maxCalorioesGetCount, 0)
    XCTAssertEqual(userDefaultsMock.minTimesGetCount, 0)
    XCTAssertEqual(userDefaultsMock.maxTimesGetCount, 0)
    XCTAssertEqual(userDefaultsMock.restrictionsGetCount, 0)
    XCTAssertEqual(userDefaultsMock.excludedFoodsGetCount, 0)

    XCTAssertEqual(userDefaultsMock.minCaloriesSetCount, 0)
    XCTAssertEqual(userDefaultsMock.maxCalorioesSetCount, 0)
    XCTAssertEqual(userDefaultsMock.minTimesSetCount, 0)
    XCTAssertEqual(userDefaultsMock.maxTimesSetCount, 0)
    XCTAssertEqual(userDefaultsMock.restrictionsSetCount, 1)
    XCTAssertEqual(userDefaultsMock.excludedFoodsSetCount, 0)
  }

  func testGetCaloriesOnlyFetchesCalories() {

    _ = repo.getCaloriesRange()

    XCTAssertEqual(userDefaultsMock.minCaloriesGetCount, 1)
    XCTAssertEqual(userDefaultsMock.maxCalorioesGetCount, 1)
    XCTAssertEqual(userDefaultsMock.minTimesGetCount, 0)
    XCTAssertEqual(userDefaultsMock.maxTimesGetCount, 0)
    XCTAssertEqual(userDefaultsMock.restrictionsGetCount, 0)
    XCTAssertEqual(userDefaultsMock.excludedFoodsGetCount, 0)

    XCTAssertEqual(userDefaultsMock.minCaloriesSetCount, 0)
    XCTAssertEqual(userDefaultsMock.maxCalorioesSetCount, 0)
    XCTAssertEqual(userDefaultsMock.minTimesSetCount, 0)
    XCTAssertEqual(userDefaultsMock.maxTimesSetCount, 0)
    XCTAssertEqual(userDefaultsMock.restrictionsSetCount, 0)
    XCTAssertEqual(userDefaultsMock.excludedFoodsSetCount, 0)
  }

  func testSetCaloriesOnlySetsCalories() {

    _ = repo.setCaloriesRange(calories: (0, 0))

    XCTAssertEqual(userDefaultsMock.minCaloriesGetCount, 0)
    XCTAssertEqual(userDefaultsMock.maxCalorioesGetCount, 0)
    XCTAssertEqual(userDefaultsMock.minTimesGetCount, 0)
    XCTAssertEqual(userDefaultsMock.maxTimesGetCount, 0)
    XCTAssertEqual(userDefaultsMock.restrictionsGetCount, 0)
    XCTAssertEqual(userDefaultsMock.excludedFoodsGetCount, 0)

    XCTAssertEqual(userDefaultsMock.minCaloriesSetCount, 1)
    XCTAssertEqual(userDefaultsMock.maxCalorioesSetCount, 1)
    XCTAssertEqual(userDefaultsMock.minTimesSetCount, 0)
    XCTAssertEqual(userDefaultsMock.maxTimesSetCount, 0)
    XCTAssertEqual(userDefaultsMock.restrictionsSetCount, 0)
    XCTAssertEqual(userDefaultsMock.excludedFoodsSetCount, 0)
  }

  func testGetTimesOnlyFetchesTimes() {

    _ = repo.getTimesRange()

    XCTAssertEqual(userDefaultsMock.minCaloriesGetCount, 0)
    XCTAssertEqual(userDefaultsMock.maxCalorioesGetCount, 0)
    XCTAssertEqual(userDefaultsMock.minTimesGetCount, 1)
    XCTAssertEqual(userDefaultsMock.maxTimesGetCount, 1)
    XCTAssertEqual(userDefaultsMock.restrictionsGetCount, 0)
    XCTAssertEqual(userDefaultsMock.excludedFoodsGetCount, 0)

    XCTAssertEqual(userDefaultsMock.minCaloriesSetCount, 0)
    XCTAssertEqual(userDefaultsMock.maxCalorioesSetCount, 0)
    XCTAssertEqual(userDefaultsMock.minTimesSetCount, 0)
    XCTAssertEqual(userDefaultsMock.maxTimesSetCount, 0)
    XCTAssertEqual(userDefaultsMock.restrictionsSetCount, 0)
    XCTAssertEqual(userDefaultsMock.excludedFoodsSetCount, 0)
  }

  func testSetTimesOnlySetsTimes() {

    _ = repo.setTimesRange(times: (0, 0))

    XCTAssertEqual(userDefaultsMock.minCaloriesGetCount, 0)
    XCTAssertEqual(userDefaultsMock.maxCalorioesGetCount, 0)
    XCTAssertEqual(userDefaultsMock.minTimesGetCount, 0)
    XCTAssertEqual(userDefaultsMock.maxTimesGetCount, 0)
    XCTAssertEqual(userDefaultsMock.restrictionsGetCount, 0)
    XCTAssertEqual(userDefaultsMock.excludedFoodsGetCount, 0)

    XCTAssertEqual(userDefaultsMock.minCaloriesSetCount, 0)
    XCTAssertEqual(userDefaultsMock.maxCalorioesSetCount, 0)
    XCTAssertEqual(userDefaultsMock.minTimesSetCount, 1)
    XCTAssertEqual(userDefaultsMock.maxTimesSetCount, 1)
    XCTAssertEqual(userDefaultsMock.restrictionsSetCount, 0)
    XCTAssertEqual(userDefaultsMock.excludedFoodsSetCount, 0)
  }

  func testGetUnwatedFoodsOnlyFetchesUnwantedFoods() {

    _ = repo.getUnwantedFoods()

    XCTAssertEqual(userDefaultsMock.minCaloriesGetCount, 0)
    XCTAssertEqual(userDefaultsMock.maxCalorioesGetCount, 0)
    XCTAssertEqual(userDefaultsMock.minTimesGetCount, 0)
    XCTAssertEqual(userDefaultsMock.maxTimesGetCount, 0)
    XCTAssertEqual(userDefaultsMock.restrictionsGetCount, 0)
    XCTAssertEqual(userDefaultsMock.excludedFoodsGetCount, 1)

    XCTAssertEqual(userDefaultsMock.minCaloriesSetCount, 0)
    XCTAssertEqual(userDefaultsMock.maxCalorioesSetCount, 0)
    XCTAssertEqual(userDefaultsMock.minTimesSetCount, 0)
    XCTAssertEqual(userDefaultsMock.maxTimesSetCount, 0)
    XCTAssertEqual(userDefaultsMock.restrictionsSetCount, 0)
    XCTAssertEqual(userDefaultsMock.excludedFoodsSetCount, 0)
  }

  func testSetUnwatedFoodsOnlySetsUnwantedFoods() {

    _ = repo.setUnwatedFoods(foods: [])

    XCTAssertEqual(userDefaultsMock.minCaloriesGetCount, 0)
    XCTAssertEqual(userDefaultsMock.maxCalorioesGetCount, 0)
    XCTAssertEqual(userDefaultsMock.minTimesGetCount, 0)
    XCTAssertEqual(userDefaultsMock.maxTimesGetCount, 0)
    XCTAssertEqual(userDefaultsMock.restrictionsGetCount, 0)
    XCTAssertEqual(userDefaultsMock.excludedFoodsGetCount, 0)

    XCTAssertEqual(userDefaultsMock.minCaloriesSetCount, 0)
    XCTAssertEqual(userDefaultsMock.maxCalorioesSetCount, 0)
    XCTAssertEqual(userDefaultsMock.minTimesSetCount, 0)
    XCTAssertEqual(userDefaultsMock.maxTimesSetCount, 0)
    XCTAssertEqual(userDefaultsMock.restrictionsSetCount, 0)
    XCTAssertEqual(userDefaultsMock.excludedFoodsSetCount, 1)
  }

  func testRestrictionsCorrectlyConvertedToDictionary() {

    let firstRestriction = DietaryRestrictions.alcoholFree
    let secondRestriction = DietaryRestrictions.lowFat
    let thirdRestriction = DietaryRestrictions.lowCarb
    let restrictions = [(firstRestriction.description(), true),
                        (secondRestriction.description(), false),
                        (thirdRestriction.description(), true)]

    repo.setRestrictions(restrictions: restrictions)

    let dict = userDefaultsMock.lastRestrictionsSaved

    XCTAssertTrue(dict[firstRestriction.webKey()] ?? false)
    XCTAssertFalse(dict[secondRestriction.webKey()] ?? true)
    XCTAssertTrue(dict[thirdRestriction.webKey()] ?? false)
  }
}
