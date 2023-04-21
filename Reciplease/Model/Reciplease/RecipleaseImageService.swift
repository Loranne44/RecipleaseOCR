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
    
    func request(image: String?, object: UIImageView) {
        guard let image, let url = URL(string: image) else {
            object.image = UIImage(named: "pizza")
            return
        }
        guard let placeholderImage = UIImage(named: "pizza") else {
            return
        }
        sessionImage.setImage(url: url, placeholderImage: placeholderImage, object: object)
    }
}

