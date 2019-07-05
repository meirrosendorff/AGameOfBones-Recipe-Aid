//
//  UserServicesTests.swift
//  RecipeAidTests
//
//  Created by Meir Rosendorff on 2019/07/04.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import XCTest
import Hippolyte
@testable import RecipeAid

class UserServicesTests: XCTestCase {

  var sut: UserServicesProtocol!
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
    resestUserDetails()

    sut = UserServices()
  }

  override func tearDown() {

    Hippolyte.shared.stop()
  }

  func resestUserDetails() {

    UserDefaults.standard.set("", forKey: UserDefaultsKeys.userID.rawValue)
    UserDefaults.standard.set("", forKey: UserDefaultsKeys.userEmail.rawValue)
    UserDefaults.standard.set("", forKey: UserDefaultsKeys.username.rawValue)
    UserDefaults.standard.set(false, forKey: UserDefaultsKeys.isAdmin.rawValue)
    UserDefaults.standard.set(false, forKey: UserDefaultsKeys.isLoggedIn.rawValue)
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

    sut.attemptLogin(username: userName, password: password, onComplete: { result in

      expectation.fulfill()
      switch result {
      case .failure(let error):
        XCTFail("Should have fetched recipe: \(error)")
      case.success(let user):
        XCTAssertEqual(user.token, "token")
        XCTAssertEqual(user.userID, "userID")
      }
    })

    waitForExpectations(timeout: 1, handler: nil)
  }

  func testLoginReturnsinvalidCredentialsErrorWhenRequestFails() {

    stubLogin(forResponse: StubResponse.init(error: NSError(domain: "Error", code: 1, userInfo: nil)))

    let expectation = self.expectation(description: "Should fail login")

    sut.attemptLogin(username: userName, password: password, onComplete: { result in

      expectation.fulfill()

      switch result {
      case .success:
        XCTFail("Should Have failed")
      case .failure(let error):
        switch error {
        case .invalidCredentialsError:
          return
        default:
          XCTFail("Returned error other than emptyContentError when request failed: \(error)")
        }
      }
    })

    waitForExpectations(timeout: 1, handler: nil)
  }

  func testLoginReturnsInvalidJsonErrorWhenReturnedBadJason() {

    var response = StubResponse()
    response.body = "{\"bad\": \"jason\"}".data(using: .utf8)
    stubLogin(forResponse: response)

    let expectation = self.expectation(description: "Should fail login")

    sut.attemptLogin(username: userName, password: password, onComplete: { result in

      expectation.fulfill()

      switch result {
      case .success:
        XCTFail("Should Have failed")
      case .failure(let error):
        switch error {
        case .invalidJsonObjectRecieved:
          return
        default:
          XCTFail("Returned error other than invalidJsonObjectRecieved when request failed")
        }
      }
    })

    waitForExpectations(timeout: 1, handler: nil)
  }

  func testSetUserToLoggedInSetsValuesCorrectly() {

    let authUser = AuthenticatedUser(userID: "", token: token)

    sut.setUserToLoggedIn(authUser)

    XCTAssertEqual(token,
                   UserDefaults.standard.object(forKey: UserDefaultsKeys.userToken.rawValue) as? String ?? "")
    XCTAssertTrue(UserDefaults.standard.bool(forKey: UserDefaultsKeys.isLoggedIn.rawValue))
  }

  func testSetAndGetUserDetailsCorrectlyReturns() {

    let details = UserDetails(username: userName, userID: "id", email: "email", isAdmin: true)

    sut.setUserDetails(details: details)

    guard let detailsReturned = sut.getUserDetails() else {
      return XCTFail("failed to build user details")
    }

    XCTAssertEqual(detailsReturned.username, details.username)
    XCTAssertEqual(detailsReturned.email, details.email)
    XCTAssertEqual(detailsReturned.userID, details.userID)
    XCTAssertEqual(detailsReturned.isAdmin, details.isAdmin)
  }

  func testLogUserOutResetsAllSettings() {

    let authUser = AuthenticatedUser(userID: userName, token: token)
    let details = UserDetails(username: userName, userID: "id", email: "email", isAdmin: true)

    sut.setUserToLoggedIn(authUser)
    sut.setUserDetails(details: details)
    sut.logUserOut()

    let detailsReturned = sut.getUserDetails()
    XCTAssertEqual(detailsReturned?.email, "")
    XCTAssertEqual(detailsReturned?.username, "")
    XCTAssertEqual(detailsReturned?.userID, "")
    XCTAssertFalse(detailsReturned?.isAdmin ?? true)
    XCTAssertEqual("",
                   UserDefaults.standard.object(forKey: UserDefaultsKeys.userToken.rawValue) as? String ?? "")
    XCTAssertFalse(UserDefaults.standard.bool(forKey: UserDefaultsKeys.isLoggedIn.rawValue))
  }

  func testGetUserDetailsFromNetworkReturnsCorrectUserDetails() {

    guard let url = URL(string: "\(baseURL)/details") else { return }
    var response = StubResponse()
    response.body = userDetailsResponse.data(using: .utf8)

    stubWithToken(forResponse: response, method: .GET, url: url)

    let correctDetails = UserDetails(username: "username", userID: "id", email: "email", isAdmin: false)

    let expectation = self.expectation(description: "Should succesfully fetch user details")

    sut.getUserDetails(token: token, onComplete: { result in
      expectation.fulfill()

      switch result {
      case .failure(let error):
        XCTFail("Should have succeeded but failed with error: \(String(describing: error))")
      case .success(let returnedDetails):
        XCTAssertEqual(correctDetails.username, returnedDetails.username)
        XCTAssertEqual(correctDetails.userID, returnedDetails.userID)
        XCTAssertEqual(correctDetails.isAdmin, returnedDetails.isAdmin)
        XCTAssertEqual(correctDetails.email, returnedDetails.email)
      }
    })

    waitForExpectations(timeout: 1, handler: nil)
  }

  func testGetImageCorrectlyReturnsDataObject() {

    let imageString = "aW1hZ2U="
    guard let url = URL(string: "\(baseURL)/profilePic") else { return }
    var response = StubResponse()
    response.body = imageString.data(using: .utf8)

    stubWithToken(forResponse: response, method: .GET, url: url)

    let authUser = AuthenticatedUser(userID: userName, token: token)
    sut.setUserToLoggedIn(authUser)

    let expectation = self.expectation(description: "Should Succesfully Fetch Image")

    sut.getProfilePic { result in
      expectation.fulfill()

      switch result {
      case .failure(let error):
        XCTFail("Should Have succeded but failed with error: \(error)")
      case .success(let imageData):
        XCTAssertEqual(imageData.base64EncodedString(), imageString)
      }
    }
    waitForExpectations(timeout: 1, handler: nil)
  }

  func testGetImageReturnsunableToFetchImageWhengivenInvalidImageString() {

    let imageString = "invalid Image"
    guard let url = URL(string: "\(baseURL)/profilePic") else { return }
    var response = StubResponse()
    response.body = imageString.data(using: .utf8)

    stubWithToken(forResponse: response, method: .GET, url: url)

    let authUser = AuthenticatedUser(userID: userName, token: token)
    sut.setUserToLoggedIn(authUser)

    let expectation = self.expectation(description: "Should Succesfully Fetch Image")

    sut.getProfilePic { result in
      expectation.fulfill()

      switch result {
      case .failure(let error):
        switch error {
        case .unableToFetchImage:
          return
        default:
          XCTFail("Failed with error other than unableToFetchImage with error \(String(describing: error))")
        }
      case .success:
        XCTFail("Should Have Failed but succeded")
      }
    }
    waitForExpectations(timeout: 1, handler: nil)
  }
}
