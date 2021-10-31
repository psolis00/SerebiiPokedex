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

        NetworkServices.fetchPokemon(pokemonName: "bulbasaur") { pokemon in
            if let pokemon = pokemon {
                DispatchQueue.main.async {
                    self.navigationItem.title = String(format: "#%03d \(pokemon.species.name.capitalized)", pokemon.id )
                    self.pokemonInfoView.setPokemon(pokemon)
                }
            }
        }
    }

}
