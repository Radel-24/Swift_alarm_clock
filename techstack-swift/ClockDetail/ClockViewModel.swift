//
//  ClockViewModel.swift
//  techstack-swift
//
//  Created by Alexander Kurz on 3/30/22.
//

import Foundation

class ClockViewModel {
    private let clock: Clock


    init(clock: Clock) {
        self.clock = clock
        
    }
    var clockId: Int {
        clock.id
    }


}
