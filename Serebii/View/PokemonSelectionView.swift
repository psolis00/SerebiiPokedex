//
//  PokemonSelectionView.swift
//  Serebii
//
//  Created by Patrick Solis on 11/5/21.
//

import UIKit

class PokemonSelectionView: UIView {
    
    // MARK: - Subviews
    var pickerView: UIPickerView = {
        let pickerView = UIPickerView(frame: .zero)
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerView
    }()

    var pokemonImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "bulbasaurImage")
        imageView.backgroundColor = .detailBackgroudColor
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    var pokemonNames: [String]
    
    init(withPokemonNames pokemonNames: [String], frame: CGRect) {
        self.pokemonNames = pokemonNames
        super.init(frame: frame)
        self.setup()
    }

    override init(frame: CGRect) {
        self.pokemonNames = []
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        // Add Subviews
        self.addSubview(self.pokemonImageView)
        self.addSubview(self.pickerView)

        self.pokemonImageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        self.pokemonImageView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor).isActive = true
        self.pokemonImageView.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor).isActive = true
        self.pokemonImageView.heightAnchor.constraint(equalTo: self.pokemonImageView.widthAnchor).isActive = true
        
        self.pickerView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        self.pickerView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor).isActive = true
        self.pickerView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive = true
        self.pickerView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}
