//
//  LoginViewModel.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/07/04.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import Foundation
import When

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

    let promise = loginService.FPAttemptLogin(username: username, password: password)

    promise
      .then({ user -> Promise<UserDetails> in

        self.loginService.setUserToLoggedIn(user)
        return self.loginService.FPGetUserDetails(token: user.token)
      })
      .done({ details in

        self.loginService.setUserDetails(details: details)
        return onComplete(true)
      })
      .fail({ error in

        self.loginService.logUserOut()
        print(String(describing: error))
        return onComplete(false)
      })
  }
}
