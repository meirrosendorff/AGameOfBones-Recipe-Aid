//
//  RecipeListTableViewCell.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/05/17.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import UIKit

class RecipeListTableViewCell: UITableViewCell {

  
  @IBOutlet weak var foodImage: UIImageView!
  
  @IBOutlet weak var name: UILabel!
  
  @IBOutlet weak var servings: UILabel!
  
  @IBOutlet weak var source: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
