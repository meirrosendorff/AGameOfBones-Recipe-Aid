//
//  LoginViewModelTests.swift
//  RecipeAidTests
//
//  Created by Meir Rosendorff on 2019/07/05.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import XCTest
import Cuckoo
import When
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
    let expectation = self.expectation(description: "Should fail")

    stub(userService) { stub in

      when(stub.FPAttemptLogin(username: username, password: password)).then({ _ in
        let promise = Promise<AuthenticatedUser>()
        promise.reject(RecipeError.emptyContentError(""))
        return promise
      })

      when(stub.logUserOut()).thenDoNothing()
    }

    sut.login(username: username, password: password, onComplete: { result in
      expectation.fulfill()
      XCTAssertFalse(result)
    })

    waitForExpectations(timeout: 1, handler: nil)
  }

  func testLoginReturnsFalseWhenFetchUserDetailsFails() {

    let username = "name"
    let password = "password"
    let token = "token"

    let authUser = AuthenticatedUser(userID: username, token: token)

    let expectation = self.expectation(description: "Should Fail")

    stub(userService) { stub in
      when(stub.FPAttemptLogin(username: username, password: password)).then({ _ in
        let promise = Promise<AuthenticatedUser>()
        promise.resolve(authUser)
        return promise
      })

      when(stub.FPGetUserDetails(token: token)).then({ _ in
        let promise = Promise<UserDetails>()
        promise.reject(RecipeError.emptyContentError(""))
        return promise
      })

      when(stub.setUserToLoggedIn(equal(to: authUser))).thenDoNothing()
      when(stub.logUserOut()).thenDoNothing()
    }

    sut.login(username: username, password: password, onComplete: { result in
      expectation.fulfill()
      XCTAssertFalse(result)
    })

    waitForExpectations(timeout: 1, handler: nil)

    verify(userService, times(1)).setUserToLoggedIn(equal(to: authUser))
    verify(userService, times(1)).logUserOut()
  }

  func testLoginSetsUserToLoggedInAndDetailsWhenSuccesful() {

    let username = "name"
    let password = "password"
    let token = "token"

    let authUser = AuthenticatedUser(userID: username, token: token)
    let userDetails = UserDetails(username: username, userID: "id", email: "email", isAdmin: true)

    let expectation = self.expectation(description: "Should Succeed")

    stub(userService) { stub in
      when(stub.FPAttemptLogin(username: username, password: password)).then({ _ in
        let promise = Promise<AuthenticatedUser>()
        promise.resolve(authUser)
        return promise
      })

      when(stub.FPGetUserDetails(token: token)).then({ _ in
        let promise = Promise<UserDetails>()
        promise.resolve(userDetails)
        return promise
      })

      when(stub.setUserToLoggedIn(equal(to: authUser))).thenDoNothing()
      when(stub.setUserDetails(details: equal(to: userDetails))).thenDoNothing()
    }

    sut.login(username: username, password: password, onComplete: { result in
      expectation.fulfill()
      XCTAssertTrue(result)
    })

    waitForExpectations(timeout: 1, handler: nil)

    verify(userService, times(1)).setUserDetails(details: equal(to: userDetails))
    verify(userService, times(1)).setUserToLoggedIn(equal(to: authUser))
    verify(userService, times(0)).logUserOut()
  }
}
