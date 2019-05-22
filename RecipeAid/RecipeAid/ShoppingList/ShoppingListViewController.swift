//
//  ShoppingListViewController.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/05/22.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import UIKit

class ShoppingListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  struct shoppingItem{
    
    var item: String
    var isBought: Bool
    
    init(_ isBought: Bool, _ item: String) {
      self.isBought = isBought
      self.item = item
    }
    
  }
  
  var shoppingList: [shoppingItem] = []
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return shoppingList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingItemProto") as! shoppingListItemTableViewCell
    
    cell.Item.text = shoppingList[indexPath.row].item
    cell.SetState(shoppingList[indexPath.row].isBought)
    
    return cell
    
  }
  

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Shopping List"
      
        shoppingList = [shoppingItem(false, "Lettuce"), shoppingItem(true, "Tomatos"), shoppingItem(false, "Beef"), shoppingItem(false, "Beans"), shoppingItem(false, "Milk"), shoppingItem(false, "Cheese")]
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
