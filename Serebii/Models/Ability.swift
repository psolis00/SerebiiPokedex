//
//  Ability.swift
//  Serebii
//
//  Created by Patrick Solis on 10/31/21.
//

import Foundation

struct Ability: Decodable {
    let name: String
    let description: String
    let isHidden: Bool
    let slot: Int
}
