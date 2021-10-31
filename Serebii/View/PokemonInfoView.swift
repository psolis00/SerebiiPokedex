//
//  PokemonInfoView.swift
//  Serebii
//
//  Created by Patrick Solis on 10/28/21.
//

import UIKit

class PokemonInfoView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        // AddScroll View
        let scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .backgroundColor
        self.addSubview(scrollView)
        
        // Set Scroll View Constraints
        scrollView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        // Add Content View
        let contentView = UIView(frame: .zero)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        // Set Content View Constraints
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        contentView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        
        // Add Subviews
        let pokemonImageView = UIImageView(image: UIImage(named: "bulbasaurImage"))
        let basicInfoView = BasicInfoView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        let weaknessChartView = DetailView(frame: .zero)
        weaknessChartView.setTitle(InfoTitle.weakness.title)
        weaknessChartView.setDetailView(WeaknessChartView(frame: weaknessChartView.frame))
        
        contentView.addSubview(pokemonImageView)
        contentView.addSubview(basicInfoView)
        contentView.addSubview(weaknessChartView)
        
        // Set Image View Properties
        pokemonImageView.contentMode = .scaleAspectFit
        pokemonImageView.backgroundColor = .detailBackgroudColor
        pokemonImageView.layer.cornerRadius = 20.0
        
        // Set Image View Constraints
        pokemonImageView.translatesAutoresizingMaskIntoConstraints = false
        pokemonImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        pokemonImageView.bottomAnchor.constraint(lessThanOrEqualTo: weaknessChartView.topAnchor, constant: -20).isActive = true
        pokemonImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        pokemonImageView.trailingAnchor.constraint(lessThanOrEqualTo: basicInfoView.leadingAnchor, constant: -10).isActive = true
        pokemonImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4).isActive = true
        pokemonImageView.heightAnchor.constraint(equalTo: pokemonImageView.widthAnchor).isActive = true
        
        // Set Basic Info View Constraints
        let basicInfoViewHeight = CGFloat((125 * 4) + (10 * 3))
        
        basicInfoView.translatesAutoresizingMaskIntoConstraints = false
        basicInfoView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        basicInfoView.bottomAnchor.constraint(equalTo: weaknessChartView.topAnchor, constant: -10).isActive = true
        basicInfoView.leadingAnchor.constraint(equalTo: pokemonImageView.trailingAnchor, constant: 20).isActive = true
        basicInfoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        basicInfoView.heightAnchor.constraint(equalToConstant: basicInfoViewHeight).isActive = true
        
        // Set Weakness Chart View
        
        weaknessChartView.translatesAutoresizingMaskIntoConstraints = false
        weaknessChartView.topAnchor.constraint(equalTo: basicInfoView.bottomAnchor, constant: 10).isActive = true
        weaknessChartView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
        weaknessChartView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        weaknessChartView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        
    }
}
