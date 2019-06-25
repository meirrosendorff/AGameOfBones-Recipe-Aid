//
//  DietryRestrictionsCollectionViewCell.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/05/31.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import UIKit

class DietryRestrictionsCollectionViewCell: UICollectionViewCell {

  @IBOutlet weak var blackoutView: UIView!
  @IBOutlet weak var settingLabel: UILabel!

  var formatter = Formatter()
  var index = -1
  var viewModel: SettingsViewModelProtocol!

  func setup(viewModel: SettingsViewModelProtocol, index: Int) {

    self.viewModel = viewModel
    self.index = index
    self.blackoutView.backgroundColor = UIColor.black
    self.blackoutView.accessibilityIdentifier =
      viewModel.restrictionName(at: self.index) + "-\(Identifiers.textBoxBlackout.rawValue)"
    setInitialState()
  }

  private func setInitialState() {

    settingLabel.text = viewModel.restrictionName(at: self.index)
    formatter.formatLabelAsMainText(settingLabel, ofSize: 17)

    if viewModel.restrictionIsSelected(at: index) {
      setSelectedState()
    } else {
      setUnselectedState()
    }
  }

  @IBAction func cellSelectionButton(_ sender: UIButton) {

    if viewModel.restrictionIsSelected(at: self.index) {
      setUnselectedState()
    } else {
      setSelectedState()
    }
  }

  func setSelectedState() {

    blackoutView.isHidden = true
    settingLabel.textColor = formatter.getMainTextColor()
    viewModel.selectRestriction(at: self.index)
  }

  func setUnselectedState() {

    blackoutView.isHidden = false
    settingLabel.textColor = formatter.getMainTextColor().withAlphaComponent(0.5)
    viewModel.deselectRestriction(at: self.index)
  }
}
