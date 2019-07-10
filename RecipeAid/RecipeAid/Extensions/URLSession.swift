//
//  URLSession.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/07/10.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import Foundation
import Alamofire
import When

extension URLSession {
  func request(_ request: URLRequest) -> Promise<Data> {
    let promise = Promise<Data>()

    let task = dataTask(with: request) { data, _, error in

      if let error = error {
        promise.reject(error)
      } else {
        promise.resolve(data ?? Data())
      }
    }

    task.resume()

    return promise
  }
}
