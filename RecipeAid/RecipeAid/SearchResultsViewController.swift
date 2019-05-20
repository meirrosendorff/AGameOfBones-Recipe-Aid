//
//  ViewController.swift
//  Recipe-Aid
//
//  Created by Meir Rosendorff on 2019/05/12.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import UIKit

class SearchResultsViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{

  struct MyData {
    var name: String
    var source: String
    var num: Int
    var picture: UIImage
    var calories: Int
  }
  
  var tableData: [MyData] = []
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
      
      tableData = [
        MyData(name: "Recipe Name", source: "Food Chanel", num: 4, picture: UIImage(named: "background")!, calories: 600),
        MyData(name: "Recipe Name", source: "Food Chanel", num: 4, picture: UIImage(named: "background")!, calories: 600)
      ]
      
      self.title = "Search"
    }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tableData.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cell = tableView.dequeueReusableCell(withIdentifier: "protoCell") as! RecipeListTableViewCell
    
    cell.name.text = tableData[indexPath.row].name
  
    cell.source.text = tableData[indexPath.row].source
  
    cell.foodImage.image = tableData[indexPath.row].picture

    cell.servings.text = "Servings: " + String(tableData[indexPath.row].num)
    
    cell.calories.text = "Calories: " + String(tableData[indexPath.row].calories)
    
    return cell
  }
  


}

