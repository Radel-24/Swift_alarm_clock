//
//  File.swift
//  techstack-swift
//
//  Created by Marcus Hopp on 23.03.22.
//

import Foundation

public extension Array {
    func safeRef (_ index: Int) -> Element? {
        return 0 <= index && index < count ? self[index] : nil
    }
}
