//
//  UITextFieldExtension.swift
//  HVN MACs
//
//  Created by truong le quan on 11/8/19.
//  Copyright © 2019 Tung Nguyen. All rights reserved.
//

import Foundation
extension UITextField
{
    /// Set color for specific text field
    func setTextColorForIos13(nameColor: String)
    {
        if #available(iOS 11.0, *) {
            self.textColor = UIColor.init(named: nameColor)
        }
    }
    
    /// Set system color for label text field
    func setTextColorToSystemColor()
    {
        if #available(iOS 13.0, *) {
            self.setTextColorForIos13(nameColor: ColorName.BlackGrayText)
        }
    }
    
    /// Set color for place holder
    func setTextColorForPlaceHolder(stringText: String, nameColor: String)
    {
        if #available(iOS 13.0, *) {
            self.attributedPlaceholder = NSAttributedString(string: stringText, attributes: [NSAttributedStringKey.foregroundColor : UIColor.init(named: nameColor)])
        }
    }
}
