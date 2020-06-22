//
//  UIViewExtension.swift
//  HVN MACs
//
//  Created by truong le quan on 11/6/19.
//  Copyright © 2019 Tung Nguyen. All rights reserved.
//

import Foundation

/// Setting view color for darkmode
extension UIView
{
    /// Set background view for custom color set
    func setMutilColorForView(nameColor: String)
    {
        if #available(iOS 11.0, *) {
            self.backgroundColor = UIColor.init(named: nameColor)
        }
    }
    
    /// Set Background view to system color
    func setColorSystemForView()
    {
        if #available(iOS 13.0, *) {
            self.backgroundColor = UIColor.systemBackground
        }
    }
    
    /// Set shadow color for layout view
    func setShadowColorForLayoutView(nameColor: String)
    {
        if #available(iOS 11.0, *) {
            self.layer.shadowColor = UIColor.init(named: nameColor)?.cgColor
        }
    }
    
    /// Set border color for layout view
    func setBorderColorForLayoutView(nameColor: String)
    {
        if #available(iOS 11.0, *) {
            self.layer.borderColor = UIColor.init(named: nameColor)?.cgColor
        } else {
            self.layer.borderColor = UIColor.init(hex: "E5E5E5").cgColor
        }
    }
    
    /// Set shadow view in login screen
    func setShadowForLoginView()
    {
        if #available(iOS 13.0, *) {
            if traitCollection.userInterfaceStyle == .dark  {
                self.layer.shadowColor = UIColor.systemBackground.cgColor
            } else {
               self.layer.shadowColor = UIColor(red:0, green:0, blue:0, alpha:0.05).cgColor
            }
        } else {
            self.layer.shadowColor = UIColor(red:0, green:0, blue:0, alpha:0.05).cgColor
        }
    }
    
    // set view Corner Radius
    func setViewCornerRadius() {
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        self.layer.shadowRadius = 10.0
        self.layer.shadowOpacity = 0.4
        self.layer.cornerRadius = 10.0
        self.setMutilColorForView(nameColor: ColorName.BigButtonColor)
    }
    
    // set view Corner Radius
    func setViewCornerRadiusChangePass() {
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        self.layer.shadowRadius = 20.0
        self.layer.shadowOpacity = 0.4
        self.layer.cornerRadius = 20.0
        self.setMutilColorForView(nameColor: ColorName.BigButtonColor)
    }
    func drawDottedLine(defaultColor: UIColor = UIColor(hex: ColorName.hexName.gray5), multileColor: String = ColorName.Gray5Gray3) {
        let point = CGPoint.init(x: 0, y: 0)
        let point1 = CGPoint.init(x: self.frame.width == 1 ? 0 : self.frame.width, y: self.frame.height == 1 ? 0 : self.frame.height)
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = defaultColor.cgColor
        if #available(iOS 11.0, *) {
            shapeLayer.strokeColor = UIColor.init(named: multileColor)?.cgColor
        }
        shapeLayer.lineWidth = 1
        shapeLayer.lineDashPattern = [3, 3] // [0] is the length of dash,[1] is length of the gap.

        let path = CGMutablePath()
        path.addLines(between: [point, point1])
        shapeLayer.path = path
        self.layer.addSublayer(shapeLayer)
        self.clipsToBounds = true
    }
}
