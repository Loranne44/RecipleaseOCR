//
//  Set-extension.swift
//  Reciplease
//
//  Created by Loranne Joncheray on 07/03/2023.
//

import Foundation
import UIKit

/// Specify helper to retrieve Set.Index value from Int value
/// in order to perform access at specific Index
extension Set {
    func index(from row: Int) -> Index {
        return index(startIndex, offsetBy: row)
    }
}
