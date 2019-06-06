//
//  SettingsViewController.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/05/31.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var maxTimeTextBox: UITextField!
  @IBOutlet weak var minTimeTextBox: UITextField!
  @IBOutlet weak var maxCaloriesTextBox: UITextField!
  @IBOutlet weak var minCaloriesTextBox: UITextField!
  @IBOutlet weak var emailAdressLabel: UILabel!
  @IBOutlet weak var usernameLabel: UILabel!
  @IBOutlet weak var caloriesLabel: UILabel!
  @IBOutlet weak var caloriesColonLabel: UILabel!
  @IBOutlet weak var caloriesDashLabel: UILabel!
  @IBOutlet weak var timeLabel: UILabel!
  @IBOutlet weak var timeMinLabel: UILabel!
  @IBOutlet weak var timeColonLabel: UILabel!
  @IBOutlet weak var timeDashLabel: UILabel!
  @IBOutlet weak var profilePicImageView: UIImageView!
  @IBOutlet weak var dietryRestrictionsLabel: UILabel!
  @IBOutlet weak var dietryRestrictionsInstructionLabel: UILabel!
  @IBOutlet weak var dietryRestrictionsTextBox: UITextField!
  @IBOutlet weak var saveButton: UIButton!
  @IBOutlet weak var logoutButton: UIButton!
  var gradientLayer: GradientLayer?
  let formatter = Formatter()
  let settings = [("High Protein", false), ("Low Fat", false),
                  ("Low Carb", false), ("Low Suger", false),
                  ("Vegetarian", false), ("Vegan", false),
                  ("Alcohol Free", false), ("Nut Free", false)]
  override func viewDidLoad() {
    super.viewDidLoad()
    gradientLayer = GradientLayer(view: view)
    gradientLayer?.addGradientToView()
    formatViews()
    self.title = "Settings"
  }
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    if let gradientLayer = gradientLayer {
      gradientLayer.updateBounds()
    }
  }
  func formatViews() {
    formatter.formatLabelAsMainText(usernameLabel, ofSize: 20)
    formatter.formatLabelAsMainText(caloriesLabel, ofSize: 17)
    formatter.formatLabelAsMainText(caloriesColonLabel, ofSize: 17)
    formatter.formatLabelAsMainText(timeLabel, ofSize: 17)
    formatter.formatLabelAsMainText(timeMinLabel, ofSize: 12)
    formatter.formatLabelAsMainText(timeColonLabel, ofSize: 17)
    formatter.formatLabelAsMainText(dietryRestrictionsLabel, ofSize: 17)
    formatter.formatLabelAsMainText(dietryRestrictionsInstructionLabel, ofSize: 12)
    formatter.formatLabelAsSubtext(emailAdressLabel, ofSize: 17)
    formatter.formatTextField(maxCaloriesTextBox, ofSize: 14)
    formatter.formatTextField(minCaloriesTextBox, ofSize: 14)
    formatter.formatTextField(maxTimeTextBox, ofSize: 14)
    formatter.formatTextField(minTimeTextBox, ofSize: 14)
    formatter.formatTextField(dietryRestrictionsTextBox, ofSize: 14)
    formatter.formatButton(saveButton, ofSize: 22)
    formatter.formatButton(logoutButton, ofSize: 22)
    caloriesDashLabel.textColor = formatter.getButtonBorderColor()
    timeDashLabel.textColor = formatter.getButtonBorderColor()
  }
}

typealias CollectionView = UICollectionViewDelegate
  & UICollectionViewDataSource
  & UICollectionViewDelegateFlowLayout

extension SettingsViewController: CollectionView {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return settings.count
  }
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: "dietryRestrictions",
      for: indexPath)
      as? DietryRestrictionsCollectionViewCell else {
      return UICollectionViewCell()
    }
    let (name, isChosen) = settings[indexPath.row]
    cell.setup(name, isChosen)
    cell.layer.borderColor = formatter.getFillColor().cgColor
    cell.layer.borderWidth = 2
    cell.backgroundColor = formatter.getFillColor().withAlphaComponent(0.8)
    return cell
  }
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: (view.frame.width - 20) / 2, height: 60)
  }
  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    //Ask PJ about why the app crashes on rotation if this is not optionally accessed
    //it only crashes before the view is innialized
    self.collectionView?.collectionViewLayout.invalidateLayout()
  }
}
