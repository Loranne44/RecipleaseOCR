//
//  ToggleActivityIndicator-extension.swift
//  Reciplease
//
//  Created by Loranne Joncheray on 07/03/2023.
//

import Foundation
import UIKit

extension UIViewController {
    
    /// dissmis activity indicator or button
    func toggleActivityIndicator(activityIndicator: UIActivityIndicatorView, button: UIButton, showActivityIndicator: Bool) {
        activityIndicator.isHidden = !showActivityIndicator
        button.isHidden = showActivityIndicator
    }
}
