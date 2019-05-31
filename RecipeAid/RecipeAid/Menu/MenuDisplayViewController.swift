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
  @IBOutlet weak var recipeNameLabel: UILabel!
  @IBOutlet weak var ingredientsTableView: UITableView!
  @IBOutlet weak var noMealChosenLabel: UILabel!
  var gradientLayer: GradientLayer?
  let colors = Colors()
  override func viewDidLoad() {
    super.viewDidLoad()
    gradientLayer = GradientLayer(view: view)
    gradientLayer?.addGradientToView()
    setUpSegmentControll()
    self.title = "18 Sept 2018"
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
  func setUpSegmentControll() {
    let selectedAtributes = [NSAttributedString.Key.foregroundColor: colors.yellow,
                             NSAttributedString.Key.font: UIFont.systemFont(
                              ofSize: 17, weight: .medium)]
    mealSegmentControll.setTitleTextAttributes(selectedAtributes, for: .selected)
    let unselectedAtributes = [NSAttributedString.Key.foregroundColor: colors.white,
                               NSAttributedString.Key.font: UIFont.systemFont(
                                ofSize: 17, weight: .regular)]
    mealSegmentControll.setTitleTextAttributes(unselectedAtributes, for: .normal)
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
