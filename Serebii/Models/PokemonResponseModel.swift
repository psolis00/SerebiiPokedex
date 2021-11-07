//
//  PokemonResponseModel.swift
//  Serebii
//
//  Created by Patrick Solis on 10/31/21.
//

import Foundation
import UIKit

struct PokemonResponseModel: Decodable {
    
    struct SpeciesRepsonse: Decodable {
        enum CodingKeys: String, CodingKey {
            case baseHappiness = "base_happiness"
            case captureRate = "capture_rate"
            case hatchCounter = "hatch_counter"
            case growthRate = "growth_rate"
            case genera
        }
        
        struct GeneraResponse: Decodable {
            let language: Language
            let genus: String
        }
        
        struct GrowthRateResponse: Decodable {
            
            enum CodingKeys: String, CodingKey {
                case growth = "name"
                case url
            }
            
            let growth: GrowthRate
            let url : String
        }
        
        let baseHappiness: Int
        let captureRate: Int
        let hatchCounter: Int
        let growthRate: GrowthRateResponse
        let genera: [GeneraResponse]
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
        case id, species, types, abilities, height, weight, sprites
    }
    
    struct SpriteResponse: Decodable {
        let other: OtherSpriteResponse
        
        struct OtherSpriteResponse: Decodable {
            let officialArtwork: OfficialArtworkResponse
            
            enum CodingKeys: String, CodingKey {
                case officialArtwork = "official-artwork"
            }
            
            struct OfficialArtworkResponse: Decodable {
                let frontDefault: String
                
                enum CodingKeys: String, CodingKey {
                    case frontDefault = "front_default"
                }
            }
        }
    }
    
    let id: Int
    let species: Species
    let types: [TypeOrderResponse]
    let abilities: [AbilityOrderResponse]
    let sprites: SpriteResponse
    let height: Double
    let weight: Double
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.species = try container.decode(Species.self, forKey: .species)
        self.types = try container.decode([TypeOrderResponse].self, forKey: .types)
        self.abilities = try container.decode([AbilityOrderResponse].self, forKey: .abilities)
        self.sprites = try container.decode(SpriteResponse.self, forKey: .sprites)
        self.height = try container.decode(Double.self, forKey: .height)
        self.weight = try container.decode(Double.self, forKey: .weight)
    }
    
    
    func fetchImage() {
        let imagePath = self.sprites.other.officialArtwork.frontDefault
        fetch(fromPath: imagePath) { (data: Data) in
            print("success")
        }
    }
    
    func pokemonModel(completion: @escaping (PokemonModel) -> Void){
        var abilityCount = 0
        var pokemonAbilities: [Ability] = []
        var genderRatios: [(Gender, Int)] = []
        fetch(fromPath: self.species.url) { (speciesResponse: SpeciesRepsonse) in
            fetch(fromPath: "https://pokeapi.co/api/v2/gender/female") { (genderResponse: GenderResponse) in
                if let rate = genderResponse.species.first(where: { $0.species.name == self.species.name })?.rate {
                    genderRatios.append((Gender.female, rate))
                    genderRatios.append((Gender.male, 8 - rate))
                } else {
                    genderRatios.append((Gender.genderless, -1))
                }
                abilities.forEach { abilityResponse in
                    fetch(fromPath: abilityResponse.ability.url) { (ability: AbilityDescriptionResponse) in
                        abilityCount += 1
                        guard let description = ability.effectEntries.first(where: { $0.language.name == "en" })?.effect else { return }
                        pokemonAbilities.append(Ability(name: abilityResponse.ability.name.capitalized, description: description, isHidden: abilityResponse.isHidden, slot: abilityResponse.slot))
                        if abilityCount == self.abilities.count {
                            pokemonAbilities = pokemonAbilities.sorted(by: { $0.slot < $1.slot })
                            guard let classification = speciesResponse.genera.first(where: { $0.language.name == "en" })?.genus else { return }
                            completion(
                                PokemonModel(
                                    id: self.id,
                                    name: self.species.name.capitalized,
                                    type: self.types.map({ $0.type.name }),
                                    classification: classification,
                                    genderRatios: genderRatios,
                                    ability: pokemonAbilities,
                                    height: self.height,
                                    weight: self.weight,
                                    catchRate: speciesResponse.captureRate,
                                    eggSteps: (255 * speciesResponse.hatchCounter) + speciesResponse.hatchCounter,
                                    growthRate: speciesResponse.growthRate.growth,
                                    baseHappiness: speciesResponse.baseHappiness
                                )
                            )
                        }
                    }
                }
            }
        }
    }
}

struct AbilityDescriptionResponse: Decodable {
    
    struct EffectEntry: Decodable {
        
        let effect: String
        let language: Language
    }
    
    enum CodingKeys: String, CodingKey {
        case effectEntries = "effect_entries"
    }
    
    let effectEntries: [EffectEntry]

}

struct Language: Decodable {
    let name: String
}

struct Species: Decodable {
    let name: String
    let url: String
}
