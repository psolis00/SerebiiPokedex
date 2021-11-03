//
//  Gender.swift
//  Serebii
//
//  Created by Patrick Solis on 10/26/21.
//

import Foundation

struct GenderResponse: Decodable {
    let name: Gender
    let species: [SpeciesDetails]
    
    struct SpeciesDetails: Decodable {
        let species: Species
        let rate: Int
        
        enum CodingKeys: String, CodingKey {
            case species = "pokemon_species"
            case rate
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case species = "pokemon_species_details"
    }
}

enum Gender: String, CaseIterable, Decodable {
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

