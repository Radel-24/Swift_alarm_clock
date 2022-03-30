//
//  ClockController.swift
//  techstack-swift
//
//  Created by Alexander Kurz on 3/30/22.
//

import UIKit

class ClockController: UIViewController {
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let alarmLabel: UILabel = {
       let label = UILabel()
        label.text = "Alarm"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label;
    }()
    
    private let timePicker: UIDatePicker = {
       let time = UIDatePicker()
        time.datePickerMode = .time
        time.translatesAutoresizingMaskIntoConstraints = false
        return time
    }()
    
    private let dateLabelFrom: UILabel = {
       let label = UILabel()
        label.text = "From"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label;
    }()
    
    private let dateLabelTo: UILabel = {
       let label = UILabel()
        label.text = "To"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label;
    }()
    
    private let datePickerFrom: UIDatePicker = {
       let date = UIDatePicker()
        date.datePickerMode = .date
        date.translatesAutoresizingMaskIntoConstraints = false
        return date;
    }()
    
    private let datePickerTo: UIDatePicker = {
       let date = UIDatePicker()
        date.datePickerMode = .date
        date.translatesAutoresizingMaskIntoConstraints = false
        return date;
    }()

    
    private let viewModel: ClockViewModel
    
    init(viewModel: ClockViewModel) {
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
        view.backgroundColor = .lightGray
        setupCollectionView()
    }
    
    
    private func setupCollectionView() {
        view.addSubview(containerView)
    
        
        containerView.addSubviews([
            alarmLabel,
            timePicker,
            dateLabelFrom,
            dateLabelTo,
            datePickerFrom,
            datePickerTo
        ])
    
        
        NSLayoutConstraint.activate([
            containerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            containerView.rightAnchor.constraint(equalTo: view.rightAnchor),
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
         
            alarmLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            alarmLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 48),
            alarmLabel.rightAnchor.constraint(equalTo: datePickerFrom.leftAnchor, constant: -8),
            
            timePicker.centerYAnchor.constraint(equalTo: alarmLabel.centerYAnchor),
            timePicker.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            timePicker.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 48),
            timePicker.heightAnchor.constraint(equalToConstant: 44),
            
            dateLabelFrom.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            dateLabelFrom.topAnchor.constraint(equalTo: alarmLabel.bottomAnchor, constant: 48),
            dateLabelFrom.rightAnchor.constraint(equalTo: datePickerFrom.leftAnchor, constant: -8),
   
            dateLabelTo.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            dateLabelTo.rightAnchor.constraint(equalTo: datePickerTo.leftAnchor, constant: -8),
            dateLabelTo.topAnchor.constraint(equalTo: dateLabelFrom.bottomAnchor, constant: 16),
            
            datePickerFrom.centerYAnchor.constraint(equalTo: dateLabelFrom.centerYAnchor),
            datePickerFrom.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            datePickerFrom.heightAnchor.constraint(equalToConstant: 44),
            datePickerFrom.widthAnchor.constraint(equalToConstant: 127),
            
            datePickerTo.centerYAnchor.constraint(equalTo: dateLabelTo.centerYAnchor),
            datePickerTo.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            datePickerTo.heightAnchor.constraint(equalToConstant: 44),
            datePickerTo.widthAnchor.constraint(equalToConstant: 127)

        ])
    }
}

