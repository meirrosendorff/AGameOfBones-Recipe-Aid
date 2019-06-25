//
//  ShoppingListViewController.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/05/22.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import UIKit

class ShoppingListViewController: UIViewController {

  var gradientLayer: GradientLayer?
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var noShoppingLabel: UILabel!
  @IBOutlet weak var ingredientsTableView: UITableView!
  var viewModel: ShoppingListViewModelProtocol!
  let formatter = Formatter()

  override func viewDidLoad() {

    super.viewDidLoad()
    viewModel = ShoppingListViewModel()
    gradientLayer = GradientLayer(view: self.view)
    gradientLayer?.addGradientToView()
    formatViews()
    self.title = "Shopping List"
    setUpScreen()
  }

  @IBAction func nextWeek(_ sender: Any) {

    viewModel.updateShoppingForNextWeek(onComplete: { viewModel in

      self.updateScreen(viewModel: viewModel)
    })
  }

  @IBAction func lastWeek(_ sender: Any) {

    viewModel.updateShoppingForLastWeek(onComplete: { viewModel in

      self.updateScreen(viewModel: viewModel)
    })
  }

  func setUpScreen() {

    viewModel.updateShopping(onComplete: { viewModel in

      self.updateScreen(viewModel: viewModel)
    })
  }

  func updateScreen(viewModel: ShoppingListViewModelProtocol) {

    dateLabel.text = viewModel.dateRangeText

    if viewModel.hasShopping {

      noShoppingLabel.isHidden = true
      self.ingredientsTableView.reloadData()
      ingredientsTableView.isHidden = false

    } else {

      noShoppingLabel.isHidden = false
      ingredientsTableView.isHidden = true
    }
  }

  func formatViews() {

    formatter.formatLabelAsMainText(dateLabel, ofSize: 17)
    formatter.formatLabelAsMainText(noShoppingLabel, ofSize: 22, ofWeight: "Bold")
  }

  override func viewWillLayoutSubviews() {

    gradientLayer?.updateBounds()
  }
}

extension ShoppingListViewController: UITableViewDelegate, UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.shoppingListSize
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    guard let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingItemProto")
      as? ShoppingListItemTableViewCell else {
        return UITableViewCell()
    }

    cell.setUp(viewModel: self.viewModel, index: indexPath.row)

    return cell
  }
}
