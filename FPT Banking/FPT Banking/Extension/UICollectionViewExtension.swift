//
//  UICollectionViewExtension.swift
//  HVN MACs
//
//  Created by VINICORP on 11/8/19.
//  Copyright © 2019 Tung Nguyen. All rights reserved.
//

import Foundation

extension UICollectionView {
    /// Set Background view to system color
    func setDefaultColor()
    {
        if #available(iOS 13.0, *) {
            self.backgroundColor = UIColor.systemBackground
        }
    }
}
