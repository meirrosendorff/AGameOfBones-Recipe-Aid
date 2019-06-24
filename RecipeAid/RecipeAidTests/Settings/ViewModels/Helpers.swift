//
//  Helpers.swift
//  RecipeAidTests
//
//  Created by Meir Rosendorff on 2019/06/24.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import Foundation
import Cuckoo

func equal(to value: [String]) -> ParameterMatcher<[String]> {
  return ParameterMatcher { tested in
    if value.count != tested.count {
      return false
    }

    for pos in 0..<value.count where value[pos] != tested[pos] {
      return false
    }
    return true
  }
}

func equal(to value: [(String, Bool)]) -> ParameterMatcher<[(String, Bool)]> {
  return ParameterMatcher { tested in
    if value.count != tested.count {
      return false
    }

    for pos in 0..<value.count where value[pos].0 != tested[pos].0 && value[pos].1 != tested[pos].1 {
      return false
    }
    return true
  }
}

func equal(to value: (Int, Int)) -> ParameterMatcher<(Int, Int)> {
  return ParameterMatcher { tested in

    return value.0 == tested.0 && value.1 == tested.1
  }
}
