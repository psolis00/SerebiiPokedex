//
//  PokemonInfoViewController.swift
//  Serebii
//
//  Created by Patrick Solis on 10/28/21.
//

import UIKit

class PokemonInfoViewController: UIViewController {

    var pokemonInfoView: PokemonInfoView!
    
    override func viewDidLoad() {
        self.pokemonInfoView = .init(frame: self.view.frame)
        self.view.addSubview(self.pokemonInfoView)
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.backgroundColor = .titleBackgroundColor

        fetchPokemon(fromPath: "https://pokeapi.co/api/v2/pokemon/bulbasaur") { (pokemon: PokemonResponseModel) in
            pokemon.pokemonModel { pokemonModel in
                DispatchQueue.main.async {
                    self.navigationItem.title = String(format: "#%03d %@", pokemonModel.id, pokemonModel.name)
                    self.pokemonInfoView.setPokemon(pokemonModel)
                }
            }
        }
    }

}
