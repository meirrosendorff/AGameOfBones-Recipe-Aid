//
//  UserDetails.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/07/04.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import Foundation

struct UserDetails: Codable {

  let username: String
  let userID: String
  let email: String
  let isAdmin: Bool

  private enum CodingKeys: String, CodingKey {
    case username, userID = "id", email, isAdmin
  }
}
