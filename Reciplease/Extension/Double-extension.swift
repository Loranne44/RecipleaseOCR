//
//  Double-extension.swift
//  Reciplease
//
//  Created by Loranne Joncheray on 07/03/2023.
//

import Foundation
import UIKit

extension Double {
    func convertTime(style: DateComponentsFormatter.UnitsStyle) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = style
        return formatter.string(from: self) ?? ""
    }
}
