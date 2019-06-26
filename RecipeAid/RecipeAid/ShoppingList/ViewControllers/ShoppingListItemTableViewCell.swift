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
    item.text = viewModel.getItemName(at: self.index)
    setState()
    addAccessibilityIdentifiers()
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

  private func addAccessibilityIdentifiers() {

    blackoutForeground.accessibilityIdentifier =
      "\(Identifiers.textBoxBlackout.rawValue)-\(viewModel.itemIsBaught(at: self.index))"
  }

  override func awakeFromNib() {

    super.awakeFromNib()
    formatter.formatLabelAsMainText(item, ofSize: 17)
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
