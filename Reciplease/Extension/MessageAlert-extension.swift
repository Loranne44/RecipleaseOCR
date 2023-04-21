//
//  MessageAlert-extension.swift
//  Reciplease
//
//  Created by Loranne Joncheray on 07/03/2023.
//

import Foundation
import UIKit

extension UIViewController {
    
    // MARK: - Methods
    /// Display alert message
    func messageAlert(message: String, title: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
}
