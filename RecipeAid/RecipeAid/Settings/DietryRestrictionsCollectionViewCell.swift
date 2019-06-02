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
  var isChosen = false
  var colors = Colors()
  
  func setup(_ name: String, _ isChosen: Bool) {
    settingLabel.text = name
    if isChosen {
      blackoutView.backgroundColor = UIColor.clear
      settingLabel.textColor = colors.yellow.withAlphaComponent(0.5)
      self.isChosen = true
    } else {
      blackoutView.backgroundColor = UIColor.black
      settingLabel.textColor = colors.yellow
      self.isChosen = false
    }
  }
  @IBAction func cellSelectionButton(_ sender: UIButton) {
    if self.isChosen {
      blackoutView.backgroundColor = UIColor.black
      settingLabel.textColor = colors.yellow
      self.isChosen = false
    } else {
      blackoutView.backgroundColor = UIColor.clear
      settingLabel.textColor = colors.yellow.withAlphaComponent(0.5)
      self.isChosen = true
    }
  }
}
