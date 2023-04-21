//
//  String-extension.swift
//  Reciplease
//
//  Created by Loranne Joncheray on 07/03/2023.
//

import Foundation
import UIKit

extension String {
    var isBlank: Bool {
        return  trimmingCharacters(in: .whitespaces).isEmpty
    }
}
