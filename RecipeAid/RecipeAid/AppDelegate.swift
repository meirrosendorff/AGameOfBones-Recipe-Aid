//
//  AppDelegate.swift
//  Recipe-Aid
//
//  Created by Meir Rosendorff on 2019/05/12.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import UIKit
import Hippolyte

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(
      _ application: UIApplication,
      didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      stubNetworkCallsIfNeeded()
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state.
      //This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message)
      //or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks.
      //Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers,
      //and store enough application state information to restore your application to its
      //current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of
      //applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can
      //undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive.
      //If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate.
      //See also applicationDidEnterBackground:.
    }
}

extension AppDelegate {
  func stubNetworkCallsIfNeeded() {
    guard let networkStubs = UserDefaults.standard.string(forKey: "networkStubs") else { return }
    let stubSet = networkStubs.components(separatedBy: " ")
    if stubSet.count % 2 != 0 { return }

    for iterator in 0..<stubSet.count / 2 {

      let urlString = stubSet[2 * iterator]
      print(urlString)
      let responseFileName = stubSet[2 * iterator + 1]
      print(responseFileName)
      let bundle = Bundle(for: type(of: self))
      let path = bundle.path(forResource: responseFileName, ofType: "json")!
      guard let responseData = try? Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped) else { return }
      guard let url = URL(string: urlString) else { return }

      var stub = StubRequest(method: .GET, url: url)
      var response = StubResponse()
      response.body = responseData
      stub.response = response
      Hippolyte.shared.add(stubbedRequest: stub)
    }
    Hippolyte.shared.start()
  }
}
