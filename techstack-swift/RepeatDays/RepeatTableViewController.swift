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
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "dayCell")

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        
        writeToFile(location: subUrl!)
    }
    
    override func viewWillDisappear(_ animated: Bool) {

        let calendar = Calendar(identifier: .gregorian)
        
//        let todaysWeekdayIndex = calendar.component(.weekday, from: Date())
        
        var i = 1
        var weekdaysToActivate: [Int] = []
        for state in clocks[currentClockIndex].selectedDays {
            if (state == true) {
                weekdaysToActivate.append(i)
            }
            i += 1
        }
        
        let today = Date()
       
        
//        print("todays day: \(day ?? <#default value#>)")
//        print("todays date: \(date)")
//        print("friday: \(todaysWeekdayIndex)")
        print(weekdaysToActivate)
        print("\n")
        
        
        for index in 0...100 {
            let checkDate = today.advanced(by: TimeInterval((index * 3600 * 24)))
            let weekIndex = calendar.component(.weekday, from: checkDate)
            if (weekdaysToActivate.contains(weekIndex)) {
                clocks[currentClockIndex].ringDays.append(checkDate)
            }
        }
        writeToFile(location: subUrl!)
        
        print(clocks[currentClockIndex].ringDays)
        
//        if (weekdaysToActivate.count > 0) {
//            for each in weekdaysToActivate {
//                let diff = day! - each
//            }
//        }
        
        
//        print(clocks[currentClockIndex].selectedDays)
//        print("date: \(date)")

//        print(todaysWeekday)
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
