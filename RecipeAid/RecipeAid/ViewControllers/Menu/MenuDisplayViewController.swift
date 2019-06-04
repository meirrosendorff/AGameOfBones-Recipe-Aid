//
//  MenueDisplayViewController.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/05/23.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import UIKit

typealias TableViewInheritance = UITableViewDelegate & UITableViewDataSource

class MenuDisplayViewController: UIViewController {
  var currMealSegment = ""
  let ingredients = ["Breakfast": [
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
    ],
    "Lunch": [],
    "Dinner": []]
  @IBOutlet weak var mealSegmentControll: UISegmentedControl!
  @IBOutlet weak var recipeDetailsContainer: UIView!
  @IBOutlet weak var fullInstructionsButton: UIButton!
  @IBOutlet weak var ingredientsLabel: UILabel!
  @IBOutlet weak var recipeNameLabel: UILabel!
  @IBOutlet weak var ingredientsTableView: UITableView!
  @IBOutlet weak var noMealChosenLabel: UILabel!
  @IBOutlet weak var ingredientContainerView: UIView!
  var gradientLayer: GradientLayer?
  let formatter = Formatter()
  override func viewDidLoad() {
    super.viewDidLoad()
    gradientLayer = GradientLayer(view: view)
    gradientLayer?.addGradientToView()
    self.title = "18 Sept 2018"
    formatViews()
    currMealSegment = mealSegmentControll.titleForSegment(at: mealSegmentControll.selectedSegmentIndex) ?? ""
    if ingredients[currMealSegment]?.count == 0 {
      recipeDetailsContainer.isHidden = true
      noMealChosenLabel.isHidden = false
      noMealChosenLabel.text = "No Meal Chose for \(currMealSegment)"
    } else {
      recipeDetailsContainer.isHidden = false
      recipeNameLabel.text = "Recipe Name for \(currMealSegment)"
      noMealChosenLabel.isHidden = true
    }
  }
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    if let gradientLayer = gradientLayer {
      gradientLayer.updateBounds()
    }
  }
  @IBAction func mealChosen(_ sender: UISegmentedControl) {
    currMealSegment = mealSegmentControll.titleForSegment(at: mealSegmentControll.selectedSegmentIndex) ?? ""
    if ingredients[currMealSegment]?.count == 0 {
      recipeDetailsContainer.isHidden = true
      noMealChosenLabel.isHidden = false
      noMealChosenLabel.text = "No Meal Chose for \(currMealSegment)"
    } else {
      recipeDetailsContainer.isHidden = false
      recipeNameLabel.text = "Recipe Name for \(currMealSegment)"
      noMealChosenLabel.isHidden = true
      ingredientsTableView.reloadData()
    }
  }
  func formatViews() {
    formatter.formatLabelAsMainText(recipeNameLabel, ofSize: 22, ofWeight: "Bold")
    formatter.formatLabelAsMainText(ingredientsLabel, ofSize: 20, ofWeight: "Medium")
    formatter.formatButton(fullInstructionsButton, ofSize: 22)
    formatter.formatSegmentControll(mealSegmentControll)
    ingredientsTableView.backgroundColor = formatter.getFillColor()
    ingredientContainerView.backgroundColor = formatter.getFillColor()
  }
}

extension MenuDisplayViewController: TableViewInheritance {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return ingredients[currMealSegment]?.count ?? 0
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: "menuIngredientCell") as? MenuIngredientsTableViewCell else {
      return UITableViewCell()
    }
    cell.setIngredient(ingredients[currMealSegment]?[indexPath.row] ?? "")
    return cell
  }
}
