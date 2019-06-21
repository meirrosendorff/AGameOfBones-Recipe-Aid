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
  @IBOutlet weak var emailAddressLabel: UILabel!
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
  var viewModel: SettingsViewModelProtocol!
  var savedAlert: UIAlertController!

  override func viewDidLoad() {

    super.viewDidLoad()
    viewModel = SettingsViewModel()
    gradientLayer = GradientLayer(view: view)
    gradientLayer?.addGradientToView()
    formatViews()
    hideKeyboardWhenTappedAround()
    self.title = "Settings"
    setUserDetails()
    addUsersCurrentSettings()
    setUpSavedAlert()
  }

  private func setUpSavedAlert() {
    self.savedAlert = UIAlertController(
      title: "Saved", message: "Settings Succesfully Saved", preferredStyle: UIAlertController.Style.alert)
  }

  @objc
  private func dismissAlert() {
    self.savedAlert.dismiss(animated: true, completion: nil)
  }

  private func loadSettingsToView() {

    setUserDetails()
    addUsersCurrentSettings()
    collectionView.reloadData()
  }

  private func setUserDetails() {

    profilePicImageView.image = UIImage(named: viewModel.profilePic)
    usernameLabel.text = viewModel.userName
    emailAddressLabel.text = viewModel.emailAddress
  }

  private func addUsersCurrentSettings() {

    minCaloriesTextBox.text = viewModel.minCalories
    maxCaloriesTextBox.text = viewModel.maxCalories
    minTimeTextBox.text = viewModel.minTime
    maxTimeTextBox.text = viewModel.maxTime
    dietryRestrictionsTextBox.text = viewModel.unwantedFoods
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
    formatter.formatLabelAsSubtext(emailAddressLabel, ofSize: 17)
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

  @IBAction func saveSettings(_ sender: Any) {

    if !addSettingsToViewModel() { return }
    viewModel.save()
    loadSettingsToView()
    self.present(savedAlert, animated: true, completion: nil)
    Timer.scheduledTimer(
      timeInterval: 0.75, target: self, selector: #selector(dismissAlert), userInfo: nil, repeats: false)
  }

  private func addSettingsToViewModel() -> Bool {

    do {
      try viewModel.setCalories(min: minCaloriesTextBox.text ?? "", max: maxCaloriesTextBox.text ?? "")
    } catch {
      displayErrorAlert(error: error, forLabel: "Calories")
      return false
    }

    do {
      try viewModel.setTimes(min: minTimeTextBox.text ?? "", max: maxTimeTextBox.text ?? "")
    } catch {
      displayErrorAlert(error: error, forLabel: "Time")
      return false
    }

    viewModel.setUnwatedFoods(foods: dietryRestrictionsTextBox.text ?? "")
    return true
  }

  private func displayErrorAlert(error: Error, forLabel label: String) {

    let alert = UIAlertController(title: "Error Saving", message: "", preferredStyle: UIAlertController.Style.alert)
    switch error {
    case RecipeError.invalidNumberString:
      alert.message = "\(label) must be a number!"
    case RecipeError.minMaxError:
      alert.message = "minimum \(label) must be less than maximum"
    default:
      alert.message = "Problem saving \(label)"
    }
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
}

typealias CollectionView = UICollectionViewDelegate
  & UICollectionViewDataSource
  & UICollectionViewDelegateFlowLayout

extension SettingsViewController: CollectionView {

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

    return viewModel.numRestrictions
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

    guard let cell = collectionView.dequeueReusableCell( withReuseIdentifier: "dietryRestrictions",
      for: indexPath)
      as? DietryRestrictionsCollectionViewCell else {

      return UICollectionViewCell()
    }

    cell.setup(viewModel: viewModel, index: indexPath.row)

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
