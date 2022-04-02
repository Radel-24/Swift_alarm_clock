//
//  UserViewModel.swift
//  techstack-swift
//
//  Created by Marcus Hopp on 25.03.22.
//

import Foundation

class UserViewModel {
    private let user: User
    
    var name: String {
        user.name
    }
    
    var age: Int {
        user.age
    }
    
    var startedAt: String {
        user.startedAt
    }
    
    var technologies: [Clock] {
        user.technologies
    }
    
    var email: String {
        user.email
    }
    
    init(user: User) {
        self.user = user
    }
    
    func itemAt(_ index: Int) -> Clock? {
        guard let item = user.technologies.safeRef(index) else { return nil }
        return item
    }
}
