//
//  ViewController.swift
//  Recipe-Aid
//
//  Created by Meir Rosendorff on 2019/05/12.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{

  struct MyData {
    var name: String
    var source: String
    var num: Int
    var picture: UIImage
  }
  
  var tableData: [MyData] = []
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
      
      tableData = [
        MyData(name: "Recipe Name", source: "Food Chanel", num: 4, picture: UIImage(named: "background")!),
        MyData(name: "Recipe Name", source: "Food Chanel", num: 4, picture: UIImage(named: "background")!)
      ]
      
      self.title = "Search"
    }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tableData.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      // Create a new cell with the reuse identifier of our prototype cell
      // as our custom table cell class
    let cell = tableView.dequeueReusableCell(withIdentifier: "protoCell") as! RecipeListTableViewCell
      // Set the first row text label to the firstRowLabel data in our current array item
      cell.name.text = tableData[indexPath.row].name
      // Set the second row text label to the secondRowLabel data in our current array item
      cell.source.text = tableData[indexPath.row].source
    
    cell.foodImage.image = tableData[indexPath.row].picture
    
    let imageViewWidthConstraint = NSLayoutConstraint(item: cell.foodImage!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 125)
    let imageViewHeightConstraint = NSLayoutConstraint(item: cell.foodImage!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 125)
    cell.foodImage.addConstraints([imageViewWidthConstraint, imageViewHeightConstraint])
    
    cell.servings.text = String(tableData[indexPath.row].num)
      // Return our new cell for display
      return cell
  }
  


}

