//
//  DayMealPlanTableViewCell.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/05/23.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import UIKit

class DayMealPlanTableViewCell: UITableViewCell {
  
  struct meal{

    var meal: UILabel
    var mealLink: String

    init(_ meal: UILabel, _ mealLink: String){
      self.meal = meal
      self.mealLink = mealLink
    }

  }
  
  @IBOutlet weak var breakfastDescriptionLabel: UILabel!
  
  @IBOutlet weak var lunchDescriptionLabel: UILabel!
  
  @IBOutlet weak var dinnerDescriptionLabel: UILabel!
  
  @IBAction func linkClicked(_ sender: UIButton) {
    
    if sender.tag == 1{//breakfast
      
    }else if sender.tag == 2{//lunch
      
    }else if sender.tag == 3{//dinner
      
    }
    
  }
  
  
  var meals = [String : meal]()
  
  @IBOutlet weak var dayName: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
      
        self.dayName.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
  func SetMeals(breakfast: (description: String, link: String), lunch: (description: String, link: String), dinner: (description: String, link: String)) -> (){

    breakfastDescriptionLabel.text = breakfast.description
    lunchDescriptionLabel.text = lunch.description
    dinnerDescriptionLabel.text = dinner.description
    
    meals["breakfast"] = meal(breakfastDescriptionLabel, breakfast.link)
    meals["lunch"] = meal(lunchDescriptionLabel, lunch.link)
    meals["dinner"] = meal(dinnerDescriptionLabel, dinner.link)

  }
  
  func setName(_ dayName: String){
    self.dayName.text = dayName
  }

}
