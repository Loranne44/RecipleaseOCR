//
//  NetworkService.swift
//  Reciplease
//
//  Created by Loranne Joncheray on 16/02/2023.
//

import Foundation
import CoreData

final class CoreDataService {
    
    // MARK: - Properties
    private let coreDataStack: CoreDataStack
    
    // MARK: - Init
    init(coreDataStack: CoreDataStack = CoreDataStack()) {
        self.coreDataStack = coreDataStack
    }
    
    
    // MARK: - Repository
    func getRecipes(callback: @escaping ([FavoriteRecipe]) -> Void) {
        // create request
        let request : NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        //excute request, get the saved data
        guard let recipes = try? coreDataStack.viewContext.fetch(request) else {
            callback([])
            return
        }
        callback(recipes)
    }
    
    func saveRecipes(label: String?,
                     image: String?,
                     ingredientLines: [String]?,
                     yield: Int?,
                     totalTime: Double?,
                     uri: String?,
                     url: String?,
                     callback :@escaping () -> Void) {
        let recipe = FavoriteRecipe(context: coreDataStack.viewContext)
        // use
        recipe.label = label
        recipe.image = image
        recipe.ingredientLines = ingredientLines
        recipe.yield =  Int64(yield ?? 0)
        recipe.totalTime = Double(totalTime ?? 0)
        recipe.uri = uri
        recipe.url = url
        do {
            try coreDataStack.viewContext.save()
            callback()
        } catch {
            print("We were unable to save \(recipe)")
        }
    }
    
    func unsaveRecipe(uri: String, callback: @escaping () -> Void) {
        let request: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        let predicate = NSPredicate(format: "uri == %@", uri)
        request.predicate = predicate
        if let recipe = try? coreDataStack.viewContext.fetch(request) {
            recipe.forEach {
                coreDataStack.viewContext.delete($0)}
        }
        coreDataStack.saveContext()
    }
    
    // isExist
    func isExist(recipeUri: String) -> Bool {
        let request : NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        request.predicate = NSPredicate(format: "uri == %@", recipeUri)
        guard let recipes = try? coreDataStack.viewContext.fetch(request)
        else {
            return false
        }
        if recipes.isEmpty {
            return false
        }
        return true
    }
}
