//
//  SettingsViewModelRepoInteractionTests.swift
//  RecipeAidTests
//
//  Created by Meir Rosendorff on 2019/06/24.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import XCTest
import Cuckoo
@testable import RecipeAid

class SettingsViewModelRepoInteractionTests: XCTestCase {

  var repoMock: MockSettingsRepo!
  var modelMock: MockSettingsModel!
  var viewModel: SettingsViewModel!
  var minCalories: Int!
  var maxCalories: Int!
  var minTime: Int!
  var maxTime: Int!
  var restrictions: [(String, Bool)]!
  var unwatedFoods: [String]!

  override func setUp() {
    super.setUp()
    viewModel = SettingsViewModel()
    repoMock = MockSettingsRepo()
    modelMock = MockSettingsModel()
    viewModel.repo = repoMock
    viewModel.model = modelMock
    minCalories = 0
    maxCalories = 1
    minTime = 2
    maxTime = 3
    restrictions = [("a", true), ("b", false), ("c", true)]
    unwatedFoods = ["a", "b", "c"]
  }

  override func tearDown() {
    viewModel = nil
    repoMock = nil
    modelMock = nil
    minCalories = nil
    maxCalories = nil
    minTime = nil
    maxTime = nil
    restrictions = nil
    unwatedFoods = nil
    super.tearDown()
  }

  func testUpdateReadsAllValuesFromRepoAndSavesThemToModel() {

    stubRepoGets()
    stubModelSets()

    viewModel.updateSettings()

    verifyModelSets()
    verifyRepoGets()
  }

  func testSaveReadsAllValuesFromModelAndSavesThemToRepo() {

    stubModelGets()
    stubModelSets()
    stubRepoGets()
    stubRepoSets()

    viewModel.save()

    verifyRepoSets()
    verifyModelGets()
  }

  func testSaveUpdatesValuesInModelFromRepoAfterSaving() {

    stubModelGets()
    stubModelSets()
    stubRepoGets()
    stubRepoSets()

    viewModel.save()

    verifyRepoGets()
    verifyModelSets()
  }

  func stubRepoGets() {

    stub(repoMock) { stub in

      when(stub.getCaloriesRange()).then({ return (self.minCalories, self.maxCalories) })
      when(stub.getTimesRange()).then({ return (self.minTime, self.maxTime) })
      when(stub.getRestrictions()).then({ return self.restrictions })
      when(stub.getUnwantedFoods()).then({ return self.unwatedFoods })
    }
  }

  func stubRepoSets() {

    stub(repoMock) { stub in

      when(stub.setCaloriesRange(calories: equal(to: (self.minCalories, self.maxCalories)))).thenDoNothing()
      when(stub.setTimesRange(times: equal(to: (self.minTime, self.maxTime)))).thenDoNothing()
      when(stub.setRestrictions(restrictions: equal(to: self.restrictions))).thenDoNothing()
      when(stub.setUnwatedFoods(foods: equal(to: self.unwatedFoods))).thenDoNothing()
    }
  }

  func stubModelGets() {

    stub(modelMock) { stub in

      when(stub.minCalories.get).then({ return self.minCalories })
      when(stub.maxCalories.get).then({ return self.maxCalories })
      when(stub.minTime.get).then({ return self.minTime })
      when(stub.maxTime.get).then({ return self.maxTime })
      when(stub.restrictions.get).then({ return self.restrictions })
      when(stub.unwantedFoods.get).then({ return self.unwatedFoods })
    }
  }

  func stubModelSets() {

    stub(modelMock) { stub in

      when(stub.minCalories.set(self.minCalories)).thenDoNothing()
      when(stub.maxCalories.set(self.maxCalories)).thenDoNothing()
      when(stub.minTime.set(self.minTime)).thenDoNothing()
      when(stub.maxTime.set(self.maxTime)).thenDoNothing()
      when(stub.restrictions.set(equal(to: self.restrictions))).thenDoNothing()
      when(stub.unwantedFoods.set(equal(to: self.unwatedFoods))).thenDoNothing()
    }
  }

  func verifyModelSets() {

    verify(modelMock, times(1)).minCalories.set(minCalories)
    verify(modelMock, times(1)).maxCalories.set(maxCalories)
    verify(modelMock, times(1)).minTime.set(minTime)
    verify(modelMock, times(1)).maxTime.set(maxTime)
    verify(modelMock, times(1)).restrictions.set(equal(to: restrictions))
    verify(modelMock, times(1)).unwantedFoods.set(equal(to: unwatedFoods))
  }

  func verifyModelGets() {

    verify(modelMock, times(1)).minCalories.get()
    verify(modelMock, times(1)).maxCalories.get()
    verify(modelMock, times(1)).minTime.get()
    verify(modelMock, times(1)).maxTime.get()
    verify(modelMock, times(1)).unwantedFoods.get()
  }

  func verifyRepoSets() {

    verify(repoMock, times(1)).setCaloriesRange(calories: equal(to: (self.minCalories, self.maxCalories)))
    verify(repoMock, times(1)).setTimesRange(times: equal(to: (self.minTime, self.maxTime)))
    verify(repoMock, times(1)).setRestrictions(restrictions: equal(to: self.restrictions))
    verify(repoMock, times(1)).setUnwatedFoods(foods: equal(to: self.unwatedFoods))
  }

  func verifyRepoGets() {

    verify(repoMock, times(1)).getCaloriesRange()
    verify(repoMock, times(1)).getTimesRange()
    verify(repoMock, times(1)).getRestrictions()
    verify(repoMock, times(1)).getUnwantedFoods()
  }
}
