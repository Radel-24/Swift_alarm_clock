//
//  ViewController.swift
//  techstack-swift
//
//  Created by Marcus Hopp on 23.03.22.
//

import UIKit
import UserNotifications
import AVFoundation

class StartController: UIViewController {
    
    let alert = Bundle.main.loadNibNamed("Alert", owner: self, options: nil)?.last as! UIView
    
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
    }
    
    func toggleTorch(on: Bool) {
        guard let device = AVCaptureDevice.default(for: .video) else { return }
        
        if device.hasTorch {
            do {
                try device.lockForConfiguration()
                
                if on == true {
                    device.torchMode = .on
                } else {
                    device.torchMode = .off
                }
                device.unlockForConfiguration()
            } catch {
                print("torch went wrong")
            }
        }
    }
    

    @objc func addTapped(_ sender:UIViewController!) {
        print("TAPPED!");
        
//        toggleTorch(on: true)
        
        
//        MyLocalNotificationBuilder()
//            .setActions()
//            .setCategory()
//            .setContent()
//            .build()
        
        registerLocal()
        sleep(5)
        print("alert!")
//        showAlert()
        scheduleLocal(time: 5)
        scheduleLocal(time: 10)
        scheduleLocal(time: 15)
        scheduleLocal(time: 20)
        scheduleLocal(time: 25)
//
//
//        removeAlert()
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
    
    func showAlert() {
        let windows = UIApplication.shared.windows
        let lastWindow = windows.last
        alert.frame = UIScreen.main.bounds
        lastWindow?.addSubview(alert)
    }
    
    func removeAlert() {
        alert.removeFromSuperview()
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
        let controller = ClockController(viewModel: ClockViewModel(clock: clock))
        
        navigationController?.pushViewController(controller, animated: true)
//        present(controller, animated: true, completion: nil)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 32, height: 80)
    }
    
    @objc func registerLocal() {
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .badge, .sound]){(granted, error) in
            if granted {
                print("good")
            } else {
                print("bad")
            }
        }
    }
    
    @objc func scheduleLocal(time: Double) {
        
        let test = UNNotificationCen

        let center = UNUserNotificationCenter.current()

        var dateComponents = DateComponents()
        dateComponents.hour = 21
        dateComponents.minute = 25
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: time, repeats: false)

        let content = UNMutableNotificationContent()
        content.title = "My first alert"
        content.body = "get up now you lazy bastard!!!"
        content.categoryIdentifier = "myIdentifier"
        content.userInfo = ["Id": 7]
//        content.sound = UNNotificationSound.default

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
//        for index in 1...10 {
//            UIScreen.main.brightness = CGFloat(Double(index) * 0.1)
//            print(Double(index) * 0.1)
//            sleep(1)
//        }
        
    }
    
  
}


