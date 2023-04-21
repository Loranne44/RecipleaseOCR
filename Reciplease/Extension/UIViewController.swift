//
//  UiViewController.swift
//  Reciplease
//
//  Created by Loranne Joncheray on 24/02/2023.
//

import Foundation
import UIKit


extension UITableViewCell {
    /// download image
    func donwloadImage(image: String?, imageView: UIImageView) {
        guard let imageUrl = image else {
            return
        }
        guard let url = URL(string: imageUrl) else {
            return
        }
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                imageView.image = UIImage(data: data!)
            }
        }
    }
}


