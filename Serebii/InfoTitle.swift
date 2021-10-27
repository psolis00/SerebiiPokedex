//
//  InfoTitle.swift
//  Serebii
//
//  Created by Patrick Solis on 10/26/21.
//

import Foundation

enum InfoTitle: String {
    case type
    case classification
    case genderRatio
    case abilities
    case height
    case weight
    case catchRate
    case eggSteps
    case expGrowth
    case baseHappiness
    case evsEarned
    case weakness
    case evolutions
    
    var title: String {
        switch self {
        case .genderRatio:
            return "Gender Ratio"
        case .catchRate:
            return "Catch Rate"
        case .eggSteps:
            return "Egg Steps"
        case .expGrowth:
            return "Experience Growth"
        case .baseHappiness:
            return "Base Happiness"
        case .evsEarned:
            return "Effort Values Earned"
        default:
            return self.rawValue.capitalized
        }
    }
}
