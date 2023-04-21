//
//  CoreDataTest.swift
//  RecipleaseTests
//
//  Created by Loranne Joncheray on 23/03/2023.
//
@testable import Reciplease
import XCTest
import CoreData

class CoreDataTest: XCTestCase {
    
    var coreDataStack: MockCoreDataStack!
    var coreDataService: CoreDataService!
    
    let recipeUriTesting = "http://www.edamam.com/ontologies/edamam.owl#recipe_2fb391cceeec3d82920a2035f1849d72"
    
    override func setUp() {
        super.setUp()
        coreDataStack = MockCoreDataStack()
        coreDataService = CoreDataService(coreDataStack: coreDataStack)
    }
    
    override func tearDown() {
        super.tearDown()
        coreDataStack = nil
        coreDataService = nil
    }
    
    /// Test to verify that a recipe is added to the favorites and that it exists in the favorites
    func  testWhenRecipeAddedToFavoritesAndSave() {
        let expectation = XCTestExpectation(description: #function)
        
        coreDataService.saveRecipes(label: "Apple", image: "", ingredientLines: [], yield: 3, totalTime: 0, uri: recipeUriTesting, url: "") {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.02)
        XCTAssertTrue(coreDataService.isExist(recipeUri: recipeUriTesting))
    }
    
    /// Test to verify that a recipe is added to the favorites and then removed from the list
    func  testWhenDeleteRecipe() {
        let expectation = XCTestExpectation(description: #function)
        
        coreDataService.saveRecipes(label: "Apple", image: "", ingredientLines: [], yield: 3, totalTime: 0, uri: recipeUriTesting, url: "") {
            expectation.fulfill()
        }
        XCTAssertTrue(coreDataService.isExist(recipeUri: recipeUriTesting))
        
        coreDataService.unsaveRecipe(uri: recipeUriTesting) {}
        XCTAssertFalse(coreDataService.isExist(recipeUri: recipeUriTesting))
        
        wait(for: [expectation], timeout: 0.02)
    }
    
    /// Test to check the number of recipes added in favorites and that the recipes are displayed in the right order
    func  testWhenGetRecipes() {
        let expectation = XCTestExpectation(description: #function)
        var favoriteRecipe: [FavoriteRecipe] = []
        
        coreDataService.saveRecipes(label: "Apple", image: "", ingredientLines: [], yield: 3, totalTime: 0, uri: recipeUriTesting, url: "") {}
        coreDataService.saveRecipes(label: "Lemon", image: "", ingredientLines: [], yield: 3, totalTime: 0, uri: "", url: "") {}
        coreDataService.saveRecipes(label: "Orange", image: "", ingredientLines: [], yield: 3, totalTime: 0, uri: "", url: "") {}
        coreDataService.saveRecipes(label: "Butter", image: "", ingredientLines: [], yield: 3, totalTime: 0, uri: "", url: "") {}
        XCTAssertTrue(coreDataService.isExist(recipeUri: recipeUriTesting))
        
        coreDataService.getRecipes { recipes in
            favoriteRecipe = recipes
            expectation.fulfill()
        }
        
        XCTAssertEqual(favoriteRecipe.count, 4)
        XCTAssertEqual(favoriteRecipe[0].label, "Lemon")
        XCTAssertEqual(favoriteRecipe[1].label, "Butter")
        XCTAssertEqual(favoriteRecipe[2].label, "Apple")
        XCTAssertEqual(favoriteRecipe[3].label, "Orange")
    }
}
