//
//  RecipleaseImageService.swift
//  Reciplease
//
//  Created by Loranne Joncheray on 23/03/2023.
//

import Foundation
import AlamofireImage
import UIKit

class RecipleaseImageService {
    
    let sessionImage: RecipleaseImageProviderProtocol
    
    init(sessionImage: RecipleaseImageProviderProtocol = RecipleaseImageProvider()) {
        self.sessionImage = sessionImage
    }
    
    func request(imageUrl: String?, object: UIImageView) {
        guard let placeholderImage = UIImage(named: "pizza") else {
            return
        }
        guard let imageUrl, let url = URL(string: imageUrl) else {
            object.image = placeholderImage
            return
        }
        
        sessionImage.setImage(url: url, placeholderImage: placeholderImage, object: object)
    }
}

