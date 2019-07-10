//
//  UserServices.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/07/04.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import When

struct UserServices: UserServicesProtocol {

  var fpService: FPUserService

  init() {
    fpService = FPUserService()
  }

  func FPAttemptLogin(username: String, password: String) -> Promise<AuthenticatedUser> {

    return fpService.attemptLogin(userName: username, password: password)
  }

  func FPGetUserDetails(token: String) -> Promise<UserDetails> {

    return fpService.getUserDetails(token: token)
  }

  let baseURL: String = "https://recipeaid-server.vapor.cloud/auth/users"

  func attemptLogin(username: String,
                    password: String,
                    onComplete: @escaping (Swift.Result<AuthenticatedUser, RecipeError>) -> Void) {

    var headers: HTTPHeaders = ["Content-Type": "application/json"]

    if let authHeader = Request.authorizationHeader(user: username, password: password) {

      headers[authHeader.key] = authHeader.value
    }

    let url = baseURL + "/login"

    fetchJason(url: url, headers: headers, method: .post, onComplete: onComplete)
  }

  func setUserToLoggedIn(_ user: AuthenticatedUser) {
    UserDefaults.standard.set(user.token, forKey: UserDefaultsKeys.userToken.rawValue)
    UserDefaults.standard.set(true, forKey: UserDefaultsKeys.isLoggedIn.rawValue)
  }

  func getUserDetails(token: String, onComplete: @escaping (Swift.Result<UserDetails, RecipeError>) -> Void) {

    var headers: HTTPHeaders = ["Content-Type": "application/json"]
    headers["Authorization"] = "Bearer \(token)"

    let url = baseURL + "/details"

    fetchJason(url: url, headers: headers, method: .get, onComplete: onComplete)
  }

  func setUserDetails(details: UserDetails) {

    UserDefaults.standard.set(details.userID, forKey: UserDefaultsKeys.userID.rawValue)
    UserDefaults.standard.set(details.email, forKey: UserDefaultsKeys.userEmail.rawValue)
    UserDefaults.standard.set(details.username, forKey: UserDefaultsKeys.username.rawValue)
    UserDefaults.standard.set(details.isAdmin, forKey: UserDefaultsKeys.isAdmin.rawValue)
  }

  func logUserOut() {

    UserDefaults.standard.set("", forKey: UserDefaultsKeys.userID.rawValue)
    UserDefaults.standard.set("", forKey: UserDefaultsKeys.userEmail.rawValue)
    UserDefaults.standard.set("", forKey: UserDefaultsKeys.username.rawValue)
    UserDefaults.standard.set("", forKey: UserDefaultsKeys.userToken.rawValue)
    UserDefaults.standard.set(false, forKey: UserDefaultsKeys.isAdmin.rawValue)
    UserDefaults.standard.set(false, forKey: UserDefaultsKeys.isLoggedIn.rawValue)
  }

  func getUserDetails() -> UserDetails? {

    guard let username = UserDefaults.standard.object(forKey: UserDefaultsKeys.username.rawValue) as? String else {
      return nil
    }

    guard let userID = UserDefaults.standard.object(forKey: UserDefaultsKeys.userID.rawValue) as? String else {
      return nil
    }

    guard let email = UserDefaults.standard.object(forKey: UserDefaultsKeys.userEmail.rawValue) as? String else {
      return nil
    }

   let isAdmin = UserDefaults.standard.bool(forKey: UserDefaultsKeys.isAdmin.rawValue)

    return UserDetails(username: username, userID: userID, email: email, isAdmin: isAdmin)
  }

  func getProfilePic(onComplete: @escaping (Swift.Result<Data, RecipeError>) -> Void) {

    guard let token = UserDefaults.standard.object(forKey: UserDefaultsKeys.userToken.rawValue) as? String else {
      return onComplete(.failure(.emptyContentError("")))
    }

    var headers: HTTPHeaders = ["Content-Type": "application/json"]
    headers["Authorization"] = "Bearer \(token)"

    let url = baseURL + "/profilePic"

    Alamofire.request(url, method: .get, headers: headers).responseString { response in

      if let imageString = response.value, let data = Data(base64Encoded: imageString) {
        return onComplete(.success(data))
      } else {
        return onComplete(.failure(.unableToFetchImage(String(describing: response.error))))
      }
    }
  }

  private func fetchJason<T: Decodable>(url: String,
                                        headers: HTTPHeaders,
                                        method: HTTPMethod,
                                        onComplete: @escaping (Swift.Result<T, RecipeError>) -> Void) {

    Alamofire.request(url, method: method, headers: headers).responseJSON { response in

      switch response.result {

      case .failure(let error):
        return onComplete(
          .failure(RecipeError.invalidCredentialsError(String(describing: error))))

      case .success:
        let decoder = JSONDecoder()
        guard let data = response.data else {
          return onComplete(.failure(.invalidJsonObjectRecieved("No Data")))
        }

        if let decoded = try? decoder.decode(T.self, from: data) {
          return onComplete(.success(decoded))
        } else {
          return onComplete(.failure(.invalidJsonObjectRecieved("Unable to Convert to User")))
        }
      }
    }
  }
}
