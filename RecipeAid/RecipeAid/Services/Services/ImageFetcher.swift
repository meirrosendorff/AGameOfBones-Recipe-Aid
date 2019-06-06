//
//  imageFetcher.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/06/05.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import Foundation

class ImageFetcher {

  func getData(from url: URL, onComplete: @escaping (Data?, URLResponse?, Error?) -> Void) {
    URLSession.shared.dataTask(with: url, completionHandler: onComplete).resume()
  }
}
