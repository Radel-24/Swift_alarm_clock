//
//  TechnologyDetailController.swift
//  techstack-swift
//
//  Created by Marcus Hopp on 24.03.22.
//

import UIKit

class TechnologyDetailController: UIViewController {
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    private let emptyView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let emptyStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()
    private let emptyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "person.fill.xmark")?.withTintColor(.darkGray, renderingMode: .alwaysOriginal)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0 Humans are capable of that"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .darkGray
        label.numberOfLines = 2
        return label
    }()
    
    private let viewModel: TechnologyDetailViewModel
    
    init(viewModel: TechnologyDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = viewModel.technologyName
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        viewModel.numberOfUsers == 0 ? setupEmptyView() : setupCollectionView()
    }
    
    private func setupEmptyView() {
        view.addSubview(emptyView)
        emptyView.addSubview(emptyStackView)
        
        emptyStackView.addArrangedSubviews([
            emptyImageView,
            emptyLabel
        ])
        
        NSLayoutConstraint.activate([
            emptyView.leftAnchor.constraint(equalTo: view.leftAnchor),
            emptyView.topAnchor.constraint(equalTo: view.topAnchor),
            emptyView.rightAnchor.constraint(equalTo: view.rightAnchor),
            emptyView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            emptyStackView.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
            emptyStackView.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 24),
            emptyStackView.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -24),
            emptyStackView.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor),
            
            emptyImageView.heightAnchor.constraint(equalToConstant: 100),
            emptyImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.register(UserCell.self, forCellWithReuseIdentifier: "UserCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.alwaysBounceVertical = true
        
        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension TechnologyDetailController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfUsers
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserCell", for: indexPath) as? UserCell,
            let user = viewModel.userAt(indexPath.item) else { return UICollectionViewCell() }
        cell.configureWith(user)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.bounds.width / 2 - 24
        let height: CGFloat = 120
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard
            let selectedUser = viewModel.userAt(indexPath.item) else { return }
        let controller = UserDetailController(viewModel: UserViewModel(user: selectedUser))
        present(controller, animated: true, completion: nil)
    }
}
