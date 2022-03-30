//
//  TechnologyCell.swift
//  techstack-swift
//
//  Created by Marcus Hopp on 23.03.22.
//

import UIKit

class ClockCell: UICollectionViewCell {
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        return label
    }()

    private let chevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "chevron.right")?.withTintColor(.gray, renderingMode: .alwaysOriginal)
        imageView.isHidden = false
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupView() {
        layer.cornerRadius = 10
        backgroundColor = .sit_PrimaryLight
        
        addSubviews([
            nameLabel,
            chevronImageView
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.rightAnchor.constraint(equalTo: chevronImageView.leftAnchor),
            
            chevronImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            chevronImageView.widthAnchor.constraint(equalToConstant: 10),
            chevronImageView.heightAnchor.constraint(equalToConstant: 20),
            chevronImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func configureWith(_ clock: Clock, capableOfHidden: Bool = false, chevronHidden: Bool = false) {
        nameLabel.text = clock.name
        chevronImageView.isHidden = chevronHidden
    }
}
