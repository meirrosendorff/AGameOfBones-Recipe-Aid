//
//  AddViewController.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/05/20.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
  
  
  @IBOutlet weak var weekPicker: UIPickerView!

  @IBOutlet weak var dayPicker: UIPickerView!
  
  
  @IBOutlet weak var mealPicker: UIPickerView!
  
  let weeks: [String] = ["Christmas Break", "Jan Week 1"]
  let days: [String] = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saterday", "Sunday"]
  let mealTypes: [String] = ["Breakfast", "Lunch", "Supper"]
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    if pickerView.tag == 1 { //Week picker
      return weeks.count
    }else if pickerView.tag == 2{ //Day picker
      return days.count
    }else if pickerView.tag == 3{ //MealType picker
      return mealTypes.count
    }
    return 0
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

    if pickerView.tag == 1 { //Week picker
      return weeks[row]
    }else if pickerView.tag == 2{ //Day Picker
      return days[row]
    }else if pickerView.tag == 3{ //Meal Picker
      return mealTypes[row]
    }
    return ""

  }

    override func viewDidLoad() {
        super.viewDidLoad()

      title = "Add"
      
      dayPicker.dataSource = self
      dayPicker.delegate = self
      
      weekPicker.dataSource = self
      weekPicker.delegate = self
      
      mealPicker.dataSource = self
      mealPicker.delegate = self
    }
    


}
