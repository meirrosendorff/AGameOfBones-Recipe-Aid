//
//  Matchables.swift
//  RecipeAidTests
//
//  Created by Meir Rosendorff on 2019/06/26.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import Foundation
import Cuckoo

@testable import RecipeAid

func equal(to value: Date) -> ParameterMatcher<Date> {
  return ParameterMatcher { tested in

    let formatter = DateFormatter()
    formatter.dateFormat = "dd/MM/yyyy"

    let left = formatter.string(from: value)
    let right = formatter.string(from: tested)

    return left == right
  }
}

func equal(to value: ShoppingItem) -> ParameterMatcher<ShoppingItem> {
    return ParameterMatcher { tested in

      return value.itemName == tested.itemName
    }
}

func equal(to value: MealTypes) -> ParameterMatcher<MealTypes> {
  return ParameterMatcher { tested in
    return value.description() == tested.description()
  }
}

func equal(to value: AuthenticatedUser) -> ParameterMatcher<AuthenticatedUser> {
  return ParameterMatcher { tested in
    return value.token == tested.token && value.userID == tested.userID
  }
}

func equal(to value: UserDetails) -> ParameterMatcher<UserDetails> {
  return ParameterMatcher { tested in
    return value.isAdmin == tested.isAdmin &&
            value.email == tested.email &&
            value.userID == tested.userID &&
            value.username == tested.username
  }
}
