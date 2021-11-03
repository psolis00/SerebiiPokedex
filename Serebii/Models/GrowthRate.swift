//
//  GrowthRate.swift
//  Serebii
//
//  Created by Patrick Solis on 11/2/21.
//

import Foundation

enum GrowthRate: String, CaseIterable, Decodable {
    case slow
    case medium
    case fast
    case mediumSlow = "medium-slow"
    case slowThenVeryFast = "slow-then-very-fast"
    case fastThenVerySlow = "fast-then-very-slow"
    
    var name: String {
        switch self {
        case .mediumSlow:
            return "Medium Slow"
        case .slowThenVeryFast:
            return "Slow Then Very Fast"
        case .fastThenVerySlow:
            return "Fast Then Very Slow"
        default:
            return self.rawValue.capitalized
        }
    }
}
