//
//  SearchBarViewController.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/05/28.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import UIKit

class SearchBarViewController: UIViewController, UISearchBarDelegate {
  @IBOutlet weak var searchBar: UISearchBar!
  var gradientLayer: GradientLayer?
  override func viewDidLoad() {
    super.viewDidLoad()
    gradientLayer = GradientLayer(view: view)
    gradientLayer?.addGradientToView()
    searchBar.delegate = self
    self.title = "Recipe Aid"
  }
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    if let gradientLayer = gradientLayer {
      gradientLayer.updateBounds()
    }
  }
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    view.endEditing(true)
    performSegue(withIdentifier: "goToSearchResults", sender: self)
  }
}
