//
//  NetworkServices.swift
//  Serebii
//
//  Created by Patrick Solis on 10/30/21.
//

import Foundation

struct NetworkServices {
    
    static func fetchPokemon(pokemonName pokemon: String, completion: @escaping (PokemonModel?) -> () = { _ in }) {
        let api = "https://pokeapi.co/api/v2/pokemon/"
        guard let url = URL(string: api + pokemon) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else {
                guard let data = data else {
                    print("Unable to retrieve data")
                    completion(nil)
                    return
                }
                do {
                    let pokemon = try JSONDecoder().decode(PokemonModel.self, from: data)
                    print(pokemon)
                    completion(pokemon)
                } catch {
                    print("Unable to decode Pokemon Data: \(error.localizedDescription)")
                    completion(nil)
                }
            }
        }.resume()
    }
}
