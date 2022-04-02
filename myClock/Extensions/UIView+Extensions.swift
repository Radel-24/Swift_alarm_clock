//
//  View+Extensions.swift
//  techstack-swift
//
//  Created by Marcus Hopp on 23.03.22.
//

import UIKit


extension UIView {
    func addSubviews(_ viewsToAdd: [UIView]) {
        viewsToAdd.forEach({addSubview($0)})
    }
}
