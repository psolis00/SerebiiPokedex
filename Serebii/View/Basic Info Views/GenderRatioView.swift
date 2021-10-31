//
//  GenderRatioView.swift
//  Serebii
//
//  Created by Patrick Solis on 10/28/21.
//

import UIKit

class GenderRatioView: UIStackView {
    
    private struct Constants {
        static let spacing: CGFloat = 10.0
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.distribution = .fillEqually
        self.axis = .vertical
        self.spacing = Constants.spacing
    }
    
    func setRatio(malePercentage: Double, femalePercentage: Double) {
        for gender in [Gender.male, Gender.female] {
            // Color of symbol
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
            
            // Gender Type
            let genderAttribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .black)]
            let attributedString = NSMutableAttributedString(string: "\(gender.rawValue.capitalized) ", attributes: genderAttribute)
            
            // Gender Symbol
            let genderSymbol = NSMutableAttributedString(string: gender.symbol, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .black), NSAttributedString.Key.foregroundColor: color])
            attributedString.append(genderSymbol)
            
            // Percentage
            let percentString = NSMutableAttributedString(string: ": \(gender == .male ? String(malePercentage) : String(femalePercentage))%")
            attributedString.append(percentString)
            
            // Label
            let label = UILabel(frame: .zero)
            label.attributedText = attributedString
            
            // Add to StackView
            self.addArrangedSubview(label)
        }
    }
}
