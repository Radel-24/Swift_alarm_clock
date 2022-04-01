//
//  ViewController.swift
//  techstack-swift
//
//  Created by Marcus Hopp on 23.03.22.
//

import UIKit

class StartController: UIViewController {
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private let viewModel = StartViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()

        navigationController?.navigationBar.prefersLargeTitles = true
        title = "LightAlarmClock"
        view.backgroundColor = .lightGray
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
        let btnAdd = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        btnAdd.tintColor = .black
        navigationItem.rightBarButtonItem = btnAdd
        
//        let btnEdit = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))
//        btnEdit.tintColor = .black
//        navigationItem.leftBarButtonItem = btnEdit
    }

    @objc func addTapped(_ sender:UIViewController!) {
//        print("addTapped!");
//        alertMessage()
        addClock()
        writeToFile(location: subUrl!)
        collectionView.reloadData()
    }
    
//    @objc func editTapped(_ sender:UIViewController!) {
//        print("editTapped!");
//    }
    
//    func alertMessage() {
//        let alertController:UIAlertController = UIAlertController(title: "Added", message: "New Alarm", preferredStyle: UIAlertController.Style.alert)
//        let alertAction:UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:nil)
//        alertController.addAction(alertAction)
//        present(alertController, animated: true, completion: nil)
//    }
    
    func addClock() {
        var newID = 0
        if (clocks.count > 0) {
            newID = clocks[clocks.count - 1].id + 1
        }
        clocks.append(techstack_swift.Clock(id: newID, name: "New Alarm", daysOfWeek: [0], selectedDays: [false, false, false, false, false, false, false]))
    }
    
    
    private func setupCollectionView() {
        collectionView.register(ClockCell.self, forCellWithReuseIdentifier: "ClockCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .lightGray
        collectionView.alwaysBounceVertical = true
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)

        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension StartController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ClockCell", for: indexPath) as? ClockCell,
            let clock = viewModel.itemAt(indexPath.item) else { return UICollectionViewCell() }
        cell.configureWith(clock)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return clocks.count
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let clock = viewModel.itemAt(indexPath.item) else { return }
        let controller = ClockController(viewModel: ClockViewModel(clock: clock, collectionView: collectionView))
        
        navigationController?.pushViewController(controller, animated: true)
//        present(controller, animated: true, completion: nil)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 32, height: 80)
    }
}
