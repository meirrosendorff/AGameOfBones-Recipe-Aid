//
//  AddViewController.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/05/20.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
  @IBOutlet weak var mealSegmentControll: UISegmentedControl!
  @IBOutlet weak var selectMealLabel: UILabel!
  @IBOutlet weak var selectDateLabel: UILabel!
  @IBOutlet weak var confirmButton: UIButton!
  @IBOutlet weak var datePicker: UIDatePicker!
  var gradientLayer: GradientLayer?
  let formatter = Formatter()
  override func viewDidLoad() {
    super.viewDidLoad()
    gradientLayer = GradientLayer(view: view)
    gradientLayer?.addGradientToView()
    title = "Add Recipe"
    formatViews()
  }
  func formatViews() {
    formatter.formatLabelAsMainText(selectDateLabel, ofSize: 20)
    formatter.formatLabelAsMainText(selectMealLabel, ofSize: 20)
    formatter.formatButton(confirmButton, ofSize: 22)
    formatter.formatSegmentControll(mealSegmentControll)
    formatter.formatDatePicker(datePicker)
  }
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    if let gradientLayer = gradientLayer {
      gradientLayer.updateBounds()
    }
  }
}

extension AddViewController: UIPickerViewDelegate, UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return 0
  }
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return ""
  }
}
