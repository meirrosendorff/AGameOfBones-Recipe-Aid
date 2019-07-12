//
//  AppDelegate.swift
//  Recipe-Aid
//
//  Created by Meir Rosendorff on 2019/05/12.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import UIKit
import CoreData
import Hippolyte
import Firebase
import WatchConnectivity

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    FirebaseApp.configure()
    stubNetworkCallsIfNeeded()
    setUpUserDefaults()
    resetUserSettingsIfNeeded()
    logUserOutIfNeeded()

    if WCSession.isSupported() {
      let session = WCSession.default
      session.delegate = self
      session.activate()
    }
    return true
  }

  func applicationWillTerminate(_ application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate.
    //See also applicationDidEnterBackground:.
    self.saveContext()
  }

  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "RecipeAid")
    container.loadPersistentStores(completionHandler: { (_, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }()

  func saveContext () {
    let context = persistentContainer.viewContext
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }

}

extension AppDelegate {

  func stubNetworkCallsIfNeeded() {
    guard let networkStubs = UserDefaults.standard.string(forKey: "networkStubs") else { return }
    let stubSet = networkStubs.components(separatedBy: " ")
    if stubSet.count % 3 != 0 { return }

    for iterator in 0..<stubSet.count / 3 {

      let urlString = stubSet[3 * iterator]
      let responseFileName = stubSet[3 * iterator + 1]
      let fileType = stubSet[3 * iterator + 2]

      let bundle = Bundle(for: type(of: self))
      let path = bundle.path(forResource: responseFileName, ofType: fileType)!
      guard let responseData = try? Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped) else { return }
      guard let url = URL(string: urlString) else { return }

      for method in [HTTPMethod.GET, HTTPMethod.POST] {

        var stub = StubRequest(method: method, url: url)
        var response = StubResponse()
        response.body = responseData
        stub.response = response
        Hippolyte.shared.add(stubbedRequest: stub)
      }
    }
    Hippolyte.shared.start()
  }

  func setUpUserDefaults() {

    if UserDefaults.standard.bool(forKey: UserDefaultsKeys.alreadySetUp.rawValue) {
      return
    }

    resetUserSettings()
  }

  func resetUserSettingsIfNeeded() {

    guard CommandLine.arguments.contains("-resetUserSetting") else { return }

    resetUserSettings()
  }

  func resetUserSettings() {

    UserDefaults.standard.set(true, forKey: UserDefaultsKeys.alreadySetUp.rawValue)

    let restrictionOptions = DietaryRestrictions.allCases.reduce(into: [String: Bool](), {
      $0[$1.webKey()] = false
    })

    UserDefaults.standard.set(restrictionOptions, forKey: UserDefaultsKeys.dietryRestrictionsDict.rawValue)
    UserDefaults.standard.set(0, forKey: UserDefaultsKeys.minCalories.rawValue)
    UserDefaults.standard.set(0, forKey: UserDefaultsKeys.maxCalories.rawValue)
    UserDefaults.standard.set(0, forKey: UserDefaultsKeys.minTime.rawValue)
    UserDefaults.standard.set(0, forKey: UserDefaultsKeys.maxTime.rawValue)
    UserDefaults.standard.set([String](), forKey: UserDefaultsKeys.unwantedFoodsArray.rawValue)
  }

  func logUserOutIfNeeded() {
    if CommandLine.arguments.contains("-logout") {
      let service = UserServices()
      service.logUserOut()
    }
  }
}

extension AppDelegate: WCSessionDelegate {
  func session(_ session: WCSession,
               activationDidCompleteWith activationState: WCSessionActivationState,
               error: Error?) {}

  func sessionDidBecomeInactive(_ session: WCSession) {}

  func sessionDidDeactivate(_ session: WCSession) {}

  func session(_ session: WCSession,
               didReceiveMessage message: [String: Any],
               replyHandler: @escaping ([String: Any]) -> Void) {

    guard let mealType = message["meal"] as? String else {
      return replyHandler([:])
    }

    let viewModel = MenueDisplayViewModel(forDate: Date())

    viewModel.updateMeal(meal: mealType) { viewModel, hasMeal in
      if hasMeal {

        viewModel.getImageFromURL(viewModel.recipeImageURL, onComplete: { data in

          let meal = MealSummaryModel(mealPic: data,
                                      foodName: viewModel.recipeName,
                                      mealType: mealType)
          let encoder = JSONEncoder()
          guard let mealString = try? encoder.encode(meal) else { return replyHandler([:]) }
          replyHandler(["meal": mealString])
        })
      } else {
        replyHandler([:])
      }
    }
  }
}
