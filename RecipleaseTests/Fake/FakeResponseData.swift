//
//  FakeResponseData.swift
//  RecipleaseTests
//
//  Created by Loranne Joncheray on 14/03/2023.
//

import Foundation
@testable import Reciplease
import UIKit

class RecipleaseMockProvider: RecipleaseProviderProtocol {
    var result: Result<Data,ErrorCase> = .failure(ErrorCase.invalidRequest)
    
    init(result: Result<Data, ErrorCase>) {
        self.result = result
    }
    
    func getRequest(url: String, parameters: [String : String], completion: @escaping (Result<Data, ErrorCase>) -> Void) {
        completion(result)
    }
}

class RecipleaseImageMockProvider: RecipleaseImageProviderProtocol {
    
    var result: Result<UIImage,ErrorCase> = .failure(ErrorCase.invalidRequest)
    
    init(result: Result<UIImage, ErrorCase>) {
        self.result = result
    }
    
    func setImage(url: URL, placeholderImage: UIImage, object: UIImageView) {
        object.image = placeholderImage
        
        switch result {
        case let .success(image) :
            object.image = image
        case let .failure(error):
            print(error)
        }
    }
}
