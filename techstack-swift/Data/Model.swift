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
<<<<<<< HEAD
    var daysOfWeek: [Int]
}

=======
}

struct User: Codable, Identifiable {
    var id: Int
    var name: String
    var age: Int
    var startedAt: String
    var email: String
    var technologies: [Clock]
}
>>>>>>> 3f0af2c60060c363bb92d22b79f5a7200caaa255

