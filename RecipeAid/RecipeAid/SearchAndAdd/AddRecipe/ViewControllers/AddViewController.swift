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
  var viewModel: AddViewModelProtocol!
  var recipe: Recipe!

  override func viewDidLoad() {

    super.viewDidLoad()
    gradientLayer = GradientLayer(view: view)
    gradientLayer?.addGradientToView()
    viewModel = AddViewModel()
    configureSegmentControll(segments: viewModel.mealTypes)
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

  @IBAction func confirmAddRecipe(_ sender: Any) {

    self.navigationController?.popViewController(animated: true)

    guard let
      mealType = mealSegmentControll.titleForSegment(at: mealSegmentControll.selectedSegmentIndex)
      else { return }

    viewModel.addMeal(recipe: recipe, mealType: mealType, date: datePicker.date)
  }

  func configureSegmentControll(segments: [String]) {

    mealSegmentControll.removeAllSegments()
    for segment in segments {
      mealSegmentControll.insertSegment(withTitle: segment, at: mealSegmentControll.numberOfSegments, animated: false)
    }

    if !segments.isEmpty {

      mealSegmentControll.selectedSegmentIndex = 0
    }
  }
}
