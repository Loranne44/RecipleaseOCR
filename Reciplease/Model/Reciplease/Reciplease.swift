//
//  RecipleaseData.swift
//  Reciplease
//
//  Created by Loranne Joncheray on 18/11/2022.
//

import Foundation

struct Reciplease: Decodable {
    let hits: [Hit]
}

struct Hit: Decodable {
    let recipe: Recipe
}

struct Recipe: Decodable {
    let uri: String
    let label: String
    let image: String?
    let url: String
    let yield: Int?
    let ingredientLines: [String]
    let ingredients: [Ingredients]
    let totalTime: Double?
}

struct Ingredients: Decodable {
    let text: String
    let quantity: Double
    let measure: String?
    let food: String
    let weight: Double
    let instructions: String?
}

struct RecipleaseDisplay {
    let label: String
    let image: String?
    let uri: String
    let url: String
    let ingredients: [String]
    let totalTime: Double?
    let yield: Int?
}
