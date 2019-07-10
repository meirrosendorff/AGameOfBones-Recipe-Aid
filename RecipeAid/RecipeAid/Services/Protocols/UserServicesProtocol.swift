//
//  UserServicesProtocol.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/07/04.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import Foundation
import When

protocol UserServicesProtocol {
  func attemptLogin(username: String, password: String,
                    onComplete: @escaping (Swift.Result<AuthenticatedUser, RecipeError>) -> Void)
  func getUserDetails(token: String, onComplete: @escaping (Swift.Result<UserDetails, RecipeError>) -> Void)
  func logUserOut()
  func setUserToLoggedIn(_ user: AuthenticatedUser)
  func setUserDetails(details: UserDetails)
  func getUserDetails() -> UserDetails?
  func getProfilePic(onComplete: @escaping (Swift.Result<Data, RecipeError>) -> Void)
  func FPAttemptLogin(username: String, password: String) -> Promise<AuthenticatedUser>
  func FPGetUserDetails(token: String) -> Promise<UserDetails>
}
