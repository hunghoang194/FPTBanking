//
//  AvatarViewExtension.swift
//  HVN MACs
//
//  Created by VINICORP on 11/7/19.
//  Copyright © 2019 Tung Nguyen. All rights reserved.
//

import Foundation

extension AvatarView {

    // Set background to default background ios 13
    func setBackgroundToDefaultBackgroundColor()
    {
        if #available(iOS 13.0, *) {
            self.inputView?.backgroundColor = .systemBackground
        }
    }
}
