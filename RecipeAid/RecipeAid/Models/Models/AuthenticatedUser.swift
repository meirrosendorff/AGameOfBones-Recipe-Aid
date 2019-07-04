//
//  User.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/07/04.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import Foundation

struct AuthenticatedUser: Codable {

  let userID: String
  let token: String

  init(userID: String, token: String) {

    self.userID = userID
    self.token = token
  }
}
