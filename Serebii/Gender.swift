//
//  Gender.swift
//  Serebii
//
//  Created by Patrick Solis on 10/26/21.
//

import Foundation

enum Gender: String {
    case male
    case female
    case genderless
    
    var symbol: String {
        switch self {
        case .male:
            return "♂"
        case .female:
            return "♀"
        case .genderless:
            return ""
        }
    }
}
