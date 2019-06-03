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
  @IBOutlet weak var profilePicImageView: UIImageView!
  var gradientLayer: GradientLayer?
  let colors = Colors()
  let settings = [("High Protein", false), ("Low Fat", false),
                  ("Low Carb", false), ("Low Suger", false),
                  ("Vegetarian", false), ("Vegan", false),
                  ("Alcohol Free", false), ("Nut Free", false)]
  override func viewDidLoad() {
    super.viewDidLoad()
    gradientLayer = GradientLayer(view: view)
    gradientLayer?.addGradientToView()
    self.title = "Settings"
  }
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    if let gradientLayer = gradientLayer {
      gradientLayer.updateBounds()
    }
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
    cell.layer.borderColor = colors.navy.cgColor
    cell.layer.borderWidth = 2
    return cell
  }
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: (view.frame.width - 20) / 2, height: 60)
  }
  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    self.collectionView.collectionViewLayout.invalidateLayout()
  }
}
