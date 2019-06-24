//
//  SettingsViewModelModelInteractionTests.swift
//  RecipeAidTests
//
//  Created by Meir Rosendorff on 2019/06/24.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import XCTest
import Cuckoo
@testable import RecipeAid

class SettingsViewModelModelInteractionTests: XCTestCase {

  var repoMock: MockSettingsRepo!
  var modelMock: MockSettingsModel!
  var viewModel: SettingsViewModel!

  override func setUp() {
    super.setUp()
    viewModel = SettingsViewModel()
    repoMock = MockSettingsRepo()
    modelMock = MockSettingsModel()
    viewModel.repo = repoMock
    viewModel.model = modelMock
  }

  override func tearDown() {
    viewModel = nil
    repoMock = nil
    modelMock = nil
    super.tearDown()
  }

  func testNumRestrictionReturnsNumberOfRestrictionsInModel() {

    let numRestrictionsExpected = 42

    stub(modelMock) { stub in
      when(stub.numRestrictions.get).thenReturn(numRestrictionsExpected)
    }

    let numRestrictionsRecieved = viewModel.numRestrictions

    XCTAssertEqual(numRestrictionsExpected, numRestrictionsRecieved)
  }

  func testMinCaloriesReturnsNumberOfCaloriesInModel() {

    let caloriesExpected = 42

    stub(modelMock) { stub in
      when(stub.minCalories.get).thenReturn(caloriesExpected)
    }

    let caloriesRecieved = viewModel.minCalories

    XCTAssertEqual(String(caloriesExpected), caloriesRecieved)
  }

  func testMaxCaloriesReturnsNumberOfCaloriesInModel() {

    let caloriesExpected = 42

    stub(modelMock) { stub in
      when(stub.maxCalories.get).thenReturn(caloriesExpected)
    }

    let caloriesRecieved = viewModel.maxCalories

    XCTAssertEqual(String(caloriesExpected), caloriesRecieved)
  }

  func testMinTimeReturnsAmmountOfTimeInModel() {

    let timeExpected = 42

    stub(modelMock) { stub in
      when(stub.minTime.get).thenReturn(timeExpected)
    }

    let timeRecieved = viewModel.minTime

    XCTAssertEqual(String(timeExpected), timeRecieved)
  }

  func testMaxTimeReturnsAmmountOfTimeInModel() {

    let timeExpected = 42

    stub(modelMock) { stub in
      when(stub.maxTime.get).thenReturn(timeExpected)
    }

    let timeRecieved = viewModel.maxTime

    XCTAssertEqual(String(timeExpected), timeRecieved)
  }

  func testUnwantedFoodReturnsCorrectlyFormattedStringOfFoodsInModel() {

    let foods = ["a", "b", "c"]
    let expectedReturnString = "a, b, c"

    stub(modelMock) { stub in
      when(stub.unwantedFoods.get).thenReturn(foods)
    }

    let returnedString = viewModel.unwantedFoods

    XCTAssertEqual(returnedString, expectedReturnString)
  }

  func testRestrictionNameFetchesTheCorrectRestrictionFromModel() {
    let nameToReturn = "No Suger"
    let index = 42

    stub(modelMock) { stub in
      when(stub.restrictionName(at: index)).thenReturn(nameToReturn)
    }

    let nameReturned = viewModel.restrictionName(at: index)

    XCTAssertEqual(nameToReturn, nameReturned)
  }

  func testRestrictionIsSelectedFetchesTheCorrectRestrictionFromModel() {

    let toReturn = true
    let index = 42

    stub(modelMock) { stub in
      when(stub.restrictionIsSelected(at: index)).thenReturn(toReturn)
    }

    let returned = viewModel.restrictionIsSelected(at: index)

    XCTAssertEqual(toReturn, returned)
  }

  func testSelectRestrictionSelectsCorrectRestrictionInModel() {

    let index = 42

    stub(modelMock) { stub in
      when(stub.selectRestriction(at: index)).thenDoNothing()
    }

    viewModel.selectRestriction(at: index)

    verify(modelMock).selectRestriction(at: index)
  }

  func testDeselectRestrictionDeselectsCorrectRestrictionInModel() {

    let index = 42

    stub(modelMock) { stub in
      when(stub.deselectRestriction(at: index)).thenDoNothing()
    }

    viewModel.deselectRestriction(at: index)

    verify(modelMock).deselectRestriction(at: index)
  }

  func testSetCaloriesSetsCaloriesInModelWhenGiveValidCalorieRange() {

    let minCalories = 42
    let maxCalories = 43

    stub(modelMock) { stub in
      when(stub.minCalories.set(minCalories)).thenDoNothing()
      when(stub.maxCalories.set(maxCalories)).thenDoNothing()
    }

    do {
      try viewModel.setCalories(min: String(minCalories), max: String(maxCalories))

      verify(modelMock, times(1)).minCalories.set(minCalories)
      verify(modelMock, times(1)).maxCalories.set(maxCalories)

    } catch {

      XCTFail("Set Calories threw error when given valid calories range, with error: \(error)")
    }
  }

  func testSetCaloriesTruncatesDoublesToIntsAndCorrectlySetsTheModel() {

    let minCalories = 42
    let maxCalories = 43

    stub(modelMock) { stub in
      when(stub.minCalories.set(minCalories)).thenDoNothing()
      when(stub.maxCalories.set(maxCalories)).thenDoNothing()
    }

    do {

      try viewModel.setCalories(min: "42.98", max: "43.47")

      verify(modelMock, times(1)).minCalories.set(minCalories)
      verify(modelMock, times(1)).maxCalories.set(maxCalories)

    } catch {

      XCTFail("Set Calories threw error when given valid calories range, with error: \(error)")
    }
  }

