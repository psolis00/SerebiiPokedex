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

        self.navigationItem.title = "#001 Bulbasaur"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.backgroundColor = .titleBackgroundColor
    }

}
