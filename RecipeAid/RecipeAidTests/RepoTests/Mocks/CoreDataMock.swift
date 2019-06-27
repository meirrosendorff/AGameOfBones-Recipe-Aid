//
//  CoreDataMock.swift
//  RecipeAidTests
//
//  Created by Meir Rosendorff on 2019/06/27.
//  Copyright © 2019 Meir Rosendorff. All rights reserved.
//

import Foundation
import CoreData

@testable import RecipeAid

struct RecipeTestContainer {
  var recipeId: String
  var recipeType: String
  var ingredientSet: [(String, Bool)]
}

class CoreDataMock {

  lazy var managedObjectModel: NSManagedObjectModel = {
    let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main])!
    return managedObjectModel
  }()

  lazy var mockPersistantContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "CoreDataUnitTesting", managedObjectModel: self.managedObjectModel)
    let description = NSPersistentStoreDescription()
    description.type = NSInMemoryStoreType
    description.shouldAddStoreAsynchronously = false

    container.persistentStoreDescriptions = [description]
    container.loadPersistentStores { _, _ in }
    return container
  }()

  func addMockData(mockDate: Date) {

    let context = mockPersistantContainer.viewContext

    guard let menuDescription = NSEntityDescription.entity(
      forEntityName: Entities.menuEntity.rawValue, in: context) else {
        return
    }

    guard let recipeDescription = NSEntityDescription.entity(
      forEntityName: Entities.recipeEntity.rawValue, in: context) else {
        return
    }

    guard let itemDescription = NSEntityDescription.entity(
      forEntityName: Entities.shoppingItemEntity.rawValue, in: context) else {
        return
    }

    let cal: Calendar = Calendar(identifier: .gregorian)

    for iterator in 0...7 {

      let currDate = cal.date(byAdding: .day, value: iterator, to: mockDate)

      let menu = NSManagedObject(entity: menuDescription, insertInto: context)
      let recipe = NSManagedObject(entity: recipeDescription, insertInto: context)
      let item = NSManagedObject(entity: itemDescription, insertInto: context)

      item.setValue("testItem\(iterator)", forKey: "itemName")
      item.setValue(false, forKey: "boughtStatus")
      item.setValue(recipe, forKey: "recipe")

      recipe.setValue("testID\(iterator)", forKey: "recipeID")
      recipe.setValue(MealTypes.breakfast.storageKey(), forKey: "recipeType")
      recipe.mutableSetValue(forKey: "shoppingItems").add(item)
      recipe.setValue(menu, forKey: "menu")

      menu.setValue(currDate, forKey: "date")
      menu.mutableSetValue(forKey: "recipes").add(recipe)
    }

    try? context.save()
  }

  func checkRecipesEqual(_ toCheck: RecipeTestContainer, _ against: Recipe) -> Bool {

    if toCheck.recipeId != against.uri {
      print("\(toCheck.recipeId) != \(against.uri)")
      return false
    }

    if toCheck.ingredientSet.count != against.ingredientLines.count {
      print("\(toCheck.ingredientSet.count) != \(against.ingredientLines.count)")
      return false
    }

    for item in toCheck.ingredientSet {
      if !against.ingredientLines.contains(item.0) { return false }
    }

    return true
  }

  func getRecipeSetFromMenu(menuObj: NSManagedObject) -> [RecipeTestContainer] {

    let recipeSet = menuObj.mutableSetValue(forKey: "recipes")
    var toReturn = [RecipeTestContainer]()

    for obj in recipeSet {
      if let recipe = obj as? NSManagedObject,
        let recipeId = recipe.value(forKey: "recipeID") as? String,
        let type = recipe.value(forKey: "recipeType") as? String {

        let shoppingSet = recipe.mutableSetValue(forKey: "shoppingItems")
        var items = [(String, Bool)]()

        for itemObj in shoppingSet {
          if let item = itemObj as? NSManagedObject,
            let name = item.value(forKey: "itemName") as? String,
            let status = item.value(forKey: "boughtStatus") as? Bool {
            items.append((name, status))
          }
        }
        toReturn.append(RecipeTestContainer(recipeId: recipeId, recipeType: type, ingredientSet: items))
      }
    }

    return toReturn
  }

  func fetchRecordsForEntity(_ entity: String) -> [NSManagedObject] {

    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
    var result = [NSManagedObject]()

    do {

      let records = try mockPersistantContainer.viewContext.fetch(fetchRequest)

      if let records = records as? [NSManagedObject] {
        result = records
      }
    } catch {
      print("Unable to fetch managed objects for entity \(entity).")
    }
    return result
  }
}
