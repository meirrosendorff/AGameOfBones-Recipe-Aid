//
//  InterfaceController.swift
//  RecipeAidWatch Extension
//
//  Created by Meir Rosendorff on 2019/07/11.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import WatchKit
import WatchConnectivity
import Foundation

class InterfaceController: WKInterfaceController {

  @IBOutlet weak var nextMeal: WKInterfaceLabel!
  @IBOutlet weak var recipeName: WKInterfaceLabel!
  @IBOutlet weak var recipePIC: WKInterfaceImage!

  var mealSummary: MealSummaryModel? {
    didSet {
      guard let summary = mealSummary else { return }
      nextMeal.setText(summary.mealType)
      recipeName.setText(summary.foodName)
      recipePIC.setImage(UIImage(data: summary.mealPic))
    }
  }

  override func awake(withContext context: Any?) {
    super.awake(withContext: context)
  }

  func reloadData() {

    let slot = getCurrentTimeSlot()
    if slot < 0 {
      recipeName.setText("Error Loading Meal")
      return
    }

    let mealType = MealTypes.allCases[slot].description()
    if WCSession.isSupported() {

      let session = WCSession.default
      session.sendMessage(["meal": mealType], replyHandler: { response in

        if response.isEmpty {
          self.mealSummary = MealSummaryModel(mealPic: Data(),
                                              foodName: "No Meal Chosen",
                                              mealType: mealType)
          return
        }

        guard let meal = response["meal"] as? Data else { return }

        let decoder = JSONDecoder()
        guard let mealSummary = try? decoder.decode(MealSummaryModel.self, from: meal) else { return }

        self.mealSummary = mealSummary
      }, errorHandler: { error in
        print("Error Recieved when fetching meal from phone with error: \(error)")
      })
    }
  }

  func getCurrentTimeSlot() -> Int {

    let hoursInDay = 24.0

    let hour = Calendar.current.component(.hour, from: Date())

    let dayFraction = Double(hour)/hoursInDay

    let numSectors = MealTypes.allCases.count

    for sector in 0..<numSectors {

      let upper = Double(sector + 1)/Double(numSectors)
      let lower = Double(sector)/Double(numSectors)
      if  lower <= dayFraction && dayFraction < upper {
        return sector
      }
    }
    return -1
  }

  override func willActivate() {
    setupSession()
    super.willActivate()
  }

  override func didDeactivate() {
    // This method is called when watch view controller is no longer visible
    super.didDeactivate()
  }
}

extension InterfaceController: WCSessionDelegate {
  func session(_ session: WCSession,
               activationDidCompleteWith activationState: WCSessionActivationState,
               error: Error?) {
    reloadData()
  }

  func setupSession() {
    if WCSession.isSupported() {
      let session = WCSession.default
      session.delegate = self
      session.activate()
    }
  }
}
