//
//  weekListTableViewCell.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/05/23.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import UIKit

class weekListTableViewCell: UITableViewCell {

  @IBOutlet weak var weekName: UILabel!

  func setName(_ name: String) -> (){
    weekName.text = name
  }
}
