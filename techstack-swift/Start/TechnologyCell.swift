//
//  TechnologyCell.swift
//  techstack-swift
//
//  Created by Marcus Hopp on 23.03.22.
//

import UIKit

class TechnologyCell: UICollectionViewCell {
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        return label
    }()
    private let capableOfLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .lightGray
        return label
    }()
    private let chevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "chevron.right")?.withTintColor(.gray, renderingMode: .alwaysOriginal)
        imageView.isHidden = false
        return imageView
    }()
    
    func textFor(_ humansCapableOfCount: Int) -> String {
        return humansCapableOfCount > 1 ? "\(humansCapableOfCount) humans are capable of" : "\(humansCapableOfCount) human is capable of"
    }
    
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
            capableOfLabel,
            chevronImageView
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.rightAnchor.constraint(equalTo: chevronImageView.leftAnchor),
            
            capableOfLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
            capableOfLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            capableOfLabel.rightAnchor.constraint(equalTo: nameLabel.rightAnchor),
            
            chevronImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            chevronImageView.widthAnchor.constraint(equalToConstant: 10),
            chevronImageView.heightAnchor.constraint(equalToConstant: 20),
            chevronImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func configureWith(_ technology: Technology, capableOfHidden: Bool = false, chevronHidden: Bool = false) {
        nameLabel.text = technology.name
        capableOfLabel.text = textFor(technology.numberOfCapableHumans ?? 0)
        capableOfLabel.isHidden = capableOfHidden
        chevronImageView.isHidden = chevronHidden
//        chevronImageView.isHidden = technology.numberOfCapableHumans == 0
    }
}
