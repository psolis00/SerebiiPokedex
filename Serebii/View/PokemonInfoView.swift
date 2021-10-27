//
//  PokemonInfoPage.swift
//  Serebii
//
//  Created by Patrick Solis on 10/26/21.
//

import UIKit

class PokemonInfoView: UIView {
    
    var imageView: UIImageView
    var collectionView: UICollectionView
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        self.imageView = UIImageView(frame: .zero)
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func setupViews() {
        self.backgroundColor = .backgroundColor

        // MARK: - Image
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.backgroundColor = .detailBackgroudColor
        self.imageView.image = UIImage(named: "bulbasaurImage")
        self.imageView.contentMode = .scaleAspectFit
        
        self.imageView.layer.cornerRadius = 30
        self.imageView.layer.borderColor = UIColor.darkGray.cgColor
        self.imageView.layer.borderWidth = 0.5
        
        self.addSubview(self.imageView)
        
        // MARK: - Info View
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.backgroundColor = .clear
        self.addSubview(self.collectionView)
        
//        let infoView: UIView = UIView(frame: .zero)
//        infoView.translatesAutoresizingMaskIntoConstraints = false
//        infoView.layer.cornerRadius = 30
//        self.addSubview(infoView)
//
//        let infoStackView = UIStackView(frame: infoView.frame)
//        infoStackView.translatesAutoresizingMaskIntoConstraints = false
//        infoStackView.axis = .vertical
//        infoStackView.distribution = .fillEqually
//        infoStackView.spacing = 10
//
//
//        // MARK: First Detail Row
//        let firstRowStackView = UIStackView(frame: .zero)
//        firstRowStackView.translatesAutoresizingMaskIntoConstraints = false
//        firstRowStackView.axis = .horizontal
//        firstRowStackView.distribution = .fillEqually
//        firstRowStackView.spacing = 10
//
//        // MARK: - Type Detail Cell
//
//        let typeView = DetailCellView(frame: .zero)
//        typeView.setTitle("Type")
//
        let typeStackView = UIStackView(frame: .zero)
        typeStackView.axis = .horizontal
        typeStackView.distribution = .fillEqually
        typeStackView.spacing = 10

        let primaryType = UIImageView(image: UIImage(named: "grassType"))
        primaryType.contentMode = .scaleAspectFit
        primaryType.widthAnchor.constraint(equalToConstant: 80).isActive = true

        let secondaryType = UIImageView(image: UIImage(named: "poisonType"))
        secondaryType.contentMode = .scaleAspectFit
        secondaryType.widthAnchor.constraint(equalToConstant: 80).isActive = true

        typeStackView.addArrangedSubview(primaryType)
        typeStackView.addArrangedSubview(secondaryType)
//
//        typeView.setDetailView(typeStackView)
//
//        // MARK: - Classification Detail Cell
//
//        let classificationView = DetailCellView(frame: .zero)
//        classificationView.setTitle("Classification")
//
//        let classificationLabel = UILabel(frame: .zero)
//        classificationLabel.text = "Seed Pokemon"
//        classificationLabel.textColor = .fontColor
//        classificationView.setDetailView(classificationLabel)
//
//        firstRowStackView.addArrangedSubview(typeView)
//        firstRowStackView.addArrangedSubview(classificationView)
//        infoStackView.addSubview(firstRowStackView)
//
//        // MARK: - Abilities Detail Cell
//        let abilitiesView = DetailCellView(frame: .zero)
//        abilitiesView.setTitle("Abilities")
//
        
        // MARK: - Set Constraints
        
        // Image Constraints
        let imageViewConstraints = [
            self.imageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            self.imageView.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.4),
            self.imageView.heightAnchor.constraint(equalTo: self.imageView.widthAnchor),
            self.imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ]
        
        let infoCollectionViewConstraints = [
            self.collectionView.topAnchor.constraint(equalTo: self.imageView.topAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            self.collectionView.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor, constant: 20),
            self.collectionView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ]

        NSLayoutConstraint.activate(imageViewConstraints + infoCollectionViewConstraints)
    }
}
