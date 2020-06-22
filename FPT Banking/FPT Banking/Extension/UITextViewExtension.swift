//
//  UITextViewExtension.swift
//  HVN MACs
//
//  Created by truong le quan on 11/9/19.
//  Copyright © 2019 Tung Nguyen. All rights reserved.
//

import Foundation

extension UITextView
{
    /// Set color for specific text view
    func setTextColorForIos13(nameColor: String)
    {
        if #available(iOS 11.0, *) {
            self.textColor = UIColor.init(named: nameColor)
        }
    }
    
    /// Set system color for label text view
       func setTextColorToSystemColor()
       {
           if #available(iOS 13.0, *) {
               self.setTextColorForIos13(nameColor: ColorName.BlackGrayText)
           }
       }
}
