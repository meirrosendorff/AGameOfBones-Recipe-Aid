//
//  addGradientBackgroundToView.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/05/28.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//
import Foundation
import UIKit

class GradientLayer {
  let layer: CAGradientLayer
  let colors: Colors
  let view: UIView
  init(view: UIView) {
    layer = CAGradientLayer()
    colors = Colors()
    self.view = view
  }
  func addGradientToView() {
    let colors = Colors()
    layer.colors = [colors.darkGreen.cgColor, colors.lightGreen.cgColor]
    layer.frame = view.bounds
    view.layer.insertSublayer(layer, at: 0)
    view.backgroundColor = colors.lightGreen
  }
  func updateBounds() {
    layer.frame = view.frame
  }
}
