//
//  ViewController.swift
//  Serebii
//
//  Created by Patrick Solis on 10/26/21.
//

import UIKit

class ViewController: UIViewController {
    
    fileprivate let cellTitles: [[InfoTitle]] = [
        [.type, .classification, .genderRatio],
        [.abilities],
        [.height, .weight, .catchRate, .eggSteps],
        [.expGrowth, .baseHappiness, .evsEarned],
        [.weakness],
        [.evolutions]
    ]
    
    private let spacing: CGFloat = 10.0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let pokemonInfoView = PokemonInfoView(frame: view.frame)
        pokemonInfoView.collectionView.delegate = self
        pokemonInfoView.collectionView.dataSource = self
        pokemonInfoView.collectionView.register(DetailCellView.self, forCellWithReuseIdentifier: "DetailCellView")
        
        self.view = pokemonInfoView
        
        self.navigationItem.title = "#001 Bulbasaur"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.backgroundColor = .titleBackgroundColor
    }

}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: self.spacing, height: self.spacing)
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.cellTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cellTitles[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailCellView", for: indexPath) as? DetailCellView else { return UICollectionViewCell() }
        
        // Sets title for cell
        let cellTitle = self.cellTitles[indexPath.section][indexPath.row]
        cell.setTitle(cellTitle.title)
        
        // Adds detail subview
        if cellTitle == .type {
            cell.setDetailView(types: [.grass, .poison])
        } else if cellTitle == .classification {
            cell.setDetailView(text: "Seed Pokemon")
        } else if cellTitle == .genderRatio {
            cell.setDetailView(male: "80.0", female: "20.0")
        } else if cellTitle == .abilities {
            cell.setDetailView(abilities: ["Overgrow": "When HP is below 1/3rd its maximum, power of Grass-type moves is increased by 50%.", "Chlorophyll (Hidden)" : "When sunny, the Pokemon's Speed doubles"])
        } else if cellTitle == .height {
            cell.setDetailView(text: "2'04")
        } else if cellTitle == .weight {
            cell.setDetailView(text: "15.2lbs")
        } else if cellTitle == .catchRate {
            cell.setDetailView(text: "45")
        } else if cellTitle == .eggSteps {
            cell.setDetailView(text: "5,120")
        } else if cellTitle == .expGrowth {
            cell.setDetailView(text: "Medium Slow")
        } else if cellTitle == .baseHappiness {
            cell.setDetailView(text: "50")
        } else if cellTitle == .evsEarned {
            cell.setDetailView(text: "1 Sp. Attack Point(s)")
        }
        
        return cell
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return self.spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItems = CGFloat(self.cellTitles[indexPath.section].count)
        let width = (collectionView.frame.width - (self.spacing * (numberOfItems - 1.0))) / numberOfItems
        return CGSize(width: width, height: 125)
    }
}

