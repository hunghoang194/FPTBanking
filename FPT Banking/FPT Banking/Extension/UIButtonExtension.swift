//
//  UIButtonExtension.swift
//  HVN MACs
//
//  Created by truong le quan on 11/7/19.
//  Copyright © 2019 Tung Nguyen. All rights reserved.
//

import Foundation

extension UIButton
{
    /// Set color for specific button text
    func setTextColorForIos13(nameColor: String)
    {
        if #available(iOS 11.0, *) {
            self.setTitleColor(UIColor.init(named: nameColor), for: .normal)
        }
    }
    
    /// Set system color for button text
    func setTextColorToSystemColor()
    {
        if #available(iOS 13.0, *) {
            self.setTextColorForIos13(nameColor: ColorName.BlackGrayText)
        }
    }
}
