//
//  ClockCell.swift
//  myClock
//
//  Created by Alexander Kurz on 3/28/22.
//

import UIKit

class ClockCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Views
    
    private func setupView() {
        switchView.addTarget(self, action: #selector(switchStateDidChange(_:)), for: .valueChanged)

        layer.cornerRadius = 10
        backgroundColor = .black
        layer.borderWidth = 1
    
        addSubviews([
            nameLabel,
            chevronImageView,
            switchView,
        ])

        NSLayoutConstraint.activate([
            nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.rightAnchor.constraint(equalTo: switchView.leftAnchor),

            chevronImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            chevronImageView.widthAnchor.constraint(equalToConstant: 10),
            chevronImageView.heightAnchor.constraint(equalToConstant: 20),
            chevronImageView.centerYAnchor.constraint(equalTo: centerYAnchor),

            switchView.centerYAnchor.constraint(equalTo: centerYAnchor),
            switchView.rightAnchor.constraint(equalTo: chevronImageView.leftAnchor, constant: -16),
        ])
    }

    func configureWith(_ clock: Clock, capableOfHidden: Bool = false, chevronHidden: Bool = false) {
        nameLabel.text = clock.name
        switchView.isOn = clock.isActivated
        chevronImageView.isHidden = chevronHidden
        if (switchView.isOn) {
            layer.borderColor = UIColor.white.cgColor
            nameLabel.textColor = .white
        }
        else {
            layer.borderColor = UIColor.darkGray.cgColor
            nameLabel.textColor = .lightGray
        }
    }
    
    // MARK: Cell elements

    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .lightGray
        label.numberOfLines = 0

        return label
    }()

    private let chevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "chevron.right")?.withTintColor(.gray, renderingMode: .alwaysOriginal)
        imageView.isHidden = false
        return imageView
    }()

    let switchView: UISwitch = {
        let switchDemo = UISwitch()
        switchDemo.translatesAutoresizingMaskIntoConstraints = false
        switchDemo.setOn(false, animated: true)
        return switchDemo
    }()
    
    // MARK: Button actions
    
    var switchValueChanged: ((Bool) -> ()) = { _ in }

    @objc func switchStateDidChange(_ sender:UISwitch!)
    {
        let defaults = UserDefaults.standard
        let key = nameLabel.text
        if (sender.isOn == true){
            print("UISwitch state is now ON")
            defaults.set(true, forKey: key!)
            print(key!)
            nameLabel.textColor = .white
            layer.borderColor = UIColor.white.cgColor
        }
        else{
            print("UISwitch state is now Off")
            defaults.set(false, forKey: key!)
            print(key!)
            nameLabel.textColor = .lightGray
            layer.borderColor = UIColor.darkGray.cgColor
        }
        switchValueChanged(sender.isOn)
    }
}
