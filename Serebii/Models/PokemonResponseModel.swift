//
//  PokemonResponseModel.swift
//  Serebii
//
//  Created by Patrick Solis on 10/31/21.
//

import Foundation
import UIKit

struct PokemonResponseModel: Decodable {
    
    struct Species: Decodable {
        let name: String
        let url: String
    }
    
    
    struct TypeOrderResponse: Decodable {
        
        struct TypeResponse: Decodable {
            let name: `Type`
            let url: String
        }
        
        let slot: Int
        let type: TypeResponse
    }
    
    struct AbilityOrderResponse: Decodable {
        
        enum CodingKeys: String, CodingKey {
            case isHidden = "is_hidden"
            
            case ability, slot
        }
        
        struct AbilityURLResponse: Decodable {
            var name: String
            var url: String
        }
        
        var ability: AbilityURLResponse
        var isHidden: Bool
        var slot: Int

    }
    
    enum CodingKeys: CodingKey {
        case id, species, types, abilities, height, weight
    }
    
    let id: Int
    let species: Species
    let types: [TypeOrderResponse]
    let abilities: [AbilityOrderResponse]
    let height: Double
    let weight: Double
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.species = try container.decode(Species.self, forKey: .species)
        self.types = try container.decode([TypeOrderResponse].self, forKey: .types)
        self.abilities = try container.decode([AbilityOrderResponse].self, forKey: .abilities)
        self.height = try container.decode(Double.self, forKey: .height)
        self.weight = try container.decode(Double.self, forKey: .weight)
    }
    
    func pokemonModel(completion: @escaping (PokemonModel) -> Void){
        var abilityCount = 0
        var pokemonAbilities: [Ability] = []
        abilities.forEach { abilityResponse in
            fetchPokemon(fromPath: abilityResponse.ability.url) { (ability: AbilityDescriptionResponse) in
                abilityCount += 1
                guard let description = ability.effectEntries.first(where: { $0.language.name == "en" })?.effect else { return }
                pokemonAbilities.append(Ability(name: abilityResponse.ability.name.capitalized, description: description, isHidden: abilityResponse.isHidden))
                if abilityCount == self.abilities.count {
                    completion(PokemonModel(id: self.id, name: self.species.name.capitalized, type: self.types.map({ $0.type.name }), ability: pokemonAbilities, height: self.height, weight: self.weight))
                }
            }
        }
    }
}

struct AbilityDescriptionResponse: Decodable {
    
    struct EffectEntry: Decodable {
    
        struct Language: Decodable {
            let name: String
        }
        
        let effect: String
        let language: Language
    }
    
    enum CodingKeys: String, CodingKey {
        case effectEntries = "effect_entries"
    }
    
    let effectEntries: [EffectEntry]

}
