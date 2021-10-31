//
//  WeaknessChart.swift
//  Serebii
//
//  Created by Patrick Solis on 10/27/21.
//

import UIKit

class WeaknessChartView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        let weaknessGrid = UIStackView(frame: .zero)
        weaknessGrid.translatesAutoresizingMaskIntoConstraints = false
        weaknessGrid.axis = .horizontal
        weaknessGrid.distribution = .fillEqually
        weaknessGrid.spacing = 5
        
        `Type`.allCases.forEach { type in
            let stackView = UIStackView(frame: .zero)
            stackView.axis = .vertical
            stackView.distribution = .fillEqually
            stackView.spacing = 5
            
            let imageView = UIImageView(image: UIImage(named: type.rawValue))
            let multiplierLabel = UILabel(frame: .zero)
            
            stackView.addArrangedSubview(imageView)
            stackView.addArrangedSubview(multiplierLabel)
            
            imageView.contentMode = .scaleAspectFit
            imageView.transform = imageView.transform.rotated(by: .pi / 2)
            imageView.backgroundColor = .backgroundColor
            imageView.layer.cornerRadius = 5.0
            
            multiplierLabel.text = "1x"
            multiplierLabel.clipsToBounds = true
            multiplierLabel.textAlignment = .center
            multiplierLabel.backgroundColor = .backgroundColor
            multiplierLabel.layer.cornerRadius = 5.0
            
            weaknessGrid.addArrangedSubview(stackView)
        }
        
        self.addSubview(weaknessGrid)
        
        let constraints: [NSLayoutConstraint] = [
            weaknessGrid.topAnchor.constraint(equalTo: self.topAnchor),
            weaknessGrid.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            weaknessGrid.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            weaknessGrid.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }

}
