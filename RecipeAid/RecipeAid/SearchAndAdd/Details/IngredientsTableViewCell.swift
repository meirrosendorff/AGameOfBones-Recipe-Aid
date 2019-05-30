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
  override func awakeFromNib() {
    super.awakeFromNib()
    let colors = Colors()
    ingredient.textColor = colors.white
  }
}
