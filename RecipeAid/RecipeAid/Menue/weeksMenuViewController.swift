//
//  weeksMenueViewController.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/05/23.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import UIKit

extension weeksMenuViewController: UITableViewDelegate, UITableViewDataSource{
}

extension weeksMenuViewController: UISearchResultsUpdating{
}

class weeksMenuViewController: UIViewController {
  
  
  @IBOutlet weak var tableOnSCreen: UITableView!
  
  let weeks = ["week 1", "week 2", "Cape Town Holiday Week 1", "Cape Town Holiday if i start to like my family"]
  
  var filteredTableData = [String]()
  
  var resultSearchController = UISearchController()
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    if  (resultSearchController.isActive) {
      return filteredTableData.count
    } else {
      return weeks.count
    }
    
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "weekName") as! weekListTableViewCell
    
    if (resultSearchController.isActive) {
      
      cell.setName(filteredTableData[indexPath.row])
      return cell
    }
    else {
      cell.setName(weeks[indexPath.row])
      return cell
    }
    
  }
  
  func updateSearchResults(for searchController: UISearchController) {
    
    filteredTableData.removeAll(keepingCapacity: false)
    
    let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
    let array = (weeks as NSArray).filtered(using: searchPredicate)
    filteredTableData = array as! [String]
    
    tableOnSCreen.reloadData()
  }
  
  override func viewDidLoad() {
      super.viewDidLoad()

      self.title = "Menu"
    
    resultSearchController = ({
      let controller = UISearchController(searchResultsController: nil)
      controller.searchResultsUpdater = self
      controller.dimsBackgroundDuringPresentation = false
      controller.searchBar.sizeToFit()
      
      tableOnSCreen.tableHeaderView = controller.searchBar
      return controller
    })()
    
    tableOnSCreen.reloadData()
  }


}
