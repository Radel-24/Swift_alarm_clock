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
    
    private let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("X", for: .normal)
        button.setTitleColor(.red, for: .normal)
        return button
    }()
    
//    private var viewModel: ClockViewModel
    // brauche hier id um aus dem clocks array die richtige cell zu löschen
    // --> selbe logik wie bei StartViewController in "addTapped" function (line: 35)
    
    private var clockID : Int?
    
    @objc func deleteAlarm(_ sender:UIButton)
    {
        print("deleteAlarm (doesnt do anything)")
//        print("before deletion:")
//        print(clocks.count)
//        let toBeDeleted = clocks.first(where: {$0.id == clockID!}) ?? nil
//        if (toBeDeleted != nil) {
//            clocks.remove(at: clocks.firstIndex(of: toBeDeleted!)!)
//        }
//        print("\nafter deletion:")
//        print(clocks.count)
//        do {
//            let encoder = JSONEncoder()
//            encoder.outputFormatting = .prettyPrinted
//            let JsonData = try encoder.encode(clocks)
//            try JsonData.write(to: subUrl!)
////            let viewController = StartController()
//            super.StartController.reloaderrr()
//        } catch {
//            print("error: saveClocks failed")
//        }
    }


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
    

    override init(frame: CGRect) {
        
        super.init(frame: frame)

        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    private func setupView() {
        switchView.addTarget(self, action: #selector(switchStateDidChange(_:)), for: .valueChanged)
        deleteButton.addTarget(self, action: #selector(deleteAlarm(_:)), for: .touchUpInside)
        


        layer.cornerRadius = 10
        backgroundColor = .sit_PrimaryLight

        addSubviews([
            nameLabel,
            chevronImageView,
            switchView,
            deleteButton
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
            
            deleteButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            deleteButton.rightAnchor.constraint(equalTo: switchView.leftAnchor, constant: -16)
        ])
    }

    func configureWith(_ clock: Clock, capableOfHidden: Bool = false, chevronHidden: Bool = false) {
        nameLabel.text = clock.name
        clockID = clock.id
        chevronImageView.isHidden = chevronHidden
    }
}
