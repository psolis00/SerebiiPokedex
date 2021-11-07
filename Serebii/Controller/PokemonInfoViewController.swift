//
//  PokemonInfoViewController.swift
//  Serebii
//
//  Created by Patrick Solis on 10/28/21.
//

import UIKit

class PokemonInfoViewController: UIViewController {

    var pokemonInfoView: PokemonInfoView!
    var pokemon: PokemonModel?

    override func viewDidLoad() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.backgroundColor = .titleBackgroundColor
        guard let pokemon = pokemon else { return }
        self.navigationItem.title = String(format: "#%03d %@", pokemon.id, pokemon.name)
        self.pokemonInfoView = PokemonInfoView(withPokemon: pokemon, frame: self.view.frame)
        self.view.addSubview(self.pokemonInfoView)
    }

}
