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

    private let switchView: UISwitch = {
        let switchDemo = UISwitch()
        switchDemo.translatesAutoresizingMaskIntoConstraints = false // um view selbst zu positieren
        switchDemo.setOn(false, animated: true)
        return switchDemo
    }()


    @objc func switchStateDidChange(_ sender:UISwitch!)
    {
        let defaults = UserDefaults.standard
        let key = nameLabel.text
        if (sender.isOn == true){
            print("UISwitch state is now ON")
            defaults.set(true, forKey: key!)
            print(key!)
        }
        else{
            print("UISwitch state is now Off")
            defaults.set(false, forKey: key!)
            print(key!)
        }
//        print(defaults.bool(forKey: "Monday"))
//        print(defaults.bool(forKey: "Tuesday"))
    }

//    func textFor(_ humansCapableOfCount: Int) -> String {
//        return humansCapableOfCount > 1 ? "\(humansCapableOfCount) humans are capable of" : "\(humansCapableOfCount) human is capable of"
//    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    private func setupView() {
        switchView.addTarget(self, action: #selector(switchStateDidChange(_:)), for: .valueChanged)

        layer.cornerRadius = 10
        backgroundColor = .sit_PrimaryLight

        addSubviews([
            nameLabel,
            chevronImageView,
            switchView
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
            switchView.rightAnchor.constraint(equalTo: chevronImageView.leftAnchor, constant: -16)
        ])
    }

    func configureWith(_ clock: Clock, capableOfHidden: Bool = false, chevronHidden: Bool = false) {
        nameLabel.text = clock.name
        chevronImageView.isHidden = chevronHidden
    }
}
