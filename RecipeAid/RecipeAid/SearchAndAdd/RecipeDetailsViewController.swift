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
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    self.title = "Details"
    let barButtonArray: [UIBarButtonItem] = [addButton]
    navigationItem.setRightBarButtonItems(barButtonArray, animated: false)
  }
}
