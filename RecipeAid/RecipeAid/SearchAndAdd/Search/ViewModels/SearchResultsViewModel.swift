//
//  SearchResultsViewModel.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/06/13.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import Foundation

class SearchResultsViewModel: SearchResultsViewModelProtocol {

  var model: SearchResultsModelProtocol
  var repo: EdamamRecipeAPIRepositoryProtocol
  var numResults: Int {
      return model.numResults
  }
  var noResults: String
  private let imageFetcher: ImageFetcher
  private var lastResultIndex: Int
  private var resultSetSize: Int
  private var lastQuery: String

  init() {
    model = SearchResultsModel()
    imageFetcher = ImageFetcher()
    repo = EdamamRecipeAPIRepository()
    noResults = ""
    lastResultIndex = 0
    resultSetSize = 10
    lastQuery = ""
  }

  func getResultSource(forPos pos: Int) -> String {
    return model.getResultSource(forPos: pos)
  }

  func getResultName(forPos pos: Int) -> String {
    return model.getResultName(forPos: pos)
  }

  func getResultServings(forPos pos: Int) -> String {
    return "Servings: \(Int(model.getResultServings(forPos: pos).rounded()))"
  }

  func getResultCalories(forPos pos: Int) -> String {
    return "Calories: \(Int(model.getResultCalories(forPos: pos).rounded()))"
  }

  func getResultImage(forPos pos: Int, onComplete: @escaping (Data) -> Void) {
    let url = model.getResultImageUrl(forPos: pos)

    if url == "" {
      return
    }

    guard let toFetch = URL(string: url) else {

      print(RecipeError.urlBuildError("in SearchResultsViewModel.getResultImage"))
      return

    }

    imageFetcher.getData(from: toFetch, onComplete: { data, _, error in

      guard let data = data else {

        print(RecipeError.unableToFetchImage(
          "in SearchResultsViewModel.getResultImage with error: \(error?.localizedDescription ?? "")"))
        return
      }

      onComplete(data)
    })
  }

  private func getNextResultRange() -> (Int, Int) {
    let nextRange = (lastResultIndex, lastResultIndex + resultSetSize)
    self.lastResultIndex += resultSetSize
    return nextRange
  }

  private func resetSearchRange() {
    lastResultIndex = 0
  }

  func getNextSearchResults(for query: String, onComplete: @escaping (Bool) -> Void) {

    var isNewSearch = false

    if query != lastQuery {
      isNewSearch = true
      self.resetSearchRange()
    }

    repo.performSearch(forQuery: query, resultRange: getNextResultRange(), onComplete: { result in

      switch result {
      case .success(let recipeSet):

        if recipeSet.isEmpty {
          self.noResults = "No recipes found for \(query)"
          onComplete(false)
          return
        }

        if isNewSearch {
          self.model.addNewSearchResults(results: recipeSet)
          self.lastQuery = query
        } else {
          self.model.addMoreResultsToSet(newResults: recipeSet)
        }

        onComplete(true)

      case .failure(let error):

        print(String(describing: error))
        self.noResults = "No recipes found for \(query)"
        onComplete(false)
      }
    })
  }

  func getViewModelForRecipe(at pos: Int) -> RecipeDetailsViewModelProtocol {
    return RecipeDetailsViewModel(recipe: model.getRecipe(at: pos))
  }
}
