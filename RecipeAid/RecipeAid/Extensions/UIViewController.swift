//
//  UIViewController.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/06/21.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import UIKit

extension UIViewController {
  func hideKeyboardWhenTappedAround() {
    let tapGesture = UITapGestureRecognizer(target: self,
                                            action: #selector(hideKeyboard))
    view.addGestureRecognizer(tapGesture)
  }

  @objc func hideKeyboard() {
    view.endEditing(true)
  }

  func userIsLoggedIn() {

    let appDelegate = UIApplication.shared.delegate
    if let root = self.storyboard?.instantiateViewController(withIdentifier: "startController") {
      appDelegate?.window??.rootViewController = root
    }
  }

  func userIsLoggedOut() {

    let appDelegate = UIApplication.shared.delegate
    if let root = self.storyboard?.instantiateViewController(withIdentifier: "loginController") {
      appDelegate?.window??.rootViewController = root
    }
  }
}
