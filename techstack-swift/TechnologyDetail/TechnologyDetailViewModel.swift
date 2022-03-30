//
//  File.swift
//  techstack-swift
//
//  Created by Marcus Hopp on 24.03.22.
//

import Foundation

class TechnologyDetailViewModel {
    private let technology: Technology
    private let usersWithTechnology: [User]
    
    init(technology: Technology) {
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
