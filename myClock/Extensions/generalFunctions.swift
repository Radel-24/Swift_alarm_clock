//
//  generalFunctions.swift
//  myClock
//
//  Created by Robin Adelwarth on 4/24/22.
//

import Foundation

func removeClocksInPast() {
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
