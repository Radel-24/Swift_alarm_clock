//
//  Model.swift
//  techstack
//
//  Created by Marcus Hopp on 21.03.22.
//

import Foundation

struct Clock: Codable, Identifiable, Hashable {
    var id: UUID
    var name: String
    var daysOfWeek: [Int]
    var ringDays: [Date]
    var isActivated: Bool
    var ringTime: DateComponents
    var notificationId: String
    var selectedDays: [Bool]
}


