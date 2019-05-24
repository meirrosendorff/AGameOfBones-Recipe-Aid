//
//  shoppingListItemTableViewCell.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/05/22.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import UIKit

class ShoppingListItemTableViewCell: UITableViewCell {
  @IBOutlet weak var boughtCheckBox: UIButton!
  @IBOutlet weak var item: UILabel!
  private var alreadyBought = false
  @IBAction func itemBought(_ sender: UIButton) {
    if alreadyBought {
      boughtCheckBox.backgroundColor = UIColor.black
      alreadyBought = false
    } else {
      boughtCheckBox.backgroundColor = UIColor.white
      alreadyBought = true
    }
  }
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    // Configure the view for the selected state
  }
  func setState(_ bought: Bool) {
    if bought {
      boughtCheckBox.backgroundColor = UIColor.white
      alreadyBought = true
    } else {
      boughtCheckBox.backgroundColor = UIColor.black
      alreadyBought = false
    }
  }
}
