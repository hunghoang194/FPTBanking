//
//  UILabelExtension.swift
//  HVN MACs
//
//  Created by truong le quan on 11/7/19.
//  Copyright © 2019 Tung Nguyen. All rights reserved.
//

import Foundation
extension UILabel
{
    /// Set color for specific label text
    func setTextColorForIos13(nameColor: String, defaultColor: UIColor? = nil)
    {
        if #available(iOS 11.0, *) {
            self.textColor = UIColor.init(named: nameColor)
        } else {
            if let color = defaultColor {
                self.textColor = color
            }
        }
    }
    
    /// Set system color for label text
    func setTextColorToSystemColor()
    {
        if #available(iOS 13.0, *) {
            self.setTextColorForIos13(nameColor: ColorName.BlackGrayText)
        }
    }
}
