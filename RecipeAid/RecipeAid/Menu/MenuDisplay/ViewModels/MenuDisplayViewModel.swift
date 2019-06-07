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
  var dateString: String {

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "d MMM yyyy"
    return dateFormatter.string(from: date)

  }

  init (forDate date: Date) {

    self.date = date
    menu = MenuForDay()
    recipeName = ""
    ingredients = []
    recipeSource = ""
    recipeImageURL = ""

  }

  func getMealOptions() -> [String] {
    return menu.getMealOptions()
  }

  func updateMeal(meal: String, onComplete: @escaping (MenueDisplayViewModel, Bool) -> Void) {

    let result = menu.getRecipe(forMeal: meal)

    switch result {
    case .success(let recipe):

      updateCurRecipe(with: recipe)
      onComplete(self, true)

    case .failure(let error):

      switch error {
      case .noMealExistsForGivenIdentifier:

        let repo = EdamamRecipeAPIRepository()
        //this access a fake recipe ID for now
        if let recipeID = dates[date.timeIntervalSince1970]?[meal], recipeID != "" {

          repo.getRecipe(forID: recipeID, onComplete: { result in

            switch result {

            case .success(let recipe):

              self.menu.addRecipe(recipe, for: meal)
              self.updateCurRecipe(with: recipe)
              onComplete(self, true)

            case .failure(let error):
              print(String(describing: error))
              onComplete(self, false)
            }
          })
        } else {
          print(String(describing: RecipeError.noMealExistsForGivenIdentifier(
            "in MenuDisplayViewModel.updateMeal for meal \(meal) on date \(dateString)")))
          onComplete(self, false)
        }

      default:
        print(String(describing: error))
        onComplete(self, false)
      }
    }
  }

  private func updateCurRecipe(with recipe: Recipe) {

    self.recipeName = recipe.label
    self.ingredients = recipe.ingredientLines
    self.recipeSource = recipe.source
    self.recipeImageURL = recipe.image
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
