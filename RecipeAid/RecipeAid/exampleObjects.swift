//
//  File.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/06/05.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//
import Foundation

let cal: Calendar = Calendar(identifier: .gregorian)

let today: Date = cal.date(bySettingHour: 0, minute: 0, second: 0, of: Date()) ?? Date()
let yesterday = cal.date(byAdding: .day, value: -1, to: today) ?? Date()
let tomorrow = cal.date(byAdding: .day, value: 1, to: today) ?? Date()

//let exampleBreakfast = 

let dates = [
  yesterday.timeIntervalSince1970: [
    "Breakfast": "63ccc00c3c1051750933c9ad8fb9e987",
    "Lunch": "e9c30bda6b789283d22cff594d17ff73",
    "Dinner": ""
    ],
  today.timeIntervalSince1970: [
    "Breakfast": "",
    "Lunch": "16cf944bd8695e4d8a5075d8d977a59a",
    "Dinner": "fde77dd059e1fc6d73a2e3fcd52b1b10"
  ],
  tomorrow.timeIntervalSince1970: [
    "Breakfast": "7a844b79a5df3f11e822cc229bfb3981",
    "Lunch": "",
    "Dinner": "b373d8987afb5808439ff243c16ccb63"
  ]
]
