//
//  IngredientTableViewCell.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/05/31.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import UIKit

class MenuIngredientsTableViewCell: UITableViewCell {
  @IBOutlet weak var ingredientLabel: UILabel!
  override func awakeFromNib() {
    super.awakeFromNib()
    let colors = Colors()
    ingredientLabel.textColor = colors.white
  }
  func setIngredient(_ name: String) {
    ingredientLabel.text = name
  }
}
