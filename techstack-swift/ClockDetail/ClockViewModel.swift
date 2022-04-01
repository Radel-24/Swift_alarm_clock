//
//  ClockViewModel.swift
//  techstack-swift
//
//  Created by Alexander Kurz on 3/30/22.
//

import Foundation
import UIKit

class ClockViewModel {
    let clock: Clock
    let collectionView: UICollectionView
    public var today: Date


    init(clock: Clock, collectionView: UICollectionView) {
        self.clock = clock
        self.collectionView = collectionView
        today = Date.init()
    }
    
    var clockId: UUID {
        clock.id
    }
    
//    var clockDate: Date {
//        today
//    }
    
}
