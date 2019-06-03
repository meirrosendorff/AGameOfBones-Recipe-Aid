//
//  IngredientsTableViewCell.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/05/29.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import UIKit

class IngredientsTableViewCell: UITableViewCell {
  @IBOutlet weak var ingredient: UILabel!
  let formatter = Formatter()
  override func awakeFromNib() {
    super.awakeFromNib()
    formatter.formateLabelAsSubtext(ingredient, ofSize: 18)
    self.backgroundColor = formatter.getFillColor()
  }
}
