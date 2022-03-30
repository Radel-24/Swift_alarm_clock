//
//  Model.swift
//  techstack
//
//  Created by Marcus Hopp on 21.03.22.
//

import Foundation

struct Clock: Codable, Identifiable, Hashable {
    var id: Int
    var name: String
    var daysOfWeek: [Int]
}


