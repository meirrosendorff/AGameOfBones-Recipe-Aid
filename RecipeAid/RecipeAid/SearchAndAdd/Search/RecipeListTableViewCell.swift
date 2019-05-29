//
//  RecipeListTableViewCell.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/05/17.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import UIKit

class RecipeListTableViewCell: UITableViewCell {
  @IBOutlet weak var foodImage: UIImageView!
  @IBOutlet weak var name: UILabel!
  @IBOutlet weak var servings: UILabel!
  @IBOutlet weak var source: UILabel!
  @IBOutlet weak var calories: UILabel!
  override func awakeFromNib() {
  super.awakeFromNib()
    let colors = Colors()
    let width: CGFloat = 120
    let height: CGFloat = 100
    let headingFont = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium)
    let bodyFont = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.light)
    let imageViewWidthConstraint = NSLayoutConstraint(
      item: foodImage!, attribute: .width, relatedBy: .equal, toItem: nil,
      attribute: .notAnAttribute, multiplier: 1, constant: width)
    let imageViewHeightConstraint = NSLayoutConstraint(
      item: foodImage!, attribute: .height, relatedBy: .equal, toItem: nil,
      attribute: .notAnAttribute, multiplier: 1, constant: height)
    foodImage.addConstraints([imageViewWidthConstraint, imageViewHeightConstraint])
    let black = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0).cgColor
    foodImage.layer.borderColor = black
    foodImage.layer.borderWidth = 2
    name.textColor = colors.yellow
    name.font = headingFont
    servings.textColor = colors.white
    servings.font = bodyFont
    calories.textColor = colors.white
    calories.font = bodyFont
    source.textColor = colors.white
    source.font = bodyFont
  }
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
}
