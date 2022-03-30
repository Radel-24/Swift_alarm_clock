//
//  File.swift
//  techstack-swift
//
//  Created by Marcus Hopp on 24.03.22.
//

import Foundation

class ClockDetailViewModel {
    private let clock: Clock


    init(clock: Clock) {
        self.clock = clock
        
    }
    var clockId: Int {
        clock.id
    }


}
