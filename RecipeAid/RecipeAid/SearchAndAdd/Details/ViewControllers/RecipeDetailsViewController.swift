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
  @IBOutlet weak var backgroundImageView: UIImageView!
  var backgroundImage: UIImage!
  var viewModel: RecipeDetailsViewModelProtocol!
  let formatter = Formatter()

  override func viewDidLoad() {

    super.viewDidLoad()
    self.title = "Details"
    let barButtonArray: [UIBarButtonItem] = [addButton]
    navigationItem.setRightBarButtonItems(barButtonArray, animated: false)
    formatViews()
    setTextFromViewModel()
    addAccessibilityIdentifiers()
  }

  func setTextFromViewModel() {

    self.recipeNameLabel.text = viewModel.name
    self.servingsLabel.text = viewModel.servings
    self.caloriesLabel.text = viewModel.calories
    self.backgroundImageView.image = backgroundImage

  }

  func addAccessibilityIdentifiers() {
    recipeNameLabel.accessibilityIdentifier = Identifiers.recipeName.rawValue
    servingsLabel.accessibilityIdentifier = Identifiers.servingsLabel.rawValue
    caloriesLabel.accessibilityIdentifier = Identifiers.caloriesLabel.rawValue
    ingredientsTableView.accessibilityIdentifier = Identifiers.ingredientTableView.rawValue
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

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    if segue.destination is WebViewController {

      let next = segue.destination as? WebViewController
      next?.sourceURL = viewModel.sourceURL

    } else if segue.destination is AddViewController {

      let next = segue.destination as? AddViewController
      next?.recipe = self.viewModel.getRecipe()
    }
  }
}

extension RecipeDetailsViewController: UITableViewDelegate, UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

    return viewModel.numIngredients
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell") as? IngredientsTableViewCell else {
      return UITableViewCell()
    }
    cell.isAccessibilityElement = true
    cell.accessibilityIdentifier = Identifiers.tableViewCell.rawValue
    cell.ingredient.text = viewModel.getIngredient(at: indexPath.row)
    return cell
  }
}
