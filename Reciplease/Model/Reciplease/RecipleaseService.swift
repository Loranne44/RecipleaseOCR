//
//  IngredientsService.swift
//  Reciplease
//
//  Created by Loranne Joncheray on 17/11/2022.
//

import Foundation
import Alamofire

class RecipleaseService {
    
    // MARK: - Singleton pattern
    static let shared = RecipleaseService()
    
    // MARK: - Task for the request
    private var task: DataRequest?
    
    private let session: RecipleaseProviderProtocol
    
    init(session: RecipleaseProviderProtocol = RecipleaseProvider()) {
        self.session = session
    }
    
    // MARK: - Properties
    static let apiId = "48f45189"
    static let apiKey = "0345ab4005430ad0fcc6e5460e7ed3e1"
    static let url = "https://api.edamam.com/api/recipes/v2"
    
    var parameter: [String: String] = [
        "type" : "public",
        "q" : "",
        "app_id" : "\(apiId)",
        "app_key" : "\(apiKey)"
    ]
    
    func param(ingredients: [String]) -> ([String: String]) {
        self.parameter["q"] = ingredients.joined(separator: " ")
        return self.parameter
    }
    
    // MARK: - getRecipes
    func getRecipes(ingredients: [String],callback: @escaping(Result<Reciplease, ErrorCase>) -> Void) {
        
        let parameters = param(ingredients: ingredients)
        
        task?.cancel()
        session.getRequest(url: RecipleaseService.url,
                           parameters: parameters,
                           completion: { result in
            switch result {
            case let .success(data):
                guard let responseJSON = try? JSONDecoder().decode(Reciplease.self, from: data) else {
                    callback(.failure(.errorDecode))
                    return
                }
                callback(.success(responseJSON))
            case let .failure(error) :
                callback(.failure(error))
            }
        })
    }
}
