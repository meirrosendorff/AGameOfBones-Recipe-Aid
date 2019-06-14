//
//  SearchResultsModel.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/06/14.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import Foundation

class SearchResultsModel: SearchResultsModelProtocol {

  var numResults: Int {
    return resultSet.count
  }
  private var resultSet: [Recipe]

  init () {
    resultSet = []
  }

  func getResultSource(forPos pos: Int) -> String {
    if pos < numResults {
      return resultSet[pos].source
    } else {
      return ""
    }
  }

  func getResultName(forPos pos: Int) -> String {
    if pos < numResults {
      return resultSet[pos].label
    } else {
      return ""
    }
  }

  func getResultServings(forPos pos: Int) -> Double {
    if pos < numResults {
      return resultSet[pos].yield
    } else {
      return 0
    }
  }

  func getResultCalories(forPos pos: Int) -> Double {
    if pos < numResults {
      return resultSet[pos].calories
    } else {
      return 0
    }
  }

  func getResultImageUrl(forPos pos: Int) -> String {
    if pos < numResults {
      return resultSet[pos].image
    } else {
      return ""
    }
  }

  func addNewSearchResults(results: [Recipe]) {
    resultSet.removeAll()
    resultSet = results
  }

  func addMoreResultsToSet(newResults: [Recipe]) {
    resultSet += newResults
  }
}
