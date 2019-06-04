//
//  shoppingListItemTableViewCell.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/05/22.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import UIKit

class ShoppingListItemTableViewCell: UITableViewCell {
  @IBOutlet weak var blackoutForeground: UIView!
  @IBOutlet weak var item: UILabel!
  private var alreadyBought = false
  let formatter = Formatter()
  @IBAction func itemBought(_ sender: UIButton) {
    if alreadyBought {
      blackoutForeground.backgroundColor = UIColor.black
      item.textColor = formatter.getMainTextColor()
      alreadyBought = false
    } else {
      blackoutForeground.backgroundColor = UIColor.clear
      item.textColor = formatter.getMainTextColor().withAlphaComponent(0.5)
      alreadyBought = true
    }
  }
  override func awakeFromNib() {
    super.awakeFromNib()
    formatter.formatLabelAsMainText(item, ofSize: 20)
    self.backgroundColor = formatter.getFillColor()
  }
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    // Configure the view for the selected state
  }
  func setState(_ bought: Bool) {
    if bought {
      blackoutForeground.backgroundColor = UIColor.clear
      item.textColor = formatter.getMainTextColor().withAlphaComponent(0.5)
      alreadyBought = true
    } else {
      blackoutForeground.backgroundColor = UIColor.black
      item.textColor = formatter.getMainTextColor()
      alreadyBought = false
    }
  }
}
