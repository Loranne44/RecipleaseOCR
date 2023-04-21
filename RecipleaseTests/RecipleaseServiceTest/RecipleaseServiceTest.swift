//
//  RecipleaseServiceTest.swift
//  RecipleaseTests
//
//  Created by Loranne Joncheray on 14/03/2023.
//
@testable import Reciplease
import XCTest

final class RecipleaseServiceTest: XCTestCase {
    
    func testGivenRequestThenThrowError() {
        let mockProvider = RecipleaseMockProvider(result: .failure(ErrorCase.errorDecode))
        let recipleaseService = RecipleaseService(session: mockProvider)
        // When
        let expectation = XCTestExpectation(description: #function)
        
        recipleaseService.getRecipes(ingredients: ["Tomato"]) { result in
            switch result {
            case .success:
                XCTFail("Test is not valid")
            case let .failure(error):
                XCTAssertEqual(error, ErrorCase.errorDecode)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.02)
    }
    
    func testGivenRequestThenThrowError2() {
        let mockProvider = RecipleaseMockProvider(result: .success(Data()))
        let recipleaseService = RecipleaseService(session: mockProvider)
        // When
        let expectation = XCTestExpectation(description: #function)
        
        recipleaseService.getRecipes(ingredients: ["Tomato"]) { result in
            switch result {
            case .success:
                XCTFail("Test is not valid")
            case let .failure(error):
                XCTAssertEqual(error, ErrorCase.errorDecode)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.02)
    }
    
    // -------------- ? --------------
    func testGetRecipeShouldSendIsEmpty() {
        // Given
        
        let mockProvider = RecipleaseMockProvider(result: .failure(ErrorCase.isEmpty))
        let recipleaseService = RecipleaseService(session: mockProvider)
        // When
        let expectation = XCTestExpectation(description: #function)
        
        recipleaseService.getRecipes(ingredients: [""]) { result in
            // Then
            _ = try? result.get().hits.first?.recipe.label.isEmpty
            
            XCTAssertTrue(true)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.02)
    }
    
    func testGetRecipeShouldSendBackSuccessFullAndCorrectDataIfCorrectAnswerAlready() {
        // Given
        let data = RecipeDataTest().data
        let mockProvider = RecipleaseMockProvider(result: .success(data))
        let recipleaseService = RecipleaseService(session: mockProvider)
        // When
        let expectation = XCTestExpectation(description: #function)
        
        recipleaseService.getRecipes(ingredients: ["Tomato"]) { result in
            // Then
            let recipe = try? result.get().hits.first?.recipe
            XCTAssertEqual(recipe?.label, "Lemon Confit")
            XCTAssertEqual(recipe?.url, "http://ruhlman.com/2011/03/lemon-confit/")
            XCTAssertEqual(recipe?.totalTime, 0.0)
            XCTAssertEqual(recipe?.yield, 2)
            XCTAssertEqual(recipe?.ingredientLines, ["Kosher salt to cover (about 2 pounds/900 grams)",
                                                     "1/2 to 1 cup water or lemon juice (125 to 250 ml)",
                                                     "6 lemons, scrubbed and halved crosswise"])
            XCTAssertEqual(recipe?.uri, "http://www.edamam.com/ontologies/edamam.owl#recipe_2fb391cceeec3d82920a2035f1849d72")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.02)
    }
}
