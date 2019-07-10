//
//  FPUserService.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/07/10.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import Foundation
import When

class FPUserService {

  func attemptLogin(userName: String, password: String) -> Promise<AuthenticatedUser> {

    let auth = combine(userName, password, with: basicAuth)
    let request = chain(auth, to: loginRequest)
    let networking = chain(request, to: URLSession.shared.request)

    return chain(networking, to: decoder)()
  }

  func getUserDetails(token: String) -> Promise<UserDetails> {

    let auth = combine(token, with: bearerAuth)
    let request = chain(auth, to: detailsRequest)
    let networking = chain(request, to: URLSession.shared.request)

    return chain(networking, to: decoder)()
  }

  private func detailsRequest(_ auth: [String: String]) -> URLRequest {

    let urlString = "https://recipeaid-server.vapor.cloud/auth/users/details"
    let method = "GET"

    return buildURLRequest(urlString: urlString, method: method, headers: auth)
  }

  private func bearerAuth(_ token: String) -> [String: String] {

    return ["Authorization": "Bearer \(token)"]
  }

  private func basicAuth(_ username: String, _ password: String) -> [String: String] {

    let loginString = String(format: "%@:%@", username, password)
    let loginData = loginString.data(using: String.Encoding.utf8)!
    let base64LoginString = loginData.base64EncodedString()

    return ["Authorization": "Basic \(base64LoginString)"]
  }

  private func loginRequest(_ auth: [String: String]) -> URLRequest {

    let urlString = "https://recipeaid-server.vapor.cloud/auth/users/login"
    let method = "POST"

    return buildURLRequest(urlString: urlString, method: method, headers: auth)
  }

  private func buildURLRequest(urlString: String, method: String, headers: [String: String]) -> URLRequest {

    guard let url = URL(string: urlString) else {
      preconditionFailure("Invalid Static URL for \(urlString)")
    }

    var request = URLRequest(url: url)
    request.httpMethod = method

    for (key, val) in headers {
      request.setValue(val, forHTTPHeaderField: key)
    }

    return request
  }

  private func decoder<T: Decodable>(data: Promise<Data>) -> Promise<T> {

    return data.then({ data -> Promise<T> in

      let promise = Promise<T>()

      if let result = try? JSONDecoder().decode(T.self, from: data) {

        promise.resolve(result)
      } else {
        promise.reject(RecipeError.invalidJsonObjectRecieved(""))
      }

      return promise
    })
  }

  private func combine<A, B>(_ val: A,
                             with closure: @escaping (A) -> B) -> () -> B {
    return { closure(val) }
  }

  private func combine<A, B>(_ first: A,
                             _ second: A,
                             with closure: @escaping (A, A) -> B) -> () -> B {
    return { closure(first, second) }
  }

  private func chain<A, B>( _ inner: @escaping () -> A,
                            to outer: @escaping (A) -> B) -> () -> (B) {
    return { outer(inner()) }
  }
}
