// swiftlint:disable force_cast force_try weak_delegate
//
//  CoreDataStack.swift
//  Reciplease
//
//  Created by Fabrice Etiennette on 09/03/2020.
//  Copyright © 2020 Fabrice Etiennette. All rights reserved.
//

import UIKit
import CoreData

enum CoreDataError: Error {
    case noRecipes
}

class CoreDataStack {

    private let appDelegate = UIApplication.shared.delegate as! AppDelegate

    private var context: NSManagedObjectContext {
        return appDelegate.persistentContainer.viewContext
    }

    private func save() {
        appDelegate.saveContext()
    }

    func saveRecipe(_ recipeSelected: SelectedRecipe?) {
        guard let recipe = recipeSelected else { return }
        let newRecipe = MyRecipe(context: context)
        newRecipe.title = recipe.title
        newRecipe.source = recipe.source
        newRecipe.time = recipe.time
        newRecipe.url = recipe.url
        newRecipe.ingredientLines = recipe.ingredientLines as? [String]
        newRecipe.ingredientsChoose = recipe.ingredientChoose
        newRecipe.yield = recipe.yield
        if let recipeImage = recipe.image?.pngData() {
           newRecipe.image = recipeImage
        }
        if let calories = recipe.calories {
            newRecipe.calories = calories
        }
        save()
    }

    func getRecipes(callback: @escaping (Result <[MyRecipe], Error>) -> Void) {
        let request: NSFetchRequest<MyRecipe> = MyRecipe.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        do {

            let recipes = try context.fetch(request)
            callback(.success(recipes))

            if recipes.isEmpty {
                callback(.failure(CoreDataError.noRecipes))
            }
        } catch {
            callback(.failure(error))
            print(error.localizedDescription)
        }
    }

    func isEntityAttributeExist(_ title: String) -> Bool {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MyRecipe")
        request.predicate = NSPredicate(format: "title = %@", title)
        let result = try! context.fetch(request)
        return result.count > 0
    }

    func deleteOneRecipe(_ recipe: SelectedRecipe) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MyRecipe")
        guard let title = recipe.title else { return }
        request.predicate = NSPredicate(format: "title = %@", title)
        do {
            let results = try context.fetch(request) as! [NSManagedObject]
            for entity in results {
                context.delete(entity)
                do {
                    try context.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
