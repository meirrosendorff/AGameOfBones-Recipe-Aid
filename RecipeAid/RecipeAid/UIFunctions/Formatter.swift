//
//  Formatter.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/06/03.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//
import UIKit

class Formatter: FormatterProtocal {
  private let colors: Colors
  private let mainTextColor: UIColor
  private let subtextColor: UIColor
  private let buttonFillColor: UIColor
  private let buttonTextColor: UIColor
  private let buttonBorderColor: UIColor
  private let buttonFontWeight: String
  private let textFieldFillColor: UIColor
  private let textFieldTextColor: UIColor
  private let textFieldBorderColor: UIColor
  private let segmentControllTextWeight: String
  private let segmentControllTextSize: CGFloat
  private let pickerCornerRadius: CGFloat
  private let containerFillColor: UIColor
  private let borderWeight: CGFloat
  private let buttonCornerRadius: CGFloat
  private let textFieldCornerRadius: CGFloat
  private let textFont: String
  init() {
    colors = Colors()
    mainTextColor = colors.yellow
    subtextColor = colors.white
    buttonFillColor = colors.white
    buttonTextColor = colors.navy
    buttonBorderColor = colors.navy
    buttonFontWeight = "-Bold"
    buttonCornerRadius = 18
    textFieldBorderColor = colors.navy
    textFieldFillColor = colors.white
    textFieldTextColor = colors.navy
    segmentControllTextWeight = "Medium"
    segmentControllTextSize = 17
    pickerCornerRadius = 20
    containerFillColor = colors.navy
    borderWeight = 1.5
    textFieldCornerRadius = 10
    textFont = "HelveticaNeue"
  }
  func formateLabelAsMainText(_ label: UILabel, ofSize: CGFloat, ofWeight: String = "") {
    label.textColor = mainTextColor
    label.font = self.getFont(ofSize: ofSize, ofWeight: ofWeight)
  }
  func formateLabelAsSubtext(_ label: UILabel, ofSize: CGFloat, ofWeight: String = "") {
    label.textColor = subtextColor
    label.font = self.getFont(ofSize: ofSize, ofWeight: ofWeight)
  }
  func formatButton(_ button: UIButton, ofSize: CGFloat) {
    button.backgroundColor = buttonFillColor
    button.layer.borderWidth = borderWeight
    button.layer.cornerRadius = buttonCornerRadius
    button.layer.masksToBounds = true
    button.layer.borderColor = buttonBorderColor.cgColor
    button.setTitleColor(buttonTextColor, for: .normal)
    button.titleLabel?.font = UIFont(name: textFont + buttonFontWeight, size: ofSize)
  }
  func formatTextField(_ textBox: UITextField, ofSize: CGFloat) {
    textBox.textColor = textFieldTextColor
    textBox.layer.cornerRadius = textFieldCornerRadius
    textBox.layer.borderColor = textFieldBorderColor.cgColor
    textBox.layer.borderWidth = borderWeight
    textBox.layer.masksToBounds = true
    textBox.backgroundColor = textFieldFillColor
    textBox.font = UIFont(name: textFont, size: ofSize)
  }
  func formatSegmentControll(_ segementControll: UISegmentedControl) {
    let font = self.getFont(ofSize: segmentControllTextSize, ofWeight: segmentControllTextWeight)
    let selectedAtributes = [NSAttributedString.Key.foregroundColor: mainTextColor,
                             NSAttributedString.Key.font: font]
    segementControll.setTitleTextAttributes(
      selectedAtributes as [NSAttributedString.Key: Any], for: .selected)
    let unselectedAtributes = [NSAttributedString.Key.foregroundColor: subtextColor,
                               NSAttributedString.Key.font: font]
    segementControll.setTitleTextAttributes(
      unselectedAtributes as [NSAttributedString.Key: Any], for: .normal)
    segementControll.tintColor = containerFillColor
  }
  func formatDatePicker(_ picker: UIDatePicker) {
    picker.layer.cornerRadius = pickerCornerRadius
    picker.layer.masksToBounds = true
    picker.setValue(subtextColor, forKeyPath: "textColor")
    picker.backgroundColor = containerFillColor
  }
  func getButtonBorderColor() -> UIColor {
    return buttonBorderColor
  }
  func getFillColor() -> UIColor {
    return containerFillColor
  }
  func getMainTextColor() -> UIColor {
    return mainTextColor
  }
  func getSubtextColor() -> UIColor {
    return subtextColor
  }
  func getFont(ofSize: CGFloat, ofWeight: String) -> UIFont? {
    var weight = ""
    if ofWeight != "" {
      weight = "-\(ofWeight)"
    }
    return UIFont(name: textFont + weight, size: ofSize)
  }
}
