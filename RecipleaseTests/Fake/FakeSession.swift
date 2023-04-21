//
//  URLSessionFake.swift
//  RecipleaseTests
//
//  Created by Loranne Joncheray on 14/03/2023.
//
@testable import Reciplease
import Foundation

class RecipeDataTest {
    var data: Data {
        let bundle = Bundle(for: RecipleaseServiceTest.self)
        let url = bundle.url(forResource: "Recipe", withExtension: "json")
        let RecipeData = try! Data(contentsOf: url!)
        return RecipeData
    }
}
