//
//  ClockViewModel.swift
//  techstack-swift
//
//  Created by Alexander Kurz on 3/30/22.
//

import Foundation
import UIKit

class ClockViewModel {
    private let clock: Clock
    private let collectionView: UICollectionView


    init(clock: Clock, collectionView: UICollectionView) {
        self.clock = clock
        self.collectionView = collectionView

    }
    var clockId: Int {
        clock.id
    }




}
