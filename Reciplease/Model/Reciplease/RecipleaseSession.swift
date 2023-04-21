//
//  RecipleaseSession.swift
//  Reciplease
//
//  Created by Loranne Joncheray on 15/03/2023.
//

import Foundation
import Alamofire
import AlamofireImage

protocol RecipleaseProviderProtocol {
    func getRequest(url: String, parameters: [String : String], completion: @escaping (Result<Data, ErrorCase>) -> Void)
}

class RecipleaseProvider: RecipleaseProviderProtocol {
    
    func getRequest(url: String, parameters: [String : String], completion: @escaping (Result<Data, ErrorCase>) -> Void) {
        AF.request(url,
                   method: .get,
                   parameters: parameters,
                   encoding: URLEncoding.default,
                   headers: nil,
                   interceptor: nil).responseDecodable(of: Reciplease.self) { response in
            
            guard let data = response.data else {
                completion(.failure(.errorNetwork))
                return
            }
            
            guard response.response?.statusCode == 200  else {
                completion(.failure(.invalidRequest))
                return
            }
            completion(.success(data))
        }
    }
}

protocol RecipleaseImageProviderProtocol {
    
    func setImage(url: URL, placeholderImage: UIImage, object: UIImageView) 
}

class RecipleaseImageProvider: RecipleaseImageProviderProtocol {
    func setImage(url: URL, placeholderImage: UIImage, object: UIImageView) {
        object.af.setImage(withURL: url, placeholderImage: placeholderImage)
    }
}
