//
//  UIView+Shadow.swift
//  EcommerceApp
//
//  Created by Beyza Nur Tekerek on 25.05.2025.
//

import UIKit

extension UIView {
    func applyShadow(
        color: UIColor = .black,
        alpha: Float = 0.2,
        x: CGFloat = 0,
        y: CGFloat = 2,
        blur: CGFloat = 4,
        spread: CGFloat = 0,
        cornerRadius: CGFloat? = nil
    ) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = alpha
        layer.shadowOffset = CGSize(width: x, height: y)
        layer.shadowRadius = blur / 2.0

        let radius = cornerRadius ?? layer.cornerRadius

        if spread == 0 {
            layer.shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            let path = UIBezierPath(roundedRect: rect, cornerRadius: radius)
            layer.shadowPath = path.cgPath
        }
    }
}
