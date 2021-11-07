//
//  PokemonSelectionModel.swift
//  Serebii
//
//  Created by Patrick Solis on 11/6/21.
//

import Foundation
import UIKit

struct PokemonSelectionModel {
    let id: Int
    let name: String
    let imageUrl: String
    let response: PokemonResponseModel
}

struct PokemonSelectionResponseModel: Decodable {
    let species: [Species]
    
    enum CodingKeys: String, CodingKey {
        case species = "results"
    }
}
