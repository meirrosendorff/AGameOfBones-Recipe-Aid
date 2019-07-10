//
//  FPUserServiceTests.swift
//  RecipeAidTests
//
//  Created by Meir Rosendorff on 2019/07/10.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import Foundation
import When
import XCTest
import Hippolyte

@testable import RecipeAid

class FPUserServiceTests: XCTestCase {

  var sut: FPUserService!
  let userName = "name"
  let password = "password"
  let token = "token"
  let baseURL = "https://recipeaid-server.vapor.cloud/auth/users"
  let loginResponse = """
    {"id":"id","userID":"userID","token":"token"}
    """
  let userDetailsResponse = """
    {"id":"id","username":"username","isAdmin":false,"email":"email"}
    """

  override func setUp() {
    super.setUp()

    sut = FPUserService()
  }

  override func tearDown() {

    Hippolyte.shared.stop()
    sut = nil
    super.tearDown()
  }

  func stubLogin(forResponse: StubResponse) {

    guard let url = URL(string: baseURL + "/login") else { return }

    var stub = StubRequest(method: .POST, url: url)
    stub.setHeader(key: "Authorization", value: "Basic bmFtZTpwYXNzd29yZA==")
    stub.response = forResponse
    Hippolyte.shared.add(stubbedRequest: stub)
    Hippolyte.shared.start()
  }

  func stubWithToken(forResponse: StubResponse, method: HTTPMethod, url: URL) {

    var stub = StubRequest(method: method, url: url)
    stub.setHeader(key: "Authorization", value: "Bearer \(token)")
    stub.response = forResponse
    Hippolyte.shared.add(stubbedRequest: stub)
    Hippolyte.shared.start()
  }

  func testLoginBuildsCorrectRequestAndResponse() {

    let expectation = self.expectation(description: "Should login")

    var response = StubResponse()
    response.body = loginResponse.data(using: .utf8)

    stubLogin(forResponse: response)

    let promise = sut.attemptLogin(userName: userName, password: password)

    promise.done({ user in
      expectation.fulfill()

      XCTAssertEqual(user.token, "token")
      XCTAssertEqual(user.userID, "userID")
    })
    .fail({ error in
      XCTFail("Failed when should have succeded with error: \(error)")
    })

    waitForExpectations(timeout: 1, handler: nil)
  }

  func testLoginReturnsErrorWhenRequestFails() {

    stubLogin(forResponse: StubResponse.init(error: NSError(domain: "Error", code: 1, userInfo: nil)))

    let expectation = self.expectation(description: "Should fail login")

    let promise = sut.attemptLogin(userName: userName, password: password)

    promise.done({ _ in XCTFail("Returned AuthenticatedUser when should have failed")})
      .fail({ _ in
        expectation.fulfill()
      })

    waitForExpectations(timeout: 1, handler: nil)
  }

  func testLoginReturnsInvalidJsonErrorWhenReturnedBadJason() {

    var response = StubResponse()
    response.body = "{\"bad\": \"json\"}".data(using: .utf8)
    stubLogin(forResponse: response)

    let expectation = self.expectation(description: "Should fail login")

    sut.attemptLogin(userName: userName, password: password)
      .done({ _ in
      XCTFail("Returned AuthenticatedUser when should have failed")
      })
      .fail({ error in

        expectation.fulfill()

        switch error {
        case RecipeError.invalidJsonObjectRecieved:
          return
        default:
          XCTFail("Returned error other than invalidJsonObjectRecieved when request failed")
        }
      })

    waitForExpectations(timeout: 1, handler: nil)
  }

  func testGetUserDetailsReturnsCorrectUserDetails() {

    guard let url = URL(string: "\(baseURL)/details") else { return }
    var response = StubResponse()
    response.body = userDetailsResponse.data(using: .utf8)

    stubWithToken(forResponse: response, method: .GET, url: url)

    let correctDetails = UserDetails(username: "username", userID: "id", email: "email", isAdmin: false)

    let expectation = self.expectation(description: "Should succesfully fetch user details")

    sut.getUserDetails(token: token)
      .done({ details in
        expectation.fulfill()
        XCTAssertEqual(correctDetails.username, details.username)
        XCTAssertEqual(correctDetails.userID, details.userID)
        XCTAssertEqual(correctDetails.isAdmin, details.isAdmin)
        XCTAssertEqual(correctDetails.email, details.email)
    })
      .fail({ error in
        XCTFail("Failed when should have succeeded with error: \(error)")
      })

    waitForExpectations(timeout: 1, handler: nil)
  }
}
