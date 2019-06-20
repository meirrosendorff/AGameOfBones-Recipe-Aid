//
//  ViewController.swift
//  Recipe-Aid
//
//  Created by Meir Rosendorff on 2019/05/12.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import UIKit

class SearchResultsViewController: UIViewController {

  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var noResultsLabel: UILabel!
  @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
  var searchQuery: String!
  var viewModel: SearchResultsViewModelProtocol!
  var gradientLayer: GradientLayer?
  var formatter: Formatter!
  var scrollViewStretchBeforeUpdate: CGFloat!
  var busyUpdating: Bool!

  override func viewDidLoad() {

    super.viewDidLoad()
    searchBar.delegate = self
    formatter = Formatter()
    gradientLayer = GradientLayer(view: view)
    gradientLayer?.addGradientToView()
    viewModel = SearchResultsViewModel()
    scrollViewStretchBeforeUpdate = view.frame.height/5
    formatViews()
    formatForUpdating(isUpdating: true)
    self.title = self.searchQuery
    viewModel.getNextSearchResults(for: searchQuery, onComplete: { hasResults in

      self.formatForUpdating(isUpdating: false)
      self.formatWhenSearchResultsRecieved(hasResults: hasResults)
    })
    addAccessibilityIdentifiers()
  }

  override func viewWillLayoutSubviews() {

    super.viewWillLayoutSubviews()
    if let gradientLayer = gradientLayer {
      gradientLayer.updateBounds()
    }
  }

  func addAccessibilityIdentifiers() {
    searchBar.accessibilityIdentifier = Identifiers.searchBar.rawValue
    noResultsLabel.accessibilityIdentifier = Identifiers.noResultsLabel.rawValue
  }

  func formatViews() {

    formatter.formatLabelAsMainText(noResultsLabel, ofSize: 24, ofWeight: "Medium")
  }

  func formatWhenSearchResultsRecieved(hasResults: Bool) {

    self.tableView.reloadData()

    if hasResults {

      UIView.animate(withDuration: 0.2, animations: {
        self.tableView.alpha = 0.0
      })
      UIView.animate(withDuration: 0.5, animations: {
        self.tableView.alpha = 1.0
      })
      self.tableView.isHidden = false
      self.noResultsLabel.isHidden = true

    } else {

      self.tableView.isHidden = true
      self.noResultsLabel.text = self.viewModel.noResults
      self.noResultsLabel.isHidden = false
    }
  }

  func formatForUpdating(isUpdating: Bool) {

    if isUpdating {

      self.busyUpdating = true
      tableView.isUserInteractionEnabled = false
      loadingSpinner.startAnimating()

    } else {

      self.busyUpdating = false
      tableView.isUserInteractionEnabled = true
      loadingSpinner.stopAnimating()
    }
  }

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

    self.view.endEditing(true)
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    if segue.destination is RecipeDetailsViewController {

      let next = segue.destination as? RecipeDetailsViewController

      if let indexPath = self.tableView.indexPathForSelectedRow {

        next?.viewModel = self.viewModel.getViewModelForRecipe(at: indexPath.row)

        if let cell = tableView.cellForRow(at: indexPath) as? RecipeListTableViewCell {
          next?.backgroundImage = cell.foodImage.image
        }
      }
    }
  }
}

extension SearchResultsViewController: UITableViewDelegate, UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

    return viewModel.numResults
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    guard let cell = tableView.dequeueReusableCell(withIdentifier: "protoCell") as? RecipeListTableViewCell else {
      return UITableViewCell()
    }
    cell.isAccessibilityElement = true
    cell.accessibilityIdentifier = Identifiers.tableViewCell.rawValue

    cell.foodImage.image = nil
    viewModel.getResultImage(forPos: indexPath.row, onComplete: { data in
      DispatchQueue.main.async {
        cell.foodImage.image = UIImage(data: data)
      }
    })
    cell.name.text = viewModel.getResultName(forPos: indexPath.row)
    cell.source.text = viewModel.getResultSource(forPos: indexPath.row)
    cell.servings.text = viewModel.getResultServings(forPos: indexPath.row)
    cell.calories.text = viewModel.getResultCalories(forPos: indexPath.row)

    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    tableView.deselectRow(at: indexPath, animated: true)
  }

  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {

    self.view.endEditing(true)
  }

  func scrollViewDidScroll(_ scrollView: UIScrollView) {

    let contentPos = scrollView.contentSize.height - scrollView.contentOffset.y
    if Int(scrollView.frame.size.height) >= Int(contentPos + scrollViewStretchBeforeUpdate) {

      if !self.busyUpdating {

        formatForUpdating(isUpdating: true)

        viewModel.getNextSearchResults(for: self.searchQuery, onComplete: { hasResults in

          self.formatForUpdating(isUpdating: false)
          if hasResults {
            self.tableView.reloadData()
          }
        })
      }
    }
  }
}

extension SearchResultsViewController: UISearchBarDelegate {

  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

    view.endEditing(true)

    if searchBar.text != "" {

      self.title = searchBar.text
      self.searchQuery = searchBar.text
      formatForUpdating(isUpdating: true)
      viewModel.getNextSearchResults(for: searchQuery, onComplete: { hasResults in

        self.formatForUpdating(isUpdating: false)
        self.formatWhenSearchResultsRecieved(hasResults: hasResults)
      })
    }
  }
}
