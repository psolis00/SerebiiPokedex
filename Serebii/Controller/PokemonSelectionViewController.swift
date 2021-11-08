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
    
    private var currentPokemonIndex: Int = 0
    private var isSetupComplete: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.backgroundColor = .titleBackgroundColor
        
        self.pokemonSelectionView = PokemonSelectionView(frame: self.view.frame)
        self.view.addSubview(pokemonSelectionView)
        pokemonSelectionView.pickerView.delegate = self
        pokemonSelectionView.pickerView.dataSource = self
        
        self.fetchPokemonSelectionModels()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTapImageView(_:)))
        self.pokemonSelectionView.pokeballImageView.isUserInteractionEnabled = true
        self.pokemonSelectionView.pokeballImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func didTapImageView(_ imageView: UIImageView) {
        if self.isSetupComplete {
            let currentPokemon = self.pokemon[self.currentPokemonIndex]
            currentPokemon.response.pokemonModel { pokemonModel in
                fetch(fromPath: currentPokemon.imageUrl) { (data: Data?) in
                    guard let data = data else { return }
                    DispatchQueue.main.async {
                        let destination = PokemonInfoViewController()
                        destination.pokemon = pokemonModel
                        let image = UIImage(data: data)
                        destination.pokemonImage = image
                        self.navigationController?.pushViewController(destination, animated: true)
                    }
                }
            }
        }
    }
    
    func fetchPokemonSelectionModels() {
        fetch(fromPath: "https://pokeapi.co/api/v2/pokemon?limit=151") { (pokemonSelectionResponseModel: PokemonSelectionResponseModel) in
            for species in pokemonSelectionResponseModel.species {
                fetch(fromPath: species.url) { (pokemonResponse: PokemonResponseModel) in
                    let pokemonSelectionModel = PokemonSelectionModel(id: pokemonResponse.id, name: species.name, imageUrl: pokemonResponse.sprites.other.officialArtwork.frontDefault, response: pokemonResponse)
                    self.pokemon.append(pokemonSelectionModel)
                    if self.pokemon.count == pokemonSelectionResponseModel.species.count {
                        self.pokemon = self.pokemon.sorted(by: { $0.id < $1.id })
                        fetch(fromPath: self.pokemon[0].imageUrl) { (data: Data?) in
                            guard let data = data else { return }
                            let image = UIImage(data: data)
                            DispatchQueue.main.async {
                                self.pokemonSelectionView.pokemonImageView.image = image
                                self.pokemonSelectionView.pickerView.reloadAllComponents()
                                self.isSetupComplete = true
                            }
                        }
                    }
                }
            }
        }
    }
}

extension PokemonSelectionViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        self.pokemon.count
    }

}


extension PokemonSelectionViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let title = "\(row + 1): \(self.pokemon[row].name.capitalized)"
        return NSAttributedString(string: title)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let rotation = CGFloat(row - self.currentPokemonIndex)
        self.currentPokemonIndex = row
        self.pokemonSelectionView.pokeballImageView.transform = self.pokemonSelectionView.pokeballImageView.transform.rotated(by: .pi * rotation / 10)
        fetch(fromPath: self.pokemon[row].imageUrl) { (data: Data?) in
            guard let data = data else { return }
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                self.pokemonSelectionView.pokemonImageView.image = image
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        100
    }

}
