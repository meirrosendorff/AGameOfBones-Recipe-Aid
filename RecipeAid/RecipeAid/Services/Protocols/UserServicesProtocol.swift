//
//  UserServicesProtocol.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/07/04.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import Foundation

protocol UserServicesProtocol {
  func attemptLogin(username: String, password: String,
                    onComplete: @escaping (Result<AuthenticatedUser, RecipeError>) -> Void)
  func getUserDetails(token: String, onComplete: @escaping (Result<UserDetails, RecipeError>) -> Void)
  func logUserOut()
  func setUserToLoggedIn(_ user: AuthenticatedUser)
  func setUserDetails(details: UserDetails)
  func getUserDetails() -> UserDetails?
  func getProfilePic(onComplete: @escaping (Result<Data, RecipeError>) -> Void)
}
