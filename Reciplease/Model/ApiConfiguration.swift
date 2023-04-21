//
//  ApiConfiguration.swift
//  Reciplease
//
//  Created by Loranne Joncheray on 25/11/2022.
//

import Foundation

#warning("remove or uncomment")

/*
 struct ApiConfig {
     static let apiId = "48f45189"
     static let apiKey = "0345ab4005430ad0fcc6e5460e7ed3e1"
     //static var ingredients: [String] = ["tomato"]
     static let url = "https://api.edamam.com/api/recipes/v2"
     /*static let parameters =  [
         "type" : "public",
         "q" : ingredients.joined(separator: ","),
         "app_id" : "\(apiId)",
         "app_key" : "\(apiKey)"
     ] as [String : String]*/
     
     
    
     
     /*func parameter(ingredient: [String]) -> [String : String] {
         var parameters =  [
             "type" : "public",
             "q" : ingredient.joined(separator: ","),
             "app_id" : "\(ApiConfig.apiId)",
             "app_key" : "\(ApiConfig.apiKey)"
         ] as [String : String]
         return parameters
     }*/
     
     
     var parameter: [String: String] = [
         "type" : "public",
         "q" : "",
         "app_id" : "\(apiId)",
         "app_key" : "\(apiKey)"
     ]
     
     mutating func param(ingredients: [String]) -> ([String: String]) {
         self.parameter["q"] = ingredients.joined(separator: " ")
         return self.parameter
     }
 }

 // parameter devient func parameter(ingredient[String] {
 // et virer la var ingredients
 //}

 */
