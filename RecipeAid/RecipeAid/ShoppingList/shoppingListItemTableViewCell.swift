//
//  shoppingListItemTableViewCell.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/05/22.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import UIKit



class shoppingListItemTableViewCell: UITableViewCell {

  @IBOutlet weak var boughtCheckBox: UIButton!
  
  @IBOutlet weak var Item: UILabel!
  
  private var alreadyBought = false
  
  @IBAction func itemBought(_ sender: UIButton) {
    
    if alreadyBought {
      boughtCheckBox.backgroundColor = UIColor.black
      alreadyBought = false
    }else{
      boughtCheckBox.backgroundColor = UIColor.clear
      alreadyBought = true
    }
    
  }
  
  override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
  func SetState(_ bought: Bool) -> (){
    
    if bought {
      boughtCheckBox.backgroundColor = UIColor.clear
      alreadyBought = true
    }else{
      boughtCheckBox.backgroundColor = UIColor.black
      alreadyBought = false
    }
    
  }

}
