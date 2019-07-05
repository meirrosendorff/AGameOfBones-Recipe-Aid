//
//  LoginViewModel.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/07/04.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import Foundation

class LoginViewModel: LoginViewModelProtocol {

  var loginService: UserServicesProtocol

  init() {
    loginService = UserServices()
  }

  var isLoggedIn: Bool {
    return UserDefaults.standard.bool(forKey: UserDefaultsKeys.isLoggedIn.rawValue)
  }

  func login(username: String, password: String, onComplete: @escaping (Bool) -> Void) {

    if username == "" || password == "" {
      return onComplete(false)
    }

    loginService.attemptLogin(username: username, password: password, onComplete: { result in

      switch result {

      case .failure(let error):
        print(String(describing: error))
        return onComplete(false)

      case .success(let user):

        self.loginService.getUserDetails(token: user.token, onComplete: { result in

          switch result {

          case .failure(let error):
            print(String(describing: error))
            return onComplete(false)

          case .success(let details):

            self.loginService.setUserDetails(details: details)
            self.loginService.setUserToLoggedIn(user)
            return onComplete(true)
          }
        })
      }
    })
  }
}
