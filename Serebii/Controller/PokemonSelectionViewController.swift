//
//  PokemonSelectionViewController.swift
//  Serebii
//
//  Created by Patrick Solis on 11/5/21.
//

import UIKit

class PokemonSelectionViewController: UIViewController {

    var pokemon: [PokemonSelectionModel] = []
    var pokemonSelectionView: PokemonSelectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.pokemonSelectionView = PokemonSelectionView(frame: self.view.frame)
        self.view.addSubview(pokemonSelectionView)
        pokemonSelectionView.pickerView.delegate = self
        pokemonSelectionView.pickerView.dataSource = self
        
        self.fetchPokemonSelectionModels()
    }
    
    func fetchPokemonSelectionModels() {
        fetch(fromPath: "https://pokeapi.co/api/v2/pokemon?limit=151") { (pokemonSelectionResponseModel: PokemonSelectionResponseModel) in
            for species in pokemonSelectionResponseModel.species {
                fetch(fromPath: species.url) { (pokemonResponse: PokemonResponseModel) in
                    let pokemonSelectionModel = PokemonSelectionModel(id: pokemonResponse.id, name: species.name, imageUrl: pokemonResponse.sprites.other.officialArtwork.frontDefault, response: pokemonResponse)
                    self.pokemon.append(pokemonSelectionModel)
                    if self.pokemon.count == pokemonSelectionResponseModel.species.count {
                        DispatchQueue.main.async {
                            self.pokemon = self.pokemon.sorted(by: { $0.id < $1.id })
                            self.pokemonSelectionView.pickerView.reloadAllComponents()
                            print("completed")
                        }
                    }
                }
            }
        }
    }
    
    func prepareForPush(withPokemon pokemon: PokemonModel){
        let destination = PokemonInfoViewController()
        destination.pokemon = pokemon
        self.navigationController?.pushViewController(destination, animated: true)
    }

}

extension PokemonSelectionViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        self.pokemon.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        NSAttributedString(string: self.pokemon[row].name.capitalized)
    }

}


extension PokemonSelectionViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        fetch(fromPath: self.pokemon[row].imageUrl) { (data: Data?) in
            guard let data = data else { return }
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                self.pokemonSelectionView.pokemonImageView.image = image
            }
        }
    }
}