  func testSetCaloriesThrowsMinMaxErrorAndDoesNotSetModelWhenGivenMaxLessThanMin() {

    let minCalories = 100
    let maxCalories = 0

    stub(modelMock) { stub in
      when(stub.minCalories.set(minCalories)).thenDoNothing()
      when(stub.maxCalories.set(maxCalories)).thenDoNothing()
    }

    do {

      try viewModel.setCalories(min: String(minCalories), max: String(maxCalories))

      XCTFail("Should have thrown minMaxError")

    } catch {

      switch error {
      case RecipeError.minMaxError:
        verify(modelMock, times(0)).minCalories.set(minCalories)
        verify(modelMock, times(0)).maxCalories.set(maxCalories)
      default:
        XCTFail("Set Calories threw error other than minMaxError, with error: \(error)")
      }
    }
  }

  func testSetCaloriesThrowsInvalidNumberStringErrorAndDoesNotSetModelWhenGivenANonNumber() {

    let minCalories = 0
    let maxCalories = 10

    stub(modelMock) { stub in
      when(stub.minCalories.set(minCalories)).thenDoNothing()
      when(stub.maxCalories.set(maxCalories)).thenDoNothing()
    }

    do {

      try viewModel.setCalories(min: "Not a number", max: "I too am not a number")

      XCTFail("Should have thrown InvalidNumberStringError")

    } catch {

      switch error {
      case RecipeError.invalidNumberString:
        verify(modelMock, times(0)).minCalories.set(minCalories)
        verify(modelMock, times(0)).maxCalories.set(maxCalories)
      default:
        XCTFail("Set Calories threw error other than InvalidNumberStringError, with error: \(error)")
      }
    }
  }

  func testSetTimesSetsTimesInModelWhenGiveValidTimeRange() {

    let minTime = 42
    let maxTime = 43

    stub(modelMock) { stub in
      when(stub.minTime.set(minTime)).thenDoNothing()
      when(stub.maxTime.set(maxTime)).thenDoNothing()
    }

    do {

      try viewModel.setTimes(min: String(minTime), max: String(maxTime))

      verify(modelMock, times(1)).minTime.set(minTime)
      verify(modelMock, times(1)).maxTime.set(maxTime)

    } catch {

      XCTFail("Set Time threw error when given valid Times range, with error: \(error)")
    }
  }

  func testSetTimesTruncatesDoublesToIntsAndCorrectlySetsTheModel() {

    let minTime = 42
    let maxTime = 43

    stub(modelMock) { stub in
      when(stub.minTime.set(minTime)).thenDoNothing()
      when(stub.maxTime.set(maxTime)).thenDoNothing()
    }

    do {

      try viewModel.setTimes(min: "42.98", max: "43.47")

      verify(modelMock, times(1)).minTime.set(minTime)
      verify(modelMock, times(1)).maxTime.set(maxTime)

    } catch {

      XCTFail("Set Time threw error when given valid Times range, with error: \(error)")
    }
  }

  func testSetTimesThrowsMinMaxErrorAndDoesNotSetModelWhenGivenMaxLessThanMin() {

    let minTime = 100
    let maxTime = 0

    stub(modelMock) { stub in
      when(stub.minTime.set(minTime)).thenDoNothing()
      when(stub.maxTime.set(maxTime)).thenDoNothing()
    }

    do {

      try viewModel.setTimes(min: String(minTime), max: String(maxTime))

      XCTFail("Should have thrown minMaxError")

    } catch {

      switch error {
      case RecipeError.minMaxError:
        verify(modelMock, times(0)).minTime.set(minTime)
        verify(modelMock, times(0)).maxTime.set(maxTime)
      default:
        XCTFail("Set Times threw error other than minMaxError, with error: \(error)")
      }
    }
  }

  func testSetTimesThrowsInvalidNumberStringErrorAndDoesNotSetModelWhenGivenANonNumber() {

    let minTime = 0
    let maxTime = 10

    stub(modelMock) { stub in
      when(stub.minTime.set(minTime)).thenDoNothing()
      when(stub.maxTime.set(maxTime)).thenDoNothing()
    }

    do {

      try viewModel.setTimes(min: "Not a number", max: "I too am not a number")

      XCTFail("Should have thrown InvalidNumberStringError")

    } catch {

      switch error {
      case RecipeError.invalidNumberString:
        verify(modelMock, times(0)).minTime.set(minTime)
        verify(modelMock, times(0)).maxTime.set(maxTime)
      default:
        XCTFail("Set Times threw error other than InvalidNumberStringError, with error: \(error)")
      }
    }
  }

  func testSetUnwatedFoodsCorrectlyParsesStringAndSavesToModel() {

    let unwatedFoodsString = "a, b, c, d"
    let unwantedFoodsArr = ["a", "b", "c", "d"]

    stub(modelMock) { stub in
      when(stub.unwantedFoods.set(equal(to: unwantedFoodsArr))).thenDoNothing()
    }

    viewModel.setUnwatedFoods(foods: unwatedFoodsString)

    verify(modelMock, times(1)).unwantedFoods.set(equal(to: ["a", "b", "c", "d"]))
  }
}
