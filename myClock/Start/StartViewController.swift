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
        
        cells.removeAll()

        setupCollectionView()

        navigationController?.navigationBar.prefersLargeTitles = true
        title = "myClock"
        view.backgroundColor = .black
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        let btnAdd = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
//        btnAdd.tintColor = .green
        navigationItem.rightBarButtonItem = btnAdd
        

    
    
        
//        let btnEdit = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))
//        btnEdit.tintColor = .black
//        navigationItem.leftBarButtonItem = btnEdit
    }

    @objc func addTapped(_ sender:UIViewController!) {
//        print("addTapped!");
//        alertMessage()
        addClock()
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
        let newID = UUID.init()
        clocks.append(myClock.Clock(id: newID, name: "New Alarm", daysOfWeek: [0], ringDays: [], isActivated: true, ringTime: Calendar.current.dateComponents([.hour, .minute], from: Date.init()), notificationId: UUID().uuidString, selectedDays: [false, false, false, false, false, false, false]))
    }
    
    
    private func setupCollectionView() {
        collectionView.register(ClockCell.self, forCellWithReuseIdentifier: "ClockCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .black
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

//        let clock = clocks[indexPath.item]
//        cells[indexPath.item].configureWith(clock)
//        cells[indexPath.item].switchValueChanged = { switchValue in
//            print("Switch is \(switchValue)")
//            clocks[indexPath.item].isActivated = switchValue
//            writeToFile(location: subUrl!)
//        }
//        return cells[indexPath.item]
        
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ClockCell", for: indexPath) as? ClockCell else { return UICollectionViewCell() }
        let clock = clocks[indexPath.item]
        cell.configureWith(clock)
        cell.switchValueChanged = { switchValue in
            print("Switch is \(switchValue)")
            clocks[indexPath.item].isActivated = switchValue
            writeToFile(location: subUrl!)
        }
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
//        guard
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ClockCell", for: indexPath) as? ClockCell else { return CGSize() }
//        if (clocks[indexPath.item].isActivated) {
//            print("ON")
//            cell.layer.borderColor = UIColor.white.cgColor
//            cell.nameLabel.textColor = .white
//        }
//        else {
//            print("OFF")
//            cell.layer.borderColor = UIColor.darkGray.cgColor
//            cell.nameLabel.textColor = .lightGray
//        }
//        cells.append(cell)
        return CGSize(width: collectionView.bounds.width - 32, height: 80)
        
    }
}
