//
//  UIStackView+Extension.swift
//  techstack-swift
//
//  Created by Marcus Hopp on 25.03.22.
//

import UIKit


extension UIStackView {
    func addArrangedSubviews(_ viewsToAdd: [UIView]) {
        viewsToAdd.forEach({addArrangedSubview($0)})
    }
}
