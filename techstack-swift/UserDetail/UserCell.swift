//
//  UserCell.swift
//  techstack-swift
//
//  Created by Marcus Hopp on 24.03.22.
//

import UIKit

class UserCell: UICollectionViewCell {
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        return label
    }()
    private let ageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .lightGray
        return label
    }()
    private let userIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "person.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        return imageView
    }()
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 0
        return stackView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        layer.cornerRadius = 20
        backgroundColor = .sit_PrimaryLight
        
        addSubviews([
            userIconImageView,
            stackView
        ])
        stackView.addArrangedSubviews([
            nameLabel,
            ageLabel
        ])
        NSLayoutConstraint.activate([
            userIconImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            userIconImageView.heightAnchor.constraint(equalToConstant: 40),
            userIconImageView.widthAnchor.constraint(equalToConstant: 40),
            
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            stackView.topAnchor.constraint(equalTo: userIconImageView.bottomAnchor, constant: 8),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
    
    func configureWith(_ user: User) {
        nameLabel.text = user.name
        ageLabel.text = "\(user.age) Years old"
    }
}
