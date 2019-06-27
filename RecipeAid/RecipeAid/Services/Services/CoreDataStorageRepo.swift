//
//  CoreDataStorageRepo.swift
//  RecipeAid
//
//  Created by Meir Rosendorff on 2019/06/26.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataStorageRepo: PersistantStorageRepoProtocol {

  var persistentContainer: NSPersistentContainer!
  var managedObjectContext: NSManagedObjectContext! { return persistentContainer.viewContext }
  var managedContextSet: Bool

  init() {

    persistentContainer = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer

    if persistentContainer != nil {
      managedContextSet = true
    } else {
      managedContextSet = true
    }
  }

  func saveMeal(withRecipe: Recipe, forDate: Date, forMeal: MealTypes) {

    if !managedContextSet { return }

    guard let date = formatDate(date: forDate) else { return }

    guard let recipe = createRecordForEntity(Entities.recipeEntity.rawValue) as? RecipeEntity else { return }

    recipe.recipeID = withRecipe.uri
    recipe.recipeType = forMeal.storageKey()

    for ingredientName in withRecipe.ingredientLines {
      guard let item = createRecordForEntity(Entities.shoppingItemEntity.rawValue)
        as? ShoppingItemEntity else { continue }
      item.itemName = ingredientName
      item.boughtStatus = false
      recipe.addToShoppingItems(item)
    }

    if let menu = fetchMenu(forDate: date) {

      if let recipeSet = menu.recipes {
        for currRecipe in recipeSet {
          if let curr = currRecipe as? RecipeEntity, curr.recipeType == forMeal.storageKey() {
            managedObjectContext.delete(curr)
          }
        }
      }

      menu.addToRecipes(recipe)

    } else if let menu = createRecordForEntity(Entities.menuEntity.rawValue) as? MenuEntity {

      menu.date = date
      menu.addToRecipes(recipe)

    } else { return }

    save()
  }

  func getRecipeID(forDate date: Date, forMeal meal: MealTypes, onComplete: @escaping (String) -> Void) {

    if CommandLine.arguments.contains("-testing") {
      onComplete(returnTestRecipeID(date: date, meal: meal))
      return
    }

    guard let formattedDate = formatDate(date: date) else { return onComplete("") }

    let menu = fetchMenu(forDate: formattedDate)

    if let recipeSet = menu?.recipes {
      for recipe in recipeSet {
        if let curr = recipe as? RecipeEntity, curr.recipeType == meal.storageKey() {
          return onComplete(curr.recipeID ?? "")
        }
      }
    }

    onComplete("")
  }

  func getShoppingItems(forDate date: Date, forDays: Int, onComplete: @escaping ([ShoppingItem]) -> Void) {

    var shoppingList = [ShoppingItem]()
    let gregorian = Calendar(identifier: .gregorian)

    for daysAhead in 0..<forDays {

      if let date = gregorian.date(byAdding: .day, value: daysAhead, to: date) {

        guard let menu = fetchMenu(forDate: date) else { continue }
        guard let recipeSet = menu.recipes else { continue }

        for recipe in recipeSet {
          if let curr = recipe as? RecipeEntity {
            shoppingList += getShoppingItems(from: curr)
          }
        }
      }
    }

    return onComplete(shoppingList)
  }

  func updateShoppingItem(_ item: ShoppingItem) {

    if !managedContextSet { return }

    guard let uri = URL(string: item.itemID) else { return }

    guard let objectId = managedObjectContext.persistentStoreCoordinator?.managedObjectID(
      forURIRepresentation: uri)
      else {
        return
    }

    guard let shoppingItem = try? managedObjectContext.existingObject(with: objectId)
      as? ShoppingItemEntity else { return }

    shoppingItem.boughtStatus = item.isBought

    save()
  }

  private func getShoppingItems(from recipe: RecipeEntity) -> [ShoppingItem] {

    guard let itemSet = recipe.shoppingItems else { return [] }

    var ingredientNameSet = [ShoppingItem]()

    for item in itemSet {
      guard let shoppingItem = item as? ShoppingItemEntity else { continue }
      guard let itemName = shoppingItem.itemName else { continue }
      ingredientNameSet.append(ShoppingItem(
        itemID: shoppingItem.objectID.uriRepresentation().absoluteString,
        itemName: itemName,
        isBought: shoppingItem.boughtStatus))
    }

    return ingredientNameSet
  }

  private func save() {

    if !managedContextSet { return }

    do {
      try managedObjectContext.save()
    } catch {
      print("Unable to save")
    }
  }

  private func fetchMenu(forDate date: Date) -> MenuEntity? {

    guard let menuSet = fetchRecordsForEntity(Entities.menuEntity.rawValue) as? [MenuEntity] else { return nil }

    let filteredMenu = menuSet.filter { (menu) -> Bool in
      if let dateAttempt = menu.date {
        return dateAttempt == date
      } else {
        return false
      }
    }

    if filteredMenu.count > 0 {

      return filteredMenu[0]

    } else {
      return nil
    }
  }

  private func formatDate(date: Date) -> Date? {

    let cal: Calendar = Calendar(identifier: .gregorian)
    let date = cal.date(bySettingHour: 0, minute: 0, second: 0, of: date)

    return date
  }

  private func createRecordForEntity(_ entity: String) -> NSManagedObject? {

    if !managedContextSet { return nil }

    var result: NSManagedObject?

    let entityDescription = NSEntityDescription.entity(forEntityName: entity, in: managedObjectContext)

    if let entityDescription = entityDescription {

      result = NSManagedObject(entity: entityDescription, insertInto: managedObjectContext)
    }

    return result
  }

  private func fetchRecordsForEntity(_ entity: String) -> [NSManagedObject] {

    if !managedContextSet { return [] }

    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)

    var result = [NSManagedObject]()

    do {
      // Execute Fetch Request
      let records = try managedObjectContext.fetch(fetchRequest)

      if let records = records as? [NSManagedObject] {
        result = records
      }

    } catch {
      print("Unable to fetch managed objects for entity \(entity).")
    }

    return result
  }

  private func returnTestRecipeID(date: Date, meal: MealTypes) -> String {

    guard let cleanDate = formatDate(date: date) else { return "" }

    let cal: Calendar = Calendar(identifier: .gregorian)
    var components = DateComponents()
    components.year = 2019
    components.month = 6
    components.day = 15
    components.calendar = cal
    components.hour = 0
    components.minute = 0
    components.second = 0

    let today = formatDate(date: cal.date(from: components) ?? Date()) ?? Date()
    let yesterday = formatDate(date: cal.date(byAdding: .day, value: -1, to: today) ?? Date()) ?? Date()
    let tomorrow = formatDate(date: cal.date(byAdding: .day, value: 1, to: today) ?? Date()) ?? Date()
    let breakfast = "http://www.edamam.com/ontologies/edamam.owl#recipe_7a844b79a5df3f11e822cc229bfb3981"
    let lunch = "http://www.edamam.com/ontologies/edamam.owl#recipe_e9c30bda6b789283d22cff594d17ff73"
    let dinner = "http://www.edamam.com/ontologies/edamam.owl#recipe_b373d8987afb5808439ff243c16ccb63"
    let dates = [
      yesterday.timeIntervalSince1970: [
        MealTypes.breakfast: breakfast,
        MealTypes.lunch: lunch,
        MealTypes.dinner: ""
      ],
      today.timeIntervalSince1970: [
        MealTypes.breakfast: "",
        MealTypes.lunch: lunch,
        MealTypes.dinner: dinner
      ],
      tomorrow.timeIntervalSince1970: [
        MealTypes.breakfast: breakfast,
        MealTypes.lunch: "",
        MealTypes.dinner: lunch
      ]
    ]

    if let recipeID = dates[cleanDate.timeIntervalSince1970]?[meal], recipeID != "" {
      return recipeID
    } else {
      return ""
    }
  }
}
