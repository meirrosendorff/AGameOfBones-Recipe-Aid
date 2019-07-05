//
//  LoginViewController.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/07/03.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

  @IBOutlet weak var usernameLabel: UILabel!
  @IBOutlet weak var passwordLabel: UILabel!
  @IBOutlet weak var passwordTextBox: UITextField!
  @IBOutlet weak var usernameTextBox: UITextField!
  @IBOutlet weak var loginButton: UIButton!
  @IBOutlet weak var invalidLogin: UILabel!
  @IBOutlet weak var loginLoading: UIActivityIndicatorView!
  var gradientLayer: GradientLayer?
  var formatter = Formatter()
  var viewModel: LoginViewModelProtocol!

  override func viewDidLoad() {
    super.viewDidLoad()

    viewModel = LoginViewModel()
    if viewModel.isLoggedIn { self.userIsLoggedIn() }
    if CommandLine.arguments.contains("-testing") { self.userIsLoggedIn() }
    gradientLayer = GradientLayer(view: view)
    gradientLayer?.addGradientToView()
    formatViews()
    self.hideKeyboardWhenTappedAround()
    addAccessibilityIdentifiers()
  }

  private func addAccessibilityIdentifiers() {

    usernameTextBox.accessibilityIdentifier = Identifiers.usernameTextField.rawValue
    passwordTextBox.accessibilityIdentifier = Identifiers.passwordTextField.rawValue
    invalidLogin.accessibilityIdentifier = Identifiers.errorLogingIn.rawValue
    loginButton.accessibilityIdentifier = Identifiers.login.rawValue
  }
  override func viewWillLayoutSubviews() {

    super.viewWillLayoutSubviews()
    if let gradientLayer = gradientLayer {
      gradientLayer.updateBounds()
    }
  }

  func formatViews() {
    formatter.formatLabelAsMainText(usernameLabel, ofSize: 20)
    formatter.formatLabelAsMainText(passwordLabel, ofSize: 20)
    formatter.formatTextField(passwordTextBox, ofSize: 16)
    passwordTextBox.isSecureTextEntry = true
    formatter.formatTextField(usernameTextBox, ofSize: 16)
    formatter.formatButton(loginButton, ofSize: 22)
    formatter.formatLabelAsMainText(invalidLogin, ofSize: 14)
    invalidLogin.isHidden = true
  }

  func setInvalidResponse(isInvalid: Bool) {
    invalidLogin.isHidden = !isInvalid
  }

  @IBAction func loginPressed(_ sender: Any) {

    self.setInvalidResponse(isInvalid: false)
    loginLoading.startAnimating()

    let username = usernameTextBox.text ?? ""
    let password = passwordTextBox.text ?? ""

    viewModel.login(username: username, password: password, onComplete: { isSuccessful in

      self.loginLoading.stopAnimating()
      if isSuccessful {
        self.userIsLoggedIn()
      } else {
        self.setInvalidResponse(isInvalid: true)
      }
    })
  }
}
