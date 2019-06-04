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
}
