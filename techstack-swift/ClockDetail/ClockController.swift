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
    
    private let internDeleteButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("DELETE", for: .normal)
        btn.setTitleColor(.red, for: .normal)
        btn.addTarget(self, action: #selector(deleteAlertMessage(_:)), for: .touchUpInside)
        return btn
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.clearButtonMode = .always
        textField.backgroundColor = .white
        return textField
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("SAVE", for: .normal)
        button.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let testTextField: UITextField = {
        let field = UITextField()
        field.backgroundColor = .blue
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    @objc func deleteAlertMessage(_ sender:UIButton!) {
        let alertController:UIAlertController = UIAlertController(title: "Delete", message: "Are you sure?", preferredStyle: UIAlertController.Style.alert)
        
        alertController.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.destructive, handler: { (action: UIAlertAction!) in
            self.choseToDelete()
            }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler:nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func choseToDelete() {
        deleteClock()
        writeToFile(location: subUrl!)
        viewModel.collectionView.reloadData()
        _ = navigationController?.popViewController(animated: true)
    }
    
    func deleteClock() {
//        print("before remove:")
//        print(clocks)
        let element = clocks.first(where: {$0.id == viewModel.clockId})
        let index = clocks.firstIndex(of: element!)
        clocks.remove(at: index!)
//        print("after remove:")
//        print(clocks)
    }
    
    @objc func saveButtonPressed() {
        clocks[viewModel.clockId].name = nameTextField.text!
        writeToFile(location: subUrl!)
        title = clocks[viewModel.clockId].name
        viewModel.collectionView.reloadData()
    }



    
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

        let element = clocks.first(where: {$0.id == viewModel.clockId})
        let index = clocks.firstIndex(of: element!)
//        print("index: \(index!)")
        nameTextField.text = clocks[index!].name
        title = clocks[index!].name
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
            datePickerTo,
            internDeleteButton,
            saveButton,
            nameTextField
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
            datePickerTo.widthAnchor.constraint(equalToConstant: 127),
            
            internDeleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            internDeleteButton.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -96),
            
            nameTextField.topAnchor.constraint(equalTo: dateLabelFrom.bottomAnchor, constant: 96),
            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameTextField.heightAnchor.constraint(equalToConstant: 40),
            nameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 64),
            nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -64),
            
            saveButton.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)

        ])
    }
}

//private let viewModel: ClockDetailViewModel
//
////    private let safeButton: UIBarButtonItem = {
////        let button = UIBarButtonItem(title: "save", style: .plain, target: self(), action: nil)
////        return button
////    }()
//
//    private let clockView: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//
//    private let nameLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Name:"
//        return label
//    }()
//
//    private let saveButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitle("SAVE", for: .normal)
//        button.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
//        return button
//    }()
//
//    private let startButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitle("START", for: .normal)
//        button.addTarget(self, action: #selector(startButtonPressed), for: .touchUpInside)
//        return button
//    }()
//
//    private let nameTextField: UITextField = {
//        let textField = UITextField()
//        textField.clearButtonMode = .always
//        return textField
//    }()
//
//    private let emptyStackView: UIStackView = {
//        let stackView = UIStackView()
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.axis = .vertical
//        stackView.alignment = .center
//        return stackView
//    }()
//
//
//    init(viewModel: ClockDetailViewModel) {
//        self.viewModel = viewModel
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        title = clocks[viewModel.clockId].name
//        setupView()
//        setupData()
//    }
//
//    private func setupView() {
//        view.backgroundColor = .white
//        setupClockView()
//    }
//
//    private func setupClockView() {
//        view.addSubview(clockView)
//        clockView.addSubview(emptyStackView)
//
//        emptyStackView.addArrangedSubviews([
//                                            nameLabel,
//                                            nameTextField,
//                                            saveButton,
//                                            startButton
//                                            ])
//
//        NSLayoutConstraint.activate([
//            clockView.leftAnchor.constraint(equalTo: view.leftAnchor),
//            clockView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            clockView.rightAnchor.constraint(equalTo: view.rightAnchor),
//            clockView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//
//            nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor),
//            nameTextField.leftAnchor.constraint(equalTo: view.leftAnchor),
//            nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor),
//
//            saveButton.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10),
//            startButton.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 60)
//
//        ])
//    }
//
//    private func setupData() {
//        nameTextField.text = clocks[viewModel.clockId].name
//    }
//
//    @objc func saveButtonPressed() {
//        clocks[viewModel.clockId].name = nameTextField.text!
//        writeToFile(location: subUrl!)
//    }
//
//    @objc func startButtonPressed() {
//
//    }
//
//    func alertNoDataChanged() {
//        let alert = UIAlertController(title: "Reminder:", message: "No Data has been changed!", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//        self.present(alert, animated: true, completion: nil)
//    }
//
//    func writeToFile(location: URL) {
//        do {
//            let encoder = JSONEncoder()
//            encoder.outputFormatting = .prettyPrinted
//            let JsonData = try encoder.encode(clocks)
//            try JsonData.write(to: location)
//        }catch{}
//    }

