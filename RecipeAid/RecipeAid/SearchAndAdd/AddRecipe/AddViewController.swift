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
  @IBOutlet weak var confirmButton: UIButton!
  var gradientLayer: GradientLayer?
  let colors = Colors()
  override func viewDidLoad() {
    super.viewDidLoad()
    gradientLayer = GradientLayer(view: view)
    gradientLayer?.addGradientToView()
    title = "Add Recipe"
    setUpSegmentControll()
    confirmButton.layer.borderColor = colors.navy.cgColor
    confirmButton.layer.borderWidth = 2
  }
  func setUpSegmentControll() {
    let selectedAtributes = [NSAttributedString.Key.foregroundColor: colors.yellow,
                             NSAttributedString.Key.font: UIFont.systemFont(
                              ofSize: 17, weight: .medium)]
    mealSegmentControll.setTitleTextAttributes(selectedAtributes, for: .selected)
    let unselectedAtributes = [NSAttributedString.Key.foregroundColor: colors.white,
                             NSAttributedString.Key.font: UIFont.systemFont(
                              ofSize: 17, weight: .regular)]
    mealSegmentControll.setTitleTextAttributes(unselectedAtributes, for: .normal)
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
