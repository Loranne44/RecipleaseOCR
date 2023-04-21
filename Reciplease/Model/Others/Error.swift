//
//  ErrorCases.swift
//  Reciplease
//
//  Created by Loranne Joncheray on 29/11/2022.
//

import Foundation

enum ErrorCase: Error {
    case invalidRequest
    case errorDecode
    case errorNetwork
    case isEmpty
    case countNotSuffisant
    case noUri
    
    var message : String {
        switch self {
        case .invalidRequest:
            return "Sorry, bad status code"
        case .errorDecode:
            return "Sorry, no JSON"
        case .errorNetwork:
            return "Sorry, no data"
        case .isEmpty:
            return  "Enter an ingredient"
        case .countNotSuffisant:
            return "Add at least one ingredient"
        case .noUri:
            return "No uri on this recipe"
    
        }
    }
}

/*
 // case alreadyExist
 // case isBlank
 // case errorRequest
 // case noRecipeDelete

 //case .alreadyExist:
 //    return "This ingredients is already present in your list"
//  case .isBlank:
//     return "Write an ingredient"
 //     case .errorRequest:
    //      return "Error in request"
 //  case .noRecipeDelete:
//       return "No recipe to delete"
 */
