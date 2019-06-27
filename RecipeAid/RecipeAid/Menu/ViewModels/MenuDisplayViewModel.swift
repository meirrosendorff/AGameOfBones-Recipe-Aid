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
  var networkRepo: EdamamRecipeAPIRepositoryProtocol
  var storageRepo: PersistantStorageRepoProtocol

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
    networkRepo = EdamamRecipeAPIRepository()
    storageRepo = CoreDataStorageRepo()
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

    self.getRecipeIDToFetch(forMeal: meal, onComplete: { result in

      switch result {
      case .success(let recipeID):
        self.networkRepo.getRecipe(forID: recipeID, onComplete: { result in

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
    })
  }

  func getRecipeIDToFetch(
    forMeal mealType: String,
    onComplete: @escaping (Result<String, RecipeError> ) -> Void) {

    guard let meal = MealTypes.getMealForDescription(description: mealType) else {
      return onComplete(.failure(.invalidMealTypeIdentifier("for meal  \(mealType)")))
    }

    storageRepo.getRecipeID(forDate: date, forMeal: meal, onComplete: { recipeID in

      if recipeID == "" {
        return onComplete(.failure(
          .noMealExistsForGivenIdentifier("for meal \(mealType) on \(String(describing: self.date))")))
      } else {
        return onComplete(.success(recipeID))
      }
    })
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
