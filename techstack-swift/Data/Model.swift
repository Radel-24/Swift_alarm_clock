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
}

struct User: Codable, Identifiable {
    var id: Int
    var name: String
    var age: Int
    var startedAt: String
    var email: String
    var technologies: [Clock]
}

struct StackOverFlowItem: Codable, Identifiable, Hashable {
    var id: Int
    var name: String
    var url: String
}
