//
//  CollectionView+.swift
//  EcommerceApp
//
//  Created by Beyza Nur Tekerek on 25.05.2025.
//

import UIKit

public extension UICollectionViewCell {
    static var identifier: String {
        String(describing: type(of: self))
    }
}
