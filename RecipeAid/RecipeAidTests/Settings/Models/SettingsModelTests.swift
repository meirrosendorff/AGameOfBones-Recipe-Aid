//
//  SettingsModelTests.swift
//  RecipeAidTests
//
//  Created by Meir Rosendorff on 2019/06/24.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import XCTest
@testable import RecipeAid

class SettingsModelTests: XCTestCase {

  var model: SettingsModel!

  override func setUp() {
    model = SettingsModel()
    super.setUp()
  }

  override func tearDown() {
    model = nil
    super.tearDown()
  }

  func testRestrictionsAlwaysIntheSameOrder() {

    var restrictions = [("a", true), ("b", true), ("c", true)]

    model.restrictions = restrictions

    XCTAssertEqual(model.restrictionName(at: 0), "a")
    XCTAssertEqual(model.restrictionName(at: 1), "b")
    XCTAssertEqual(model.restrictionName(at: 2), "c")

    restrictions = [("b", true), ("a", true), ("c", true)]

    model.restrictions = restrictions

    XCTAssertEqual(model.restrictionName(at: 0), "a")
    XCTAssertEqual(model.restrictionName(at: 1), "b")
    XCTAssertEqual(model.restrictionName(at: 2), "c")
  }

  func testNumRestrictionsReturnsCorrectNumberOfRestrictions() {

    XCTAssertEqual(model.numRestrictions, 0)

    var restrictions = [("a", true), ("b", true), ("c", true)]

    model.restrictions = restrictions

    XCTAssertEqual(model.numRestrictions, 3)

    restrictions = [("a", true), ("b", true), ("c", true), ("a", true), ("b", true), ("c", true)]

    model.restrictions = restrictions

    XCTAssertEqual(model.numRestrictions, 6)
  }

  func testDeselectRestrictionSetsSelectedRestrictionToDeselected() {

    let restrictions = [("a", true), ("b", true), ("c", true)]

    model.restrictions = restrictions

    model.deselectRestriction(at: 1)

    XCTAssertFalse(model.restrictionIsSelected(at: 1))

    XCTAssertTrue(model.restrictionIsSelected(at: 0))
    XCTAssertTrue(model.restrictionIsSelected(at: 2))
  }

  func testSelectRestrictionSetsSelectedRestrictionToSelected() {

    let restrictions = [("a", false), ("b", false), ("c", false)]

    model.restrictions = restrictions

    model.selectRestriction(at: 1)

    XCTAssertTrue(model.restrictionIsSelected(at: 1))

    XCTAssertFalse(model.restrictionIsSelected(at: 0))
    XCTAssertFalse(model.restrictionIsSelected(at: 2))
  }
}
