//
//  weeksMenueViewController.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/05/23.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import UIKit

class MenuDatePickerViewController: UIViewController {

  @IBOutlet weak var instructionsLabel: UILabel!
  @IBOutlet weak var viewMenuButton: UIButton!
  @IBOutlet weak var datePicker: UIDatePicker!
  var gradientLayer: GradientLayer?
  let formatter = Formatter()

  override func viewDidLoad() {

    super.viewDidLoad()
    gradientLayer = GradientLayer(view: view)
    gradientLayer?.addGradientToView()
    self.title = "Menu"
    formatViews()

  }

  func formatViews() {

    formatter.formatDatePicker(datePicker)
    formatter.formatButton(viewMenuButton, ofSize: 22)
    formatter.formatLabelAsMainText(instructionsLabel, ofSize: 22)

  }

  override func viewWillLayoutSubviews() {

    super.viewWillLayoutSubviews()
    if let gradientLayer = gradientLayer {
      gradientLayer.updateBounds()
    }

  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    if segue.destination is MenuDisplayViewController {

      let next = segue.destination as? MenuDisplayViewController
      let cal: Calendar = Calendar(identifier: .gregorian)
      guard let date = cal.date(bySettingHour: 0, minute: 0, second: 0, of: datePicker.date) else { return }
      next?.date = date

    }

  }

}
