//
//  MenuDisplayViewModel.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/06/04.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//
import Foundation

class MenueDisplayViewModel: MenuDisplayViewModelProtocol {

  private let date: Date
  private let menu: MenuForDay
  var recipeName: String
  var ingredients: [String]
  var recipeSource: String
  var recipeImageURL: String
  var dateString: String { return menu.dateString }

  init (forDate date: Date) {

    self.date = date
    menu = MenuForDay(date)
    recipeName = ""
    ingredients = []
    recipeSource = ""
    recipeImageURL = ""

  }

  func getMealOptions() -> [String] {
    return menu.getMealOptions()
  }

  func updateMeal(meal: String, onComplete: @escaping (MenueDisplayViewModel, Bool) -> Void) {

    menu.getRecipe(forMeal: meal, onComplete: { result in

      switch result {
      case .success(let recipe):

        self.recipeName = recipe.label
        self.ingredients = recipe.ingredientLines
        self.recipeSource = recipe.source
        self.recipeImageURL = recipe.image
        onComplete(self, true)

      case .failure(let error):

        print(String(describing: error))
        onComplete(self, false)
      }
    })

  }

  func getImageFromURL(_ url: String, onComplete: @escaping (Data) -> Void) {

    let imageFetcher = ImageFetcher()

    guard let toFetch = URL(string: url) else {

      print(RecipeError.urlBuildError("in MenuDisplayViewModel.getImageFromURL"))
      return

    }

    imageFetcher.getData(from: toFetch, onComplete: { data, _, error in

      guard let data = data else {

        print(RecipeError.unableToFetchImage(
          "in MenuDisplayViewModel.getImageFromURL with error: \(error?.localizedDescription ?? "")"))
        return

      }

      onComplete(data)
    })
  }
}
