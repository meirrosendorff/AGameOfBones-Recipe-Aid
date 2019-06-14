//
//  SearchResultsModelProtocol.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/06/14.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import Foundation

protocol  SearchResultsModelProtocol {

  var numResults: Int { get }
  func getResultSource(forPos: Int) -> String
  func getResultName(forPos: Int) -> String
  func getResultServings(forPos: Int) -> Double
  func getResultCalories(forPos: Int) -> Double
  func getResultImageUrl(forPos: Int) -> String
  func addNewSearchResults(results: [Recipe])
  func addMoreResultsToSet(newResults: [Recipe])
  func getRecipe(at pos: Int) -> Recipe
}
