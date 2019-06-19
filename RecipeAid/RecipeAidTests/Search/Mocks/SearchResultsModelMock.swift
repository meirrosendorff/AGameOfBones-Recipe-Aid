//
//  SearchResultsModelMock.swift
//  RecipeAidTests
//
//  Created by Meir Rosendorff on 2019/06/18.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import Foundation
@testable import RecipeAid

class SearchResultsModelMock: SearchResultsModel {

  var addNewSearchResultsMethodCalls = 0
  var addMoreResultsToSetMethodCalls = 0

  override func addNewSearchResults(results: [Recipe]) {
    addNewSearchResultsMethodCalls += 1
    super.addNewSearchResults(results: results)
  }

  override func addMoreResultsToSet(newResults: [Recipe]) {
    addMoreResultsToSetMethodCalls += 1
    super.addMoreResultsToSet(newResults: newResults)
  }
}
