//
//  TechnologyDetailController.swift
//  techstack-swift
//
//  Created by Marcus Hopp on 24.03.22.
//

import UIKit


class ClockDetailController: UIViewController {
    private let viewModel: ClockDetailViewModel
    
//    private let safeButton: UIBarButtonItem = {
//        let button = UIBarButtonItem(title: "save", style: .plain, target: self(), action: nil)
//        return button
//    }()
    
    private let clockView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name:"
        return label
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("SAVE", for: .normal)
        button.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("START", for: .normal)
        button.addTarget(self, action: #selector(startButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.clearButtonMode = .always
        return textField
    }()

    private let emptyStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()

    
    init(viewModel: ClockDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = clocks[viewModel.clockId].name
        setupView()
        setupData()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        setupClockView()
    }
    
    private func setupClockView() {
        view.addSubview(clockView)
        clockView.addSubview(emptyStackView)
        
        emptyStackView.addArrangedSubviews([
                                            nameLabel,
                                            nameTextField,
                                            saveButton,
                                            startButton
                                            ])
        
        NSLayoutConstraint.activate([
            clockView.leftAnchor.constraint(equalTo: view.leftAnchor),
            clockView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            clockView.rightAnchor.constraint(equalTo: view.rightAnchor),
            clockView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor),
            nameTextField.leftAnchor.constraint(equalTo: view.leftAnchor),
            nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            saveButton.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10),
            startButton.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 60)
            
        ])
    }
    
    private func setupData() {
        nameTextField.text = clocks[viewModel.clockId].name
    }
    
    @objc func saveButtonPressed() {
        clocks[viewModel.clockId].name = nameTextField.text!
        writeToFile(location: subUrl!)
    }
    
    @objc func startButtonPressed() {
        
    }
    
    func alertNoDataChanged() {
        let alert = UIAlertController(title: "Reminder:", message: "No Data has been changed!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func writeToFile(location: URL) {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let JsonData = try encoder.encode(clocks)
            try JsonData.write(to: location)
        }catch{}
    }
}
