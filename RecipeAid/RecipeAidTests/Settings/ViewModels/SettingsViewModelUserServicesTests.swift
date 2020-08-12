//
//  SettingsViewModelUserServicesTests.swift
//  RecipeAidTests
//
//  Created by Meir Rosendorff on 2019/07/05.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import XCTest
import Cuckoo
@testable import RecipeAid

class SettingsViewModelUserServicesTests: XCTestCase {

  var repoMock: MockSettingsRepo!
  var modelMock: MockSettingsModel!
  var sut: SettingsViewModel!
  var userServicesMock: MockUserServicesProtocol!
  var userDetails = UserDetails(username: "username", userID: "id", email: "email", isAdmin: true)

  override func setUp() {
    super.setUp()

    repoMock = MockSettingsRepo()
    modelMock = MockSettingsModel()
    userServicesMock = MockUserServicesProtocol()
    sut = SettingsViewModel()
    sut.repo = repoMock
    sut.model = modelMock
    sut.userServices = userServicesMock
  }

  override func tearDown() {
    sut = nil
    repoMock = nil
    modelMock = nil
    userServicesMock = nil
    super.tearDown()
  }

  func testUsernameAndEmailCorrectlySet() {

    stub(userServicesMock) { stub in
      when(stub.getUserDetails()).thenReturn(userDetails)
    }
    stub(modelMock) { stub in
      when(stub.userName.set(userDetails.username)).thenDoNothing()
      when(stub.emailAddress.set(userDetails.email)).thenDoNothing()
    }

    sut.setProfileData()

    verify(modelMock, times(1)).userName.set(userDetails.username)
    verify(modelMock, times(1)).emailAddress.set(userDetails.email)
  }

  func testGetProfilePicTakesPicFromModelIfThereIsOne() {
    let toReturn = "aW1hZ2U="

    stub(modelMock) { stub in
      when(stub.profilePic.get).thenReturn(toReturn)
    }

    sut.getProfilePic(onComplete: { data in

      XCTAssertEqual(data?.base64EncodedString(), toReturn)
    })

    verify(self.modelMock, times(1)).profilePic.get()
  }

  func testNilReturnedWhenServiceFailsToFetchImage() {

    stub(modelMock) { stub in
      when(stub.profilePic.get).thenReturn("")
    }

    stub(userServicesMock) { stub in
      when(stub.getProfilePic(onComplete: anyClosure())).then({ onComplete in
        onComplete(.failure(RecipeError.unableToFetchImage("")))
      })
    }

    sut.getProfilePic(onComplete: { data in
      XCTAssertNil(data)
    })
  }

  func testCorrectImageReturnedAndSetInModelFromServiceWhenValidImageRecieved() {
    let toReturn = "aW1hZ2U="

    stub(modelMock) { stub in
      when(stub.profilePic.get).thenReturn("")
      when(stub.profilePic.set(toReturn)).thenDoNothing()
    }

    stub(userServicesMock) { stub in
      when(stub.getProfilePic(onComplete: anyClosure())).then({ onComplete in
        guard let data = Data(base64Encoded: toReturn) else { return }
        onComplete(.success(data))
      })
    }

    sut.getProfilePic(onComplete: { data in
      XCTAssertEqual(data?.base64EncodedString(), toReturn)
    })

    verify(modelMock, times(1)).profilePic.set(toReturn)
  }
}
