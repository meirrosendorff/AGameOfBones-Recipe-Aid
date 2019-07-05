//
//  LoginViewModelTests.swift
//  RecipeAidTests
//
//  Created by Meir Rosendorff on 2019/07/05.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import XCTest
import Cuckoo
@testable import RecipeAid

class LoginViewModelTests: XCTestCase {

  var sut: LoginViewModel!
  var userService: MockUserServicesProtocol!

  override func setUp() {
    sut = LoginViewModel()
    userService = MockUserServicesProtocol()
    sut.loginService = userService
    super.setUp()
  }

  override func tearDown() {
    sut = nil
    userService = nil
    super.tearDown()
  }

  func testIsLoggedInReturnsTrueWhenUserIsLoggedIn() {

    UserDefaults.standard.set(true, forKey: UserDefaultsKeys.isLoggedIn.rawValue)

    let status = sut.isLoggedIn

    XCTAssertTrue(status)
  }

  func testLoginReturnsFalseWhenUsernameIsEmpty() {

    let expectation = self.expectation(description: "Should Fail To Login")

    sut.login(username: "", password: "password", onComplete: { result in
      expectation.fulfill()
      XCTAssertFalse(result)
    })

    waitForExpectations(timeout: 1, handler: nil)
  }

  func testLoginReturnsFalseWhenPasswordIsEmpty() {

    let expectation = self.expectation(description: "Should Fail To Login")

    sut.login(username: "username", password: "", onComplete: { result in
      expectation.fulfill()
      XCTAssertFalse(result)
    })

    waitForExpectations(timeout: 1, handler: nil)
  }

  func testLoginReturnsFalseWhenLoginFails() {

    let username = "name"
    let password = "password"

    stub(userService) { stub in
      when(stub.attemptLogin(username: username, password: password, onComplete: anyClosure()))
        .then({ _, _, onCpmplete in
        onCpmplete(.failure(RecipeError.emptyContentError("")))
      })
    }

    sut.login(username: username, password: password, onComplete: { result in
      XCTAssertFalse(result)
    })
  }

  func testLoginReturnsFalseWhenFetchUserDetailsFails() {

    let username = "name"
    let password = "password"
    let token = "token"

    stub(userService) { stub in
      when(stub.attemptLogin(username: username, password: password, onComplete: anyClosure()))
        .then({ _, _, onComplete in
          onComplete(.success(AuthenticatedUser(userID: "username", token: token)))
        })

      when(stub.getUserDetails(token: token, onComplete: anyClosure())).then({ _, onComplete in
        onComplete(.failure(RecipeError.emptyContentError("")))
      })
    }

    sut.login(username: username, password: password, onComplete: { result in
      XCTAssertFalse(result)
    })
  }

  func testLoginSetsUserToLoggedInAndDetailsWhenSuccesful() {

    let username = "name"
    let password = "password"
    let token = "token"

    let authUser = AuthenticatedUser(userID: username, token: token)
    let userDetails = UserDetails(username: username, userID: "id", email: "email", isAdmin: true)

    stub(userService) { stub in
      when(stub.attemptLogin(username: username, password: password, onComplete: anyClosure()))
        .then({ _, _, onComplete in
          onComplete(.success(authUser))
        })

      when(stub.getUserDetails(token: token, onComplete: anyClosure())).then({ _, onComplete in
        onComplete(Result.success(userDetails))
      })

      when(stub.setUserToLoggedIn(equal(to: authUser))).thenDoNothing()
      when(stub.setUserDetails(details: equal(to: userDetails))).thenDoNothing()
    }

    sut.login(username: username, password: password, onComplete: { result in
      XCTAssertTrue(result)
    })

    verify(userService, times(1)).setUserDetails(details: equal(to: userDetails))
    verify(userService, times(1)).setUserToLoggedIn(equal(to: authUser))
  }
}
