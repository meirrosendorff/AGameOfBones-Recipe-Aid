//
//  RecipeDetailsViewController.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/05/17.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import UIKit

class RecipeDetailsViewController: UIViewController {
  @IBOutlet var addButton: UIBarButtonItem!
  @IBOutlet weak var seeFullInstructionsButton: UIButton!
  var colors = Colors()
  let ingredients = [
    "Ingredient",
    "Another ingredient",
    "An ingredient with a stupidly long name that would be multiline",
    "Salt",
    "Pepper",
    "suger, cos who doesn't want suger",
    "Ingredient",
    "Another ingredient",
    "An ingredient with a stupidly long name that would be multiline",
    "Salt",
    "Pepper",
    "suger, cos who doesn't want suger",
    "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  ]
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
seeFullInstructionsButton.layer.borderWidth = 1
    self.title = "Details"
    let barButtonArray: [UIBarButtonItem] = [addButton]
    navigationItem.setRightBarButtonItems(barButtonArray, animated: false)
  }
}

extension RecipeDetailsViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return ingredients.count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell") as? IngredientsTableViewCell else {
      return UITableViewCell()
    }
    cell.ingredient.text = ingredients[indexPath.row]
    return cell
  }
}
