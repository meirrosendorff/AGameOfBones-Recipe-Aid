//
//  ShoppingListViewController.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/05/22.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import UIKit

class ShoppingListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  var gradientLayer: GradientLayer?
  @IBOutlet weak var noShoppingLabel: UILabel!
  struct ShoppingItem {
    var item: String
    var isBought: Bool
    init(_ isBought: Bool, _ item: String) {
      self.isBought = isBought
      self.item = item
    }
  }
  var shoppingList: [ShoppingItem] = []
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return shoppingList.count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingItemProto")
      as? ShoppingListItemTableViewCell else {
      return UITableViewCell()
    }
    cell.item.text = shoppingList[indexPath.row].item
    cell.setState(shoppingList[indexPath.row].isBought)
    return cell
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    gradientLayer = GradientLayer(view: self.view)
    gradientLayer?.addGradientToView()
    self.title = "Shopping List"
    shoppingList = [ShoppingItem(false, "Lettuce"),
                    ShoppingItem(true, "Tomatos"),
                    ShoppingItem(false, "Beef"),
                    ShoppingItem(false, "Beans"),
                    ShoppingItem(false, "Milk"),
                    ShoppingItem(false, "Cheese")]
    if shoppingList.isEmpty {
      noShoppingLabel.isHidden = false
    } else {
      noShoppingLabel.isHidden = true
    }
  }
  override func viewWillLayoutSubviews() {
    gradientLayer?.updateBounds()
  }
}
