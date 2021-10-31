//
//  PokemonModel.swift
//  Serebii
//
//  Created by Patrick Solis on 10/30/21.
//

import Foundation

struct PokemonModel: Decodable {
    
    struct Species: Decodable {
        let name: String
        let url: String
    }
    
    let id: Int
    let species: Species
    let types: [Types]
    let height: Double
    let weight: Double
    
    init() {
        self.id = 0
        self.species = Species(name: "MissingNo", url: "")
        self.types = [Types(slot: 1, type: .init(name: .normal, url: ""))]
        self.height = 30.48
        self.weight = 159.084
    }
}
