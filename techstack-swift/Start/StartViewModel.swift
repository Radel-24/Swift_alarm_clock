//
//  StartViewModel.swift
//  techstack-swift
//
//  Created by Marcus Hopp on 23.03.22.
//

import Foundation

class StartViewModel {
    var technologies: [Technology]?
    
    var numberOfItems: Int {
        technologies?.count ?? 0
    }
    
    func itemAt(_ index: Int) -> Technology? {
        guard let item = technologies?.safeRef(index) else { return nil }
        return item
    }
    
    init() {
        technologies = DecodeHelper.load("Technology.json")
    }
    
}
