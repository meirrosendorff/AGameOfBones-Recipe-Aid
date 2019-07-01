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
  var ingredients = [String]()
  @IBOutlet weak var recipeImage: UIImageView!
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
  var date = Date()
  var menueDisplayViewModel: MenueDisplayViewModel?

  override func viewDidLoad() {

    super.viewDidLoad()
    gradientLayer = GradientLayer(view: view)
    gradientLayer?.addGradientToView()
    menueDisplayViewModel = MenueDisplayViewModel(forDate: date)
    self.title = menueDisplayViewModel?.dateString
    configureSegmentControll(segments: menueDisplayViewModel?.getMealOptions() ?? [])
    formatViews()
    setupPageFromSelectedSegment()
    addAccessibilityIdentifiers()
  }

  override func viewWillLayoutSubviews() {

    super.viewWillLayoutSubviews()
    if let gradientLayer = gradientLayer {
      gradientLayer.updateBounds()
    }

  }

  func addAccessibilityIdentifiers() {
    recipeNameLabel.accessibilityIdentifier = Identifiers.recipeName.rawValue
    recipeDetailsContainer.accessibilityIdentifier = Identifiers.recipeDetailsContainer.rawValue
    ingredientsLabel.accessibilityIdentifier = Identifiers.ingredientsLabel.rawValue
    ingredientsTableView.accessibilityIdentifier = Identifiers.ingredientTableView.rawValue
    noMealChosenLabel.accessibilityIdentifier = Identifiers.noRecipeLabel.rawValue
    fullInstructionsButton.accessibilityIdentifier = Identifiers.fullInstructionsLabel.rawValue
  }

  func configureSegmentControll(segments: [String]) {

    mealSegmentControll.removeAllSegments()
    for segment in segments {
      mealSegmentControll.insertSegment(withTitle: segment, at: mealSegmentControll.numberOfSegments, animated: false)
    }

    if !segments.isEmpty {

      mealSegmentControll.selectedSegmentIndex = 0
    }

  }

  @IBAction func mealChosen(_ sender: UISegmentedControl) {

    setupPageFromSelectedSegment()

  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    if segue.destination is WebViewController {

      let next = segue.destination as? WebViewController
      next?.sourceURL = menueDisplayViewModel?.recipeSource
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

  func setupPageFromSelectedSegment() {

    recipeDetailsContainer.isHidden = true
    noMealChosenLabel.isHidden = true
    recipeImage.image = nil

    currMealSegment = mealSegmentControll.titleForSegment(at: mealSegmentControll.selectedSegmentIndex) ?? ""

    menueDisplayViewModel?.updateMeal(meal: currMealSegment, onComplete: { viewModel, hasMeal in

      if hasMeal {

        self.recipeDetailsContainer.isHidden = false
        self.recipeNameLabel.text = viewModel.recipeName
        self.ingredients = viewModel.ingredients
        self.ingredientsTableView.reloadData()

        self.menueDisplayViewModel?.getImageFromURL(viewModel.recipeImageURL, onComplete: { data in

          DispatchQueue.main.async {
            self.recipeImage.image = UIImage(data: data)
          }
        })

      } else {

        self.noMealChosenLabel.text = "No meal chosen for \(self.currMealSegment)"
        self.noMealChosenLabel.isHidden = false
      }
    })
  }

}

extension MenuDisplayViewController: TableViewInheritance {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

    return ingredients.count

  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    guard let cell = tableView.dequeueReusableCell(

      withIdentifier: "menuIngredientCell") as? MenuIngredientsTableViewCell else {
      return UITableViewCell()
    }

    cell.setIngredient(ingredients[indexPath.row])

    return cell
  }

}
