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
  let formatter = Formatter()
  override func awakeFromNib() {
  super.awakeFromNib()
    formatViews()
  }
  func formatViews() {
    self.backgroundColor = formatter.getFillColor()
    let width: CGFloat = 120
    let height: CGFloat = 100
    let imageViewWidthConstraint = NSLayoutConstraint(
      item: foodImage!, attribute: .width, relatedBy: .equal, toItem: nil,
      attribute: .notAnAttribute, multiplier: 1, constant: width)
    let imageViewHeightConstraint = NSLayoutConstraint(
      item: foodImage!, attribute: .height, relatedBy: .equal, toItem: nil,
      attribute: .notAnAttribute, multiplier: 1, constant: height)
    foodImage.addConstraints([imageViewWidthConstraint, imageViewHeightConstraint])
    foodImage.layer.borderColor = formatter.getFillColor().cgColor
    foodImage.layer.borderWidth = 2
    formatter.formateLabelAsMainText(name, ofSize: 17, ofWeight: "Bold")
    formatter.formateLabelAsSubtext(servings, ofSize: 17)
    formatter.formateLabelAsSubtext(calories, ofSize: 17)
    formatter.formateLabelAsSubtext(source, ofSize: 17, ofWeight: "Italic")
  }
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
}
