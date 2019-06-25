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
  let formatter = Formatter()
  var viewModel: ShoppingListViewModelProtocol!
  var index: Int!

  func setUp(viewModel: ShoppingListViewModelProtocol, index: Int) {

    self.viewModel = viewModel
    self.index = index
    setState()
  }

  @IBAction func itemBought(_ sender: UIButton) {

    if viewModel.itemIsBaught(at: self.index) {

      blackoutForeground.isHidden = false
      item.textColor = formatter.getMainTextColor()

    } else {

      blackoutForeground.isHidden = true
      item.textColor = formatter.getMainTextColor().withAlphaComponent(0.5)
    }

    viewModel.selectItem(at: self.index)
  }

  override func awakeFromNib() {

    super.awakeFromNib()
    formatter.formatLabelAsMainText(item, ofSize: 20)
    self.backgroundColor = formatter.getFillColor()
    blackoutForeground.backgroundColor = UIColor.black
  }

  func setState() {

    if viewModel.itemIsBaught(at: self.index) {

      blackoutForeground.isHidden = true
      item.textColor = formatter.getMainTextColor().withAlphaComponent(0.5)
    } else {

      blackoutForeground.isHidden = false
      item.textColor = formatter.getMainTextColor()
    }
  }
}
