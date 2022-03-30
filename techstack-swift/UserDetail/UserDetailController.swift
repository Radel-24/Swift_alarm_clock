//
//  UserDetailController.swift
//  techstack-swift
//
//  Created by Marcus Hopp on 25.03.22.
//

import UIKit

class UserDetailController: UIViewController {
    private let viewModel: UserViewModel
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(systemName: "xmark")?.withTintColor(.darkGray, renderingMode: .alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
        return button
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let ageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private let startedAtLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private let technologiesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let contactButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(systemName: "message.fill")?.withTintColor(.darkGray, renderingMode: .alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(didTapContact), for: .touchUpInside)
        return button
    }()
    
    init(viewModel: UserViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTapContact() {
        guard let url = URL(string: viewModel.email) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @objc func didTapClose() {
        dismiss(animated: true, completion: nil)
    }
    
    private func setupView() {
        view.addSubviews([
            closeButton,
            nameLabel,
            ageLabel,
            startedAtLabel,
            contactButton
        ])
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            closeButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.widthAnchor.constraint(equalToConstant: 25),
            
            nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 24),
            
            ageLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
            ageLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            ageLabel.rightAnchor.constraint(equalTo: nameLabel.rightAnchor),
            
            startedAtLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
            startedAtLabel.topAnchor.constraint(equalTo: ageLabel.bottomAnchor, constant: 4),
            startedAtLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            
            contactButton.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            contactButton.widthAnchor.constraint(equalToConstant: 30),
            contactButton.heightAnchor.constraint(equalToConstant: 30),
            contactButton.leftAnchor.constraint(equalTo: nameLabel.rightAnchor, constant: 8)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupView()
        setupTechnologies()
        setupData()
    }
    
    private func setupData() {
        nameLabel.text = viewModel.name
        ageLabel.text = "\(viewModel.age) Years old"
        startedAtLabel.text = "Started at \(viewModel.startedAt)"
    }
    
    private func setupTechnologies() {
        view.addSubview(technologiesCollectionView)
        
        technologiesCollectionView.delegate = self
        technologiesCollectionView.dataSource = self
        technologiesCollectionView.register(TechnologyCell.self, forCellWithReuseIdentifier: "TechnologyCell")
        technologiesCollectionView.backgroundColor = .white
        technologiesCollectionView.alwaysBounceVertical = true
        technologiesCollectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        NSLayoutConstraint.activate([
            technologiesCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            technologiesCollectionView.topAnchor.constraint(equalTo: startedAtLabel.bottomAnchor, constant: 24),
            technologiesCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            technologiesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension UserDetailController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.technologies.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TechnologyCell", for: indexPath) as? TechnologyCell,
            let technology = viewModel.itemAt(indexPath.item) else { return UICollectionViewCell() }
        cell.configureWith(technology, capableOfHidden: true, chevronHidden: true)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 32, height: 80)
    }
}
