//
//  PokemonTypeView.swift
//  Serebii
//
//  Created by Patrick Solis on 10/28/21.
//

import UIKit

class PokemonTypeView: UIStackView {
    
    private struct Constants {
        static let spacing: CGFloat = 10.0
    }

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setup() {
        self.distribution = .fillEqually
        self.axis = .horizontal
        self.spacing = Constants.spacing
    }
    
    func setTypes(primaryType: `Type`, secondaryType: `Type`? = nil) {
        // Set primary type
        let primaryTypeImageView = UIImageView(image: UIImage(named: primaryType.rawValue))
        primaryTypeImageView.contentMode = .scaleAspectFit
        self.addArrangedSubview(primaryTypeImageView)
        
        if let secondaryType = secondaryType {
            let secondaryTypeImageView = UIImageView(image: UIImage(named: secondaryType.rawValue))
            secondaryTypeImageView.contentMode = .scaleAspectFit
            self.addArrangedSubview(secondaryTypeImageView)
        }
    }
}
