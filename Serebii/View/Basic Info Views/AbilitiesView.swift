//
//  AbilitiesView.swift
//  Serebii
//
//  Created by Patrick Solis on 10/28/21.
//

import UIKit

class AbilitiesView: UIStackView {
    
    private struct Constants {
        static let spacing: CGFloat = 5.0
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.axis = .vertical
        self.distribution = .fillEqually
        self.spacing = Constants.spacing
    }

    func setAbilities(abilities: [Ability]) {
        abilities.forEach { ability in
            let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .black)]
            let attributedString = NSMutableAttributedString(string: "\(ability.name)\(ability.isHidden ? " (Hidden)": ""): ", attributes: attributes)
            let normalString = NSMutableAttributedString(string: ability.description)
            attributedString.append(normalString)

            let label = UILabel(frame: .zero)
            label.lineBreakMode = .byWordWrapping
            label.attributedText = attributedString
            label.numberOfLines = 0
            
            self.addArrangedSubview(label)
        }
    }
}
