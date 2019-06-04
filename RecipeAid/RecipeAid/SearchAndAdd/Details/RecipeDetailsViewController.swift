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
  @IBOutlet weak var recipeNameLabel: UILabel!
  @IBOutlet weak var servingsLabel: UILabel!
  @IBOutlet weak var caloriesLabel: UILabel!
  @IBOutlet weak var ingredientsTableView: UIView!
  @IBOutlet weak var ingredientsLabel: UILabel!
  @IBOutlet weak var seeFullInstructionsButton: UIButton!
  @IBOutlet weak var recipeNameBackdrop: UIView!
  let formatter = Formatter()
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
    formatViews()
  }
  func formatViews() {
    ingredientsTableView.backgroundColor = formatter.getFillColor()
    recipeNameBackdrop.backgroundColor = formatter.getFillColor()
    formatter.formatLabelAsMainText(recipeNameLabel, ofSize: 25, ofWeight: "Bold")
    formatter.formatLabelAsMainText(ingredientsLabel, ofSize: 20, ofWeight: "Bold")
    formatter.formatLabelAsSubtext(servingsLabel, ofSize: 18)
    formatter.formatLabelAsSubtext(caloriesLabel, ofSize: 18)
    formatter.formatButton(seeFullInstructionsButton, ofSize: 22)
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
