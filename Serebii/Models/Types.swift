//
//  PokemonType.swift
//  Serebii
//
//  Created by Patrick Solis on 10/26/21.
//

import Foundation

struct Types: Decodable {
    
    enum Name: String, CaseIterable, Decodable {
        case normal
        case fire
        case water
        case electric
        case grass
        case ice
        case fighting
        case poison
        case ground
        case flying
        case psychic
        case bug
        case rock
        case ghost
        case dragon
        case dark
        case steel
        case fairy
    }
    
    struct `Type`: Decodable {
        let name: Name
        let url: String
    }
    
    let slot: Int
    let type: `Type`

}
