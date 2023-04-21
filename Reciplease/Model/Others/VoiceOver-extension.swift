//
//  VoiceOver-extension.swift
//  Reciplease
//
//  Created by Loranne Joncheray on 08/03/2023.
//

import Foundation
import UIKit

func voiceOver(object: NSObject, message: String) {
    object.isAccessibilityElement = true
    object.accessibilityHint = message
    
}
