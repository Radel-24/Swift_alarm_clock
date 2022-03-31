//
//  NotificationViewController.swift
//  AlertNotification
//
//  Created by Robin Adelwarth on 3/31/22.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {
    
//    @IBOutlet weak var clockTitle: UILabel!
//    @IBOutlet weak var clockDescription: UILabel!
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func didReceive(_ notification: UNNotification) {
        if let validTitle = notification.request.content.userInfo["title"] as? String,
           let validDescription = notification.request.content.userInfo["description"] as? String {
            titleLabel.text = validTitle
            descriptionLabel.text = validDescription
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        view.backgroundColor = .red
    }
    
    private func setupView() {
        view.addSubview(containerView)
        
        containerView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            containerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            containerView.rightAnchor.constraint(equalTo: view.rightAnchor),
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                                        
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            
            
        ])
                                        
    }

}
