//
//  DetailView.swift
//  Serebii
//
//  Created by Patrick Solis on 10/26/21.
//

import UIKit

class DetailView: UIView {
    
    // MARK: - Subviews
    private var titleLabel: UILabel
    private var detailView: UIView
    
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

    private func setup() {
        self.addSubview(titleLabel)
        self.addSubview(detailView)
        
        self.backgroundColor = .titleBackgroundColor
        self.layer.cornerRadius = 15.0
        self.layer.borderColor = UIColor.darkGray.cgColor
        self.layer.borderWidth = 0.5
        
        // Set Title View
        self.titleLabel.textAlignment = .center
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        self.titleLabel.textColor = .fontColor
        
        // Set Title View Constraints
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        self.titleLabel.bottomAnchor.constraint(equalTo: self.detailView.topAnchor).isActive = true
        self.titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.titleLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        // Set Detail View
        self.detailView.backgroundColor = .detailBackgroudColor
        self.detailView.layer.cornerRadius = 15
        self.detailView.layer.borderColor = UIColor.darkGray.cgColor
        self.detailView.layer.borderWidth = 0.5
        
        // Set Detail View Constraints
        self.detailView.translatesAutoresizingMaskIntoConstraints = false
        self.detailView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        self.detailView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        self.detailView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.detailView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
    }

    // MARK: - Methods
    
    func prepareForReuse() {
        self.titleLabel.text = ""
        self.detailView.subviews.forEach({ $0.removeFromSuperview() })
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
        view.topAnchor.constraint(equalTo: self.detailView.topAnchor, constant: 10).isActive = true
        view.bottomAnchor.constraint(equalTo: self.detailView.bottomAnchor, constant: -10).isActive = true
        view.leadingAnchor.constraint(greaterThanOrEqualTo: self.detailView.leadingAnchor, constant: 10).isActive = true
        view.trailingAnchor.constraint(lessThanOrEqualTo: self.detailView.trailingAnchor, constant: -10).isActive = true
    }
    
    /**
     Sets detail view as text
     - Parameters:
        - text: Text to be displayed
     */
    func setDetailView(text: String) {
        let label = UILabel(frame: .zero)
        label.text = text
        setDetailView(label)
    }
}





// MARK: - Detail Cell View

class DetailCellView: UICollectionViewCell {
    
    // MARK: - Properties
    static let identifier = "DetailCell"
    
    // MARK: - Views
    private var detailView: DetailView

    // MARK: - Initializers
    
    override init(frame: CGRect) {
        self.detailView = DetailView(frame: frame)
        super.init(frame: frame)
        
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.contentView.addSubview(detailView)
        
        self.detailView.translatesAutoresizingMaskIntoConstraints = false
        self.detailView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.detailView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.detailView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.detailView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    // MARK: - Methods
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.detailView.prepareForReuse()
    }
    
    /**
     Set title for the Detail View
     - Parameters:
        - title: Name of the detail view
     */
    func setTitle(_ title: String) {
        self.detailView.setTitle(title)
    }
    
    /**
     Set view to be displayed in detail view. Content of view will be centered within cell.
     - Parameters:
        - view: UIView that will be used to show content
     */
    func setDetailView(_ view: UIView) {
        self.detailView.setDetailView(view)
    }
    
    /**
     Sets detail view as text
     - Parameters:
        - text: Text to be displayed
     */
    func setDetailView(text: String) {
        self.detailView.setDetailView(text: text)
    }
}
