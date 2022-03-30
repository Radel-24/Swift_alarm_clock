//
//  ClockViewModel.swift
//  techstack-swift
//
//  Created by Alexander Kurz on 3/30/22.
//

import Foundation

class ClockViewModel {
    private let technology: Clock
    private let usersWithTechnology: [User]
    
    init(technology: Clock) {
        self.technology = technology
        let users = DecodeHelper.load("User.json") as [User]
        usersWithTechnology = users.filter({$0.technologies.contains(where: {$0.id == technology.id})})
    }
    
    var technologyName: String {
        technology.name
    }
    
    var numberOfUsers: Int {
        usersWithTechnology.count
    }
    
    func userAt(_ index: Int) -> User? {
        return usersWithTechnology.safeRef(index) ?? nil
    }
}
