//
//  writeToFile.swift
//  techstack-swift
//
//  Created by Alexander Kurz on 3/31/22.
//

import UIKit


func writeToFile(location: URL) {
    do {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let JsonData = try encoder.encode(clocks)
        try JsonData.write(to: location)
    }catch{}
}
