//
//  RepeatTableViewController.swift
//  techstack-swift
//
//  Created by Alexander Kurz on 4/1/22.
//

import UIKit

class RepeatTableViewController: UITableViewController {

    let viewModel = RepeatTableViewModel()
    let currentClockIndex: Int
    
    init(index: Int) {
        
        self.currentClockIndex = index
        self.weekdaysToActivate = []
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    @objc func backAction(sender: UIBarButtonItem) {
//
////        let alertController = UIAlertController(title: "Are You Sure?", message: "If You Proceed, All Data On This Page Will Be Lost", preferredStyle: .alert)
////        let okAction = UIAlertAction(title: "Ok", style: .default) { (result : UIAlertAction) -> Void in
////            self.navigationController?.popViewController(animated: true)
////        }
////
////        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
////        alertController.addAction(cancelAction)
////        alertController.addAction(okAction)
////        self.present(alertController, animated: true)
//        overrideAlertMessage()
//        self.navigationController?.popViewController(animated: true)
//    }
    
    
    
//    @objc func back(sender: UIBarButtonItem) {
//
//        getRingDays()
//        setRingDays()
//        writeToFile(location: subUrl!)
//        overrideAlertMessage()
////        _ = navigationController?.popViewController(animated: true)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.navigationItem.hidesBackButton = true
//        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.backAction(sender:)))
//        self.navigationItem.leftBarButtonItem = newBackButton
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "dayCell")

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//         self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel.repeatDays.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dayCell", for: indexPath)

        
        cell.textLabel?.text = viewModel.repeatDays[indexPath.row]
        if (clocks[currentClockIndex].selectedDays[indexPath.row] == true) {
            cell.accessoryType = .checkmark
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Unselect the row.
        tableView.deselectRow(at: indexPath, animated: false)
        
        // remove the checkmark
        if (clocks[currentClockIndex].selectedDays[indexPath.row] == true) {
            let cell = tableView.cellForRow(at: indexPath)
            cell!.accessoryType = .none
            clocks[currentClockIndex].selectedDays[indexPath.row] = false
        }
        // Mark the newly selected filter item with a checkmark.
        else if (clocks[currentClockIndex].selectedDays[indexPath.row] == false) {
            let cell = tableView.cellForRow(at: indexPath)
            cell!.accessoryType = .checkmark
            clocks[currentClockIndex].selectedDays[indexPath.row] = true
        }
    }
    
    private func getRingDays() {
        var i = 1
        for state in clocks[currentClockIndex].selectedDays {
            if (state == true) {
                weekdaysToActivate.append(i)
            }
            i += 1
        }
    }
    
    private func setRingDays() {
        let todaysIndex = Calendar.current.dateComponents([.weekday], from: Date.init()).weekday
        let beginShift = 1 - todaysIndex!
        let beginDate = Date.init().advanced(by: TimeInterval((beginShift * 3600 * 24)))
        
        for index in 0...1000 {
            let checkIndex = (index % 7) + 1
            let checkDate = toDateComponent(date: beginDate.advanced(by: TimeInterval((index * 3600 * 24))))

            if (weekdaysToActivate.contains(checkIndex)) {
                if (!clocks[currentClockIndex].ringDays.contains(checkDate)) {
                    clocks[currentClockIndex].ringDays.append(checkDate)
                }
            }
        }
    }
    
    private func removeClocksInPast() {
        let today = Calendar.current.dateComponents([.year, .month, .day], from: Date.init())
        for clock in clocks {
            for date in clock.ringDays {
                if (date < today){
                    let indexClock = clocks.firstIndex(where: {$0.id == clock.id})
                    let indexDate = clocks[indexClock!].ringDays.firstIndex(where: {$0 == date})
                    clocks[indexClock!].ringDays.remove(at: indexDate!)
                }
            }
        }
    }
    
    var weekdaysToActivate: [Int]
    
    
    override func viewWillDisappear(_ animated: Bool) {

        getRingDays()
        clocks[currentClockIndex].ringDays = []
        setRingDays()
        removeClocksInPast()
        writeToFile(location: subUrl!)
    }

}
