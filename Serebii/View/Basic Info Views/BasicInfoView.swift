//
//  BasicInfoView.swift
//  Serebii
//
//  Created by Patrick Solis on 10/28/21.
//

import UIKit

class BasicInfoView: UICollectionView {
    
    var pokemon: PokemonModel = .init() {
        didSet {
            self.reloadData()
        }
    }
    
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
        return self.sectionTitles.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.sectionTitles[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailCell", for: indexPath) as? DetailCellView else { return UICollectionViewCell() }
        let infoTitle = self.sectionTitles[indexPath.section][indexPath.row]
        cell.setTitle(infoTitle.title)

        if infoTitle == .type {
            let detailView = PokemonTypeView(frame: .zero)
            let primaryType: `Type` = self.pokemon.type[0]
            let secondaryType: `Type`? = self.pokemon.type.count == 2 ? self.pokemon.type[1] : nil
            detailView.setTypes(primaryType: primaryType, secondaryType: secondaryType)
            cell.setDetailView(detailView)
        } else if infoTitle == .genderRatio {
            let detailView = GenderRatioView(frame: .zero)
            detailView.setRatio(malePercentage: 80.0, femalePercentage: 20.0)
            cell.setDetailView(detailView)
        } else if infoTitle == .abilities {
            let detailView = AbilitiesView(frame: frame)
            detailView.setAbilities(abilities: self.pokemon.ability)
            cell.setDetailView(detailView)
        } else if infoTitle == .height {
            cell.setDetailView(text: self.pokemon.height.dmToFeetAndInches())
        } else if infoTitle == .weight {
            cell.setDetailView(text: self.pokemon.weight.hgToLbs())
        } else {
            cell.setDetailView(text: "test")
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
