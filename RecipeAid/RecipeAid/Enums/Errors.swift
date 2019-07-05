//
//  Errors.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/06/06.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import Foundation

enum RecipeError: Error {

  case invalidMealTypeIdentifier(String)
  case noMealExistsForGivenIdentifier(String)
  case emptyRecipeID(String)
  case urlBuildError(String)
  case errorFetchingRecipe(String)
  case invalidJsonObjectRecieved(String)
  case unableToBuildRecipeMissingValues(String)
  case emptyJSONRecieved(String)
  case unableToFetchImage(String)
  case invalidNumberString(String)
  case minMaxError(String)
  case emptyContentError(String)
  case invalidCredentialsError(String)
}
