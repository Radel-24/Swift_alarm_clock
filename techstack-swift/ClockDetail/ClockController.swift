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
    
    private let repeatDaysButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Repeat Days", for: .normal)
//        btn.setTitleColor(.red, for: .normal)
        btn.addTarget(self, action: #selector(loadRepeatDaysView(_:)), for: .touchUpInside)
        
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 5
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.black.cgColor
        
        return btn
    }()
    
    private let internDeleteButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Delete Alarm", for: .normal)
        btn.setTitleColor(.red, for: .normal)
        btn.addTarget(self, action: #selector(deleteAlertMessage(_:)), for: .touchUpInside)
        
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 5
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.black.cgColor
        
        return btn
    }()
    
    private let editNameButton: UIButton = {
        let editName = UIButton(type: .system)
        
        editName.backgroundColor = .white
        editName.layer.cornerRadius = 5
        editName.layer.borderWidth = 1
        editName.layer.borderColor = UIColor.black.cgColor
        
        editName.translatesAutoresizingMaskIntoConstraints = false
        editName.setTitle("Edit Title", for: .normal)
        editName.addTarget(self, action: #selector(alertTextField(_:)), for: .touchUpInside)
        return editName

    }()
    
    private let calendarButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Calendar View", for: .normal)
        btn.setTitleColor(.red, for: .normal)
        btn.addTarget(self, action: #selector(calendarButtonPressed), for: .touchUpInside)
        return btn
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.clearButtonMode = .always
        textField.backgroundColor = .white
        return textField
    }()
    
    
    
    @objc func alertTextField(_ sender:UIButton!) {
        let alertController:UIAlertController = UIAlertController(title: "Edit Title", message: nil, preferredStyle: UIAlertController.Style.alert)
        
        alertController.addTextField { (textField) in
            textField.text = clocks[self.currentIndex!].name
        }
        
        alertController.addAction(UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction!) in
            clocks[self.viewModel.clockId].name = alertController.textFields![0].text!
            self.editNameSave()
            }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler:nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func editNameSave() {
            writeToFile(location: subUrl!)
            title = clocks[viewModel.clockId].name
            viewModel.collectionView.reloadData()
    }
    
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
    
    @objc func loadRepeatDaysView(_ sender: UIButton!) {
        let element = clocks.first(where: {$0.id == viewModel.clockId})
        let index = clocks.firstIndex(of: element!)
        let tableViewController = RepeatTableViewController(index: index!)
        navigationController?.pushViewController(tableViewController, animated: true)
    }
    
    func deleteClock() {
        let element = clocks.first(where: {$0.id == viewModel.clockId})
        let index = clocks.firstIndex(of: element!)
        clocks.remove(at: index!)
    }
    
//    @objc func saveButtonPressed() {
//        clocks[viewModel.clockId].name = nameTextField.text!
//        writeToFile(location: subUrl!)
//        title = clocks[viewModel.clockId].name
//        viewModel.collectionView.reloadData()
//    }
    
//    @objc func editTapped(_ sender:UIViewController!) {
//        let alertController:UIAlertController = UIAlertController(title: "Edit Title", message: nil, preferredStyle: UIAlertController.Style.alert)
//
//        alertController.addTextField { (textField) in
//            textField.text = clocks[self.currentIndex!].name
//        }
//
//        alertController.addAction(UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction!) in
//            clocks[self.viewModel.clockId].name = alertController.textFields![0].text!
//            self.editNameSave()
//            }))
//
//        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler:nil))
//        present(alertController, animated: true, completion: nil)
//    }


    private var currentIndex: Int?
    
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
        self.currentIndex = index!
        title = clocks[index!].name
        
        
        // (navigation bar button)
//        let btnEdit = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))
//        navigationItem.rightBarButtonItem = btnEdit

        
        
        setupView()
    }
    
    @objc func calendarButtonPressed() {
        let today = Date.init()
        let controller = CalendarPickerViewController(baseDate: today, selectedDateChanged: { [weak self] date in
            guard let self = self else { return }
            self.viewModel.today = date
//            self.tableView.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .fade)
        }, clockId: viewModel.clockId)
        
//        navigationController?.pushViewController(controller, animated: true)
        present(controller, animated: true, completion: nil)
    }
    
    private func setupView() {
        view.backgroundColor = .lightGray
        setupCollectionView()
    }
    
    
    private func setupCollectionView() {
        view.addSubview(containerView)
    
        
        containerView.addSubviews([
            timePicker,
            dateLabelFrom,
            dateLabelTo,
            datePickerFrom,
            datePickerTo,
            internDeleteButton,
            editNameButton,
            repeatDaysButton
            // saveButton,
            nameTextField,
            calendarButton
        ])
    
        
        NSLayoutConstraint.activate([
            containerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            containerView.rightAnchor.constraint(equalTo: view.rightAnchor),
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
         
            
//            timePicker.centerYAnchor.constraint(equalTo: alarmLabel.centerYAnchor),
            timePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            timePicker.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            timePicker.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 48),
            timePicker.heightAnchor.constraint(equalToConstant: 44),
            
            dateLabelFrom.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            dateLabelFrom.topAnchor.constraint(equalTo: timePicker.bottomAnchor, constant: 48),
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
            
            
            editNameButton.topAnchor.constraint(equalTo: dateLabelFrom.bottomAnchor, constant: 96),
            editNameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            editNameButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            editNameButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            
            repeatDaysButton.topAnchor.constraint(equalTo: editNameButton.bottomAnchor, constant: 16),
            repeatDaysButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            repeatDaysButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            repeatDaysButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            
            internDeleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            internDeleteButton.topAnchor.constraint(equalTo: repeatDaysButton.bottomAnchor, constant: 16),
            internDeleteButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            internDeleteButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            
            // saveButton.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10),
            // saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            calendarButton.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 10),
            calendarButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)

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
