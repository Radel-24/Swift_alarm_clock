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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
//    private func setRingDays() {
//        let indexClock = clocks.firstIndex(where: {$0.id == clockId})
//        for day in days {
//            for ringDay in clocks[indexClock!].ringDays {
//                let dayForm = Calendar.current.dateComponents([.year, .month, .day], from: day.date)
//                let ringDayForm = Calendar.current.dateComponents([.year, .month, .day], from: ringDay)
//                if (dayForm == ringDayForm) {
//                    let daysIndex = days.firstIndex(where: {$0.date == day.date})
//                    days[daysIndex!].isSelected = true
//                    print("ADDED")
//                    break
//                }
//            }
//        }
//    }
    
    

    
    
    // CONTINUE HERE !!!!!!!!!!!!
//    private func setRingDays() {
//
//        let indexClock = clocks.firstIndex(where: {$0.id == clockId})
//
//        var tempRingDays: [String] = []
//
//        for element in clocks[indexClock!].ringDays {
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "dd.MM.yyyy"
//            let day = dateFormatter.string(from: element)
//            tempRingDays.append(day)
//        }
//
//        for day in days {
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "dd.MM.yyyy"
//            let formattedDay = dateFormatter.string(from: day.date)
//
//            if (tempRingDays.contains(formattedDay)) {
//                let daysIndex = days.firstIndex(where: {$0.date == day.date})
//                days[daysIndex!].isSelected = true
//            }
//        }
//    }
    

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
        
        writeToFile(location: subUrl!)
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
        
        let begin = 1 - todaysIndex!
        let beginDate = Date.init().advanced(by: TimeInterval((begin * 3600 * 24)))
        
        for index in 0...100 {
            let checkIndex = index % 7
            let checkDate = toDateComponent(date: beginDate.advanced(by: TimeInterval((index * 3600 * 24))))
            

            if (weekdaysToActivate.contains(checkIndex + 1)) {
                if (!clocks[currentClockIndex].ringDays.contains(checkDate)) {
                    clocks[currentClockIndex].ringDays.append(checkDate)
                }
            }
        }
    }
    
    var weekdaysToActivate: [Int]
    
//    private func overrideAlertMessage() {
//        let alertController:UIAlertController = UIAlertController(title: "Override", message: "Settings will be overwritten", preferredStyle: UIAlertController.Style.alert)
//
//        alertController.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.destructive, handler: { (action: UIAlertAction!) in
//            clocks[self.currentClockIndex].ringDays = []
//            self.setRingDays()
//            }))
//        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler:nil))
//        present(alertController, animated: true, completion: nil)
//    }
    
    
    override func viewWillDisappear(_ animated: Bool) {

        getRingDays()
        clocks[currentClockIndex].ringDays = []
        setRingDays()
//        overrideAlertMessage()
        writeToFile(location: subUrl!)
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
