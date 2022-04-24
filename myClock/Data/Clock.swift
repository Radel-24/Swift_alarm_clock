//
//  Clock.swift
//  myClock
//
//  Created by Robin Adelwarth on 3/28/22.
//

import Foundation

struct Clock: Codable, Identifiable, Hashable {
    var id: UUID
    var name: String
    var daysOfWeek: [Int]
    var ringDays: [DateComponents]
    var isActivated: Bool
    var ringTime: DateComponents
    var notificationId: String
    var selectedDays: [Bool]
    var selectedRingtone: [Bool]
}


