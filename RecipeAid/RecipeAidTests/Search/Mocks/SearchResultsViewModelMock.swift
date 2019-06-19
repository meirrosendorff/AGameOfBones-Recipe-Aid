//
//  SearchResultsViewModelMock.swift
//  RecipeAidTests
//
//  Created by Meir Rosendorff on 2019/06/18.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import Foundation
@testable import RecipeAid

class SearchResultsViewModelMock: SearchResultsViewModel {

  init(model: SearchResultsModelProtocol, repo: EdamamRecipeAPIRepositoryProtocol) {
    super.init()
    self.model = model
    self.repo = repo
  }
}
