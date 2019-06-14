//
//  SearchResultsViewModelProtocol.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/06/13.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import Foundation

protocol SearchResultsViewModelProtocol {
  var numResults: Int { get }
  var noResults: String { get }
  func getResultSource(forPos: Int) -> String
  func getResultName(forPos: Int) -> String
  func getResultServings(forPos: Int) -> String
  func getResultCalories(forPos: Int) -> String
  func getResultImage(forPos: Int, onComplete: @escaping (Data) -> Void)
  func getNextSearchResults(for: String, onComplete: @escaping (Bool) -> Void)
}
