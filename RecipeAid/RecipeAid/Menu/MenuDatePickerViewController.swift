//
//  weeksMenueViewController.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/05/23.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import UIKit

class MenuDatePickerViewController: UIViewController {
  @IBOutlet weak var viewMenuButton: UIButton!
  @IBOutlet weak var datePicker: UIDatePicker!
  var gradientLayer: GradientLayer?
  let colors = Colors()
  override func viewDidLoad() {
    super.viewDidLoad()
    gradientLayer = GradientLayer(view: view)
    gradientLayer?.addGradientToView()
    self.title = "Menu"
    datePicker.layer.cornerRadius = 20
    datePicker.layer.masksToBounds = true
    datePicker.setValue(colors.white, forKeyPath: "textColor")
    datePicker.backgroundColor = colors.navy
    viewMenuButton.layer.borderColor = colors.navy.cgColor
    viewMenuButton.layer.borderWidth = 2
  }
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    if let gradientLayer = gradientLayer {
      gradientLayer.updateBounds()
    }
  }
}
