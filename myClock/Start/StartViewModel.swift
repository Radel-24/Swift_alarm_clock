//
//  StartViewModel.swift
//  techstack-swift
//
//  Created by Marcus Hopp on 23.03.22.
//

import Foundation

var clocks: [Clock] = []
var subUrl: URL?
var cells: [ClockCell] = []

class StartViewModel {
    var fm = FileManager.default
    var mainUrl: URL? = Bundle.main.url(forResource: "Clocks", withExtension: "json")

//    var numberOfItems: Int {
//        clocks?.count ?? 0
//    }

    func itemAt(_ index: Int) -> Clock? {
        guard let item = clocks.safeRef(index) else { return nil }
        return item
    }

    init() {
//        clocks = DecodeHelper.load("Clocks.json")
        getData()
    }

    func loadFile(mainPath: URL, subPath: URL){
        if fm.fileExists(atPath: subPath.path){
            decodeData(pathName: subPath)

            if clocks.isEmpty{
                decodeData(pathName: mainPath)
            }

        }else{
            decodeData(pathName: mainPath)
        }

//        self.tableView.reloadData()
    }

    func decodeData(pathName: URL){
           do{
               let jsonData = try Data(contentsOf: pathName)
               let decoder = JSONDecoder()
               clocks = try decoder.decode([Clock].self, from: jsonData)
           } catch {}
       }

//    guard let mainUrl = Bundle.main.url(forResource: "Clocks", withExtension: "json") else { return }

    func getData() {
        do {
            let documentDirectory = try fm.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
            subUrl = documentDirectory.appendingPathComponent("Clocks.json")
            loadFile(mainPath: mainUrl!, subPath: subUrl!)
        } catch {
            print(error)
        }
    }

}




