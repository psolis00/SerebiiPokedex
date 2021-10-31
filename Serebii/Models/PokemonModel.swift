//
//  PokemonModel.swift
//  Serebii
//
//  Created by Patrick Solis on 10/30/21.
//

import Foundation

struct PokemonModel: Decodable {
    let id: Int
    let name: String
    let type: [`Type`]
    let ability: [Ability]
    let height: Double
    let weight: Double
    
    init(id: Int, name: String, type: [`Type`], ability: [Ability], height: Double, weight: Double) {
        self.id = id
        self.name = name
        self.type = type
        self.ability = ability
        self.height = height
        self.weight = weight
    }
    
    init() {
        self.id = 0
        self.name = "MissingNo"
        self.type = [.normal]
        self.ability = [.init(name: "", description: "", isHidden: false)]
        self.height = 123
        self.weight = 123
    }
    
    func setAbilities() {
        
    }
}
