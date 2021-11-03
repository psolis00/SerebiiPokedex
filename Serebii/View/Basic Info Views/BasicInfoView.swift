//
//  BasicInfoView.swift
//  Serebii
//
//  Created by Patrick Solis on 10/28/21.
//

import UIKit

class BasicInfoView: UICollectionView {
    
    var pokemon: PokemonModel?
    
    private struct Constants {
        static let spacing: CGFloat = 10.0
    }

    private let sectionTitles: [[InfoTitle]] = [
        [.type, .classification, .genderRatio],
        [.abilities],
        [.height, .weight, .catchRate, .eggSteps],
        [.expGrowth, .baseHappiness, .evsEarned]
    ]

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.register(DetailCellView.self, forCellWithReuseIdentifier: DetailCellView.identifier)
        self.dataSource = self
        self.delegate = self
        self.isScrollEnabled = false
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BasicInfoView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.pokemon != nil ? self.sectionTitles.count : 0
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.pokemon != nil ? self.sectionTitles[section].count : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailCell", for: indexPath) as? DetailCellView else { return UICollectionViewCell() }
        let infoTitle = self.sectionTitles[indexPath.section][indexPath.row]
        cell.setTitle(infoTitle.title)
        
        if let pokemon = self.pokemon {
            if infoTitle == .type {
                let detailView = PokemonTypeView(frame: .zero)
                let primaryType: `Type` = pokemon.type[0]
                let secondaryType: `Type`? = pokemon.type.count == 2 ? pokemon.type[1] : nil
                detailView.setTypes(primaryType: primaryType, secondaryType: secondaryType)
                cell.setDetailView(detailView)
            } else if infoTitle == .classification {
                cell.setDetailView(text: pokemon.classification)
            } else if infoTitle == .genderRatio {
                let detailView = GenderRatioView(frame: .zero)
                detailView.setRatio(ratios: pokemon.genderRatios)
                cell.setDetailView(detailView)
            } else if infoTitle == .abilities {
                let detailView = AbilitiesView(frame: frame)
                detailView.setAbilities(abilities: pokemon.ability)
                cell.setDetailView(detailView)
            } else if infoTitle == .height {
                cell.setDetailView(text: pokemon.height.dmToFeetAndInches())
            } else if infoTitle == .weight {
                cell.setDetailView(text: pokemon.weight.hgToLbs())
            } else if infoTitle == .catchRate {
                cell.setDetailView(text: String(pokemon.catchRate))
            } else if infoTitle == .eggSteps {
                cell.setDetailView(text: String(pokemon.eggSteps))
            } else if infoTitle == .expGrowth {
                cell.setDetailView(text: String(pokemon.growthRate.name))
            } else if infoTitle == .baseHappiness {
                cell.setDetailView(text: String(pokemon.baseHappiness))
            } else {
                cell.setDetailView(text: "test")
            }
        }
        return cell
    }
    
}

extension BasicInfoView: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: Constants.spacing, height: Constants.spacing)
    }

}

extension BasicInfoView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.spacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sectionTitle = self.sectionTitles[indexPath.section][indexPath.row]
        if sectionTitle == .abilities {
            
        }
        let numberOfItems = CGFloat(self.sectionTitles[indexPath.section].count)
        let width = (collectionView.frame.width - (Constants.spacing * (numberOfItems - 1.0))) / numberOfItems
        return CGSize(width: width, height: 125)
    }
}
