//
//  PokemonModel.swift
//  Serebii
//
//  Created by Patrick Solis on 10/30/21.
//

import Foundation

struct PokemonModel {
    let id: Int
    let name: String
    let type: [`Type`]
    let classification: String
    let genderRatios: [(Gender, Int)]
    let ability: [Ability]
    let height: Double
    let weight: Double
    let catchRate: Int
    let baseHappiness: Int
    let eggSteps: Int
    let growthRate: GrowthRate
    
    init(id: Int, name: String, type: [`Type`], classification: String, genderRatios: [(Gender, Int)], ability: [Ability], height: Double, weight: Double, catchRate: Int, eggSteps: Int, growthRate: GrowthRate, baseHappiness: Int) {
        self.id = id
        self.name = name
        self.type = type
        self.classification = classification
        self.genderRatios = genderRatios
        self.ability = ability
        self.height = height
        self.weight = weight
        self.catchRate = catchRate
        self.eggSteps = eggSteps
        self.growthRate = growthRate
        self.baseHappiness = baseHappiness
    }
}
