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
  var menu: MenuForDayProtocol
  var repo: EdamamRecipeAPIRepositoryProtocol
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
    repo = EdamamRecipeAPIRepository()
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

        getRecipeFromRepo(meal: meal, onComplete: { recipeIsPulledAndUpdated in

          onComplete(self, recipeIsPulledAndUpdated)
          })

      default:
        print(String(describing: error))
        onComplete(self, false)
      }
    }
  }

  private func getRecipeFromRepo(meal: String, onComplete: @escaping (Bool) -> Void) {

    let result = getRecipeIDToFetch(forMeal: meal)

    switch result {
    case .success(let recipeID):
      repo.getRecipe(forID: recipeID, onComplete: { result in

        switch result {

        case .success(let recipe):

          do {
            try self.menu.addRecipe(recipe, for: meal)
            self.updateCurRecipe(with: recipe)
            onComplete(true)
          } catch {
            onComplete(false)
          }
        case .failure(let error):
          print(String(describing: error))
          onComplete(false)
        }
      })

    case.failure(let error):
      print(String(describing: error))
      onComplete(false)
    }
  }

  func getRecipeIDToFetch(forMeal meal: String) -> Result<String, RecipeError> {
    //This Fetches fake data at the moment
    let cal: Calendar = Calendar(identifier: .gregorian)
    var components = DateComponents()
    components.year = 2019
    components.month = 6
    components.day = 15
    components.calendar = cal
    components.hour = 0
    components.minute = 0
    components.second = 0

    let today = cal.date(from: components) ?? Date()
    let yesterday = cal.date(byAdding: .day, value: -1, to: today) ?? Date()
    let tomorrow = cal.date(byAdding: .day, value: 1, to: today) ?? Date()

    let dates = [
      yesterday.timeIntervalSince1970: [
        "Breakfast": "7a844b79a5df3f11e822cc229bfb3981",
        "Lunch": "e9c30bda6b789283d22cff594d17ff73",
        "Dinner": ""
      ],
      today.timeIntervalSince1970: [
        "Breakfast": "",
        "Lunch": "e9c30bda6b789283d22cff594d17ff73",
        "Dinner": "b373d8987afb5808439ff243c16ccb63"
      ],
      tomorrow.timeIntervalSince1970: [
        "Breakfast": "7a844b79a5df3f11e822cc229bfb3981",
        "Lunch": "",
        "Dinner": "b373d8987afb5808439ff243c16ccb63"
      ]
    ]

    if let recipeID = dates[date.timeIntervalSince1970]?[meal], recipeID != "" {
      return .success(recipeID)
    } else {
      return .failure(.noMealExistsForGivenIdentifier("\(meal) on \(date.timeIntervalSince1970)"))
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
