//
//  FormatterProtocal.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/06/03.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import UIKit

protocol FormatterProtocal {
  func formateLabelAsMainText(_ label: UILabel, ofSize: CGFloat, ofWeight: String)
  func formateLabelAsSubtext(_ label: UILabel, ofSize: CGFloat, ofWeight: String)
  func formatButton(_ button: UIButton, ofSize: CGFloat)
  func formatTextField(_ textBox: UITextField, ofSize: CGFloat)
  func formatSegmentControll(_ segementControll: UISegmentedControl)
  func formatDatePicker(_ picker: UIDatePicker)
  func getButtonBorderColor() -> UIColor
  func getFillColor() -> UIColor
  func getMainTextColor() -> UIColor
  func getSubtextColor() -> UIColor
  func getFont(ofSize: CGFloat, ofWeight: String) -> UIFont?
}
