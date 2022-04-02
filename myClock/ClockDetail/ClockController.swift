//
//  ClockController.swift
//  techstack-swift
//
//  Created by Alexander Kurz on 3/30/22.
//

import UIKit
import SwiftUI

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
        time.addTarget(self, action: #selector(timePickerChanged(picker:)), for: .valueChanged)
        return time
    }()

    @objc func timePickerChanged(picker: UIDatePicker) {
        let clockIndex = clocks.firstIndex(where: {$0.id == viewModel.clockId})
        clocks[clockIndex!].ringTime = Calendar.current.dateComponents([.hour, .minute], from: picker.date)
    }


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

        btn.backgroundColor = .white
        btn.layer.cornerRadius = 5
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.black.cgColor

        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Calendar View", for: .normal)
//        btn.setTitleColor(.red, for: .normal)
        btn.addTarget(self, action: #selector(calendarButtonPressed), for: .touchUpInside)
        return btn
    }()



    @objc func alertTextField(_ sender:UIButton!) {
        let alertController:UIAlertController = UIAlertController(title: "Edit Title", message: nil, preferredStyle: UIAlertController.Style.alert)

        alertController.addTextField { (textField) in
            textField.text = clocks[self.currentIndex!].name
        }
        let clockIndex = clocks.firstIndex(where: {$0.id == viewModel.clockId})
        alertController.addAction(UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction!) in
            clocks[clockIndex!].name = alertController.textFields![0].text!
            self.editNameSave()
            }))

        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler:nil))
        present(alertController, animated: true, completion: nil)
    }

    func editNameSave() {
        let clockIndex = clocks.firstIndex(where: {$0.id == viewModel.clockId})
            writeToFile(location: subUrl!)
            title = clocks[clockIndex!].name
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
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let clockIndex = clocks.firstIndex(where: {$0.id == viewModel.clockId})
        let timer = String(clocks[clockIndex!].ringTime.hour!) + ":" + String(clocks[clockIndex!].ringTime.minute!)
        timePicker.date = dateFormatter.date(from: timer)!
    }

    private func setupCollectionView() {
        view.addSubview(containerView)


        containerView.addSubviews([
            timePicker,
            internDeleteButton,
            editNameButton,
            repeatDaysButton,
            calendarButton
        ])


        NSLayoutConstraint.activate([
            containerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            containerView.rightAnchor.constraint(equalTo: view.rightAnchor),
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            timePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timePicker.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 96),

            editNameButton.topAnchor.constraint(equalTo: timePicker.bottomAnchor, constant: 96),
//            editNameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            editNameButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            editNameButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),

            repeatDaysButton.topAnchor.constraint(equalTo: editNameButton.bottomAnchor, constant: 16),
//            repeatDaysButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            repeatDaysButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            repeatDaysButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),

            calendarButton.topAnchor.constraint(equalTo: repeatDaysButton.bottomAnchor, constant: 16),
//            calendarButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            calendarButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            calendarButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),

//            internDeleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            internDeleteButton.topAnchor.constraint(equalTo: calendarButton.bottomAnchor, constant: 16),
            internDeleteButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            internDeleteButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16)

        ])
    }
}


//struct ClockController_Previews: PreviewProvider {
//    static var previews: some View {
//        Text("Hello, World!")
//    }
//}
