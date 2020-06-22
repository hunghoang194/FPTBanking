//
//  KPDropMenuExtension.swift
//  HVN MACs
//
//  Created by truong le quan on 11/6/19.
//  Copyright © 2019 Tung Nguyen. All rights reserved.
//

import Foundation

extension KPDropMenu
{
    /// Set text to default text ios 13
    func setTextToLabelColor()
    {
        if #available(iOS 13.0, *) {
            self.itemTextColor = .label
        } else {
            self.itemTextColor = UIColor.darkText
        }
    }
    
    /// Set background to default background ios 13
    func setBackgroundToDefaultBackgroundColor()
    {
        if #available(iOS 13.0, *) {
            self.itemBackground = .systemBackground
        }
    }
    
    /// Set title color in ios 13
    func setTitleColor()
    {
        if #available(iOS 13, *) {
            self.titleColor = UIColor.init(named: ColorName.NameColor)
        } else {
            self.titleColor = UIColor.init(hex: "#E92238")
        }
    }
    
    /// Set default background color
    func setDefaultItemBackgroundColor()
    {
        if #available(iOS 13, *) {
            self.itemBackground = UIColor.init(named: ColorName.BigButtonColor)
        } else {
            self.itemBackground = UIColor.white
        }
    }
    
    override open func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        didTapBackground()
    }
}
