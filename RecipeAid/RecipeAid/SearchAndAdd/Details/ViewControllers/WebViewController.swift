//
//  webViewController.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/05/30.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

  @IBOutlet var refresh: UIBarButtonItem!
  @IBOutlet weak var spinner: UIActivityIndicatorView!
  @IBOutlet weak var webView: WKWebView!
  var sourceURL: String!
  override func viewDidLoad() {

    super.viewDidLoad()
    webView.navigationDelegate = self
    var url = URL(string: sourceURL)!

    if CommandLine.arguments.contains("-testing") {
      let bundle = Bundle(for: type(of: self))
      url = bundle.url(forResource: sourceURL, withExtension: "html")!
    }

    webView.load(URLRequest(url: url))
    refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
    let barButtonArray: [UIBarButtonItem] = [refresh]
    navigationItem.setRightBarButtonItems(barButtonArray, animated: false)
  }
}

extension WebViewController: WKNavigationDelegate {

  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {

    spinner.stopAnimating()
    title = webView.title
  }

  func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {

    spinner.startAnimating()
    title = ""
  }

  func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {

    spinner.stopAnimating()
  }
}
