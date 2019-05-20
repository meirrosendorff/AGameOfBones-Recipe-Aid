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
  
  @IBOutlet weak var calories: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    
    let imageDims: CGFloat = 125
    
    let imageViewWidthConstraint = NSLayoutConstraint(item: foodImage!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: imageDims)
    let imageViewHeightConstraint = NSLayoutConstraint(item: foodImage!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: imageDims)
    foodImage.addConstraints([imageViewWidthConstraint, imageViewHeightConstraint])
    
    foodImage.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0).cgColor
    foodImage.layer.cornerRadius = 5.0
    foodImage.layer.borderWidth = 1
    
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  
}
