//
//  DetailCellView.swift
//  Serebii
//
//  Created by Patrick Solis on 10/26/21.
//

import UIKit

class DetailCellView: UICollectionViewCell {
    
    // MARK: - Views
    
    var titleLabel: UILabel
    var detailView: UIView

    // MARK: - Initializers
    
    override init(frame: CGRect) {
        self.titleLabel = UILabel(frame: .zero)
        self.detailView = UIView(frame: .zero)
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.titleLabel.text = ""
        self.detailView.subviews.forEach({ $0.removeFromSuperview() })
    }

    private func setup() {
        
        // Add Views
        self.addSubview(self.titleLabel)
        self.addSubview(self.detailView)
        
        // Auto Layout Set
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.detailView.translatesAutoresizingMaskIntoConstraints = false
        
        // View background
        
        self.backgroundColor = .titleBackgroundColor
        self.clipsToBounds = true
        self.layer.cornerRadius = 15
        self.layer.borderColor = UIColor.darkGray.cgColor
        self.layer.borderWidth = 0.5
        
        // Set Title View
        self.titleLabel.textAlignment = .center
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        self.titleLabel.textColor = .fontColor
        
        // Set Detail View
        self.detailView.backgroundColor = .detailBackgroudColor
        self.detailView.layer.cornerRadius = 15
        self.detailView.layer.borderColor = UIColor.darkGray.cgColor
        self.detailView.layer.borderWidth = 0.5
        
        // Constraints
        let titleLabelConstraints = [
            self.titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.titleLabel.heightAnchor.constraint(equalToConstant: 35)
        ]
        
        let detailViewConstraints = [
            self.detailView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor),
            self.detailView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            self.detailView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            self.detailView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor)
        ]

        NSLayoutConstraint.activate(titleLabelConstraints + detailViewConstraints)
    }
    
    /**
     Set title for the Detail View
     - Parameters:
        - title: Name of the detail view
     */
    func setTitle(_ title: String) {
        self.titleLabel.text = title
    }
    
    /**
     Set view to be displayed in detail view. Content of view will be centered within cell.
     - Parameters:
        - view: UIView that will be used to show content
     */
    func setDetailView(_ view: UIView) {
        self.detailView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.centerYAnchor.constraint(equalTo: self.detailView.centerYAnchor).isActive = true
        view.centerXAnchor.constraint(equalTo: self.detailView.centerXAnchor).isActive = true
        view.leadingAnchor.constraint(greaterThanOrEqualTo: self.detailView.leadingAnchor, constant: 10).isActive = true
        view.trailingAnchor.constraint(lessThanOrEqualTo: self.detailView.trailingAnchor, constant: -10).isActive = true
    }
    
    /**
     Set view based off on the Pokemon's typing
     - Parameters:
        - types: Array of types that a Pokemon has
     */
    func setDetailView(types: [PokemonType]) {
        if types.count < 1 || types.count > 2 {
            setDetailView(UIView())
        } else if types.count == 1 {
            let image = UIImageView(image: UIImage(named: types[0].rawValue))
            image.translatesAutoresizingMaskIntoConstraints = false
            image.contentMode = .scaleAspectFit
            image.widthAnchor.constraint(lessThanOrEqualToConstant: 80).isActive = true
            setDetailView(image)
        } else {
            let stackView = UIStackView(frame: .zero)
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .horizontal
            stackView.distribution = .fillEqually
            stackView.spacing = 10

            let primaryType = UIImageView(image: UIImage(named: types[0].rawValue))
            primaryType.translatesAutoresizingMaskIntoConstraints = false
            primaryType.contentMode = .scaleAspectFit
            primaryType.widthAnchor.constraint(lessThanOrEqualToConstant: 80).isActive = true

            let secondaryType = UIImageView(image: UIImage(named: types[1].rawValue))
            secondaryType.translatesAutoresizingMaskIntoConstraints = false
            secondaryType.contentMode = .scaleAspectFit
            secondaryType.widthAnchor.constraint(lessThanOrEqualToConstant: 80).isActive = true

            stackView.addArrangedSubview(primaryType)
            stackView.addArrangedSubview(secondaryType)
            
            setDetailView(stackView)
        }
    }
    
    func setDetailView(text: String) {
        let label = UILabel(frame: .zero)
        label.text = text
        setDetailView(label)
    }

    func setDetailView(male: String, female: String) {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        for gender in [Gender.male, Gender.female] {
            
            let color: UIColor = {
                switch gender {
                case .male:
                    return .maleColor
                case .female:
                    return .femaleColor
                case .genderless:
                    return .gray
                }
            }()
            
            let genderAttribute = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)]
            let attributedString = NSMutableAttributedString(string: "\(gender.rawValue.capitalized) ", attributes: genderAttribute)
            let genderSymbol = NSMutableAttributedString(string: gender.symbol, attributes: [NSAttributedString.Key.foregroundColor: color])
            attributedString.append(genderSymbol)
            let percentString = NSMutableAttributedString(string: ": \(gender == .male ? male : female)%")
            attributedString.append(percentString)
            let label = UILabel(frame: .zero)
            label.attributedText = attributedString
            
            stackView.addArrangedSubview(label)
        }
        setDetailView(stackView)
    }
    
    func setDetailView(abilities: [String: String]) {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical

        abilities.forEach { ability, text in
            let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)]
            let attributedString = NSMutableAttributedString(string: "\(ability): ", attributes: attributes)
            let normalString = NSMutableAttributedString(string: text)
            attributedString.append(normalString)

            let label = UILabel(frame: .zero)
            label.attributedText = attributedString
            label.numberOfLines = 0
            
            stackView.addArrangedSubview(label)
        }
        setDetailView(stackView)
    }
}
