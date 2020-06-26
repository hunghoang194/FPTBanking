//
//  UIView.swift
//  FPT Banking
//
//  Created by Hung Hoang on 6/19/20.
//  Copyright © 2020 hưng hoàng. All rights reserved.
//
import Foundation
import UIKit
extension UIView {
    func layout(using constraints: [NSLayoutConstraint]) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
    }
    /// addShadow and make boder
    func addShadow(shadowColor: UIColor, offSet: CGSize, opacity: Float, shadowRadius: CGFloat, cornerRadius: CGFloat, corners: UIRectCorner = [], fillColor: UIColor = .white) {

        let shadowLayer = CAShapeLayer()
        let size = CGSize(width: cornerRadius, height: cornerRadius)
        let cgPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: size).cgPath //1
        shadowLayer.path = cgPath //2
        shadowLayer.fillColor = fillColor.cgColor //3
        shadowLayer.shadowColor = shadowColor.cgColor //4
        shadowLayer.shadowPath = cgPath
        shadowLayer.shadowOffset = offSet //5
        shadowLayer.shadowOpacity = opacity
        shadowLayer.shadowRadius = shadowRadius
        self.layer.addSublayer(shadowLayer)
    }
    /// make boder
    func round(corners: UIRectCorner, cornerRadius: Double) {
        let size = CGSize(width: cornerRadius, height: cornerRadius)
        let bezierPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: size)
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = self.bounds
        shapeLayer.path = bezierPath.cgPath
        self.layer.mask = shapeLayer
    }

    func circle() {
        layer.cornerRadius = min(bounds.width, bounds.height) / 2
        layer.masksToBounds = true
    }
    
    func circle(cornerRadius: Float) {
        layer.cornerRadius = CGFloat(cornerRadius)
        layer.masksToBounds = true
    }

    func setBorder(color: UIColor, width: CGFloat, cornerRadius: CGFloat = 0, isCircle: Bool = false, mutilColorName: String? = nil) {
        self.layer.borderColor = color.cgColor
        
        if let colorName = mutilColorName {
            if #available(iOS 11.0, *) {
                self.layer.borderColor = UIColor.init(named: colorName)?.cgColor
            }
        }
        
        self.layer.borderWidth = width

        if isCircle {
            self.circle()
        } else {
            self.layer.cornerRadius = cornerRadius
        }

    }
    
    func setViewCornerRadiusWithShadow(
        shadowColor: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.05),
        shadowRadius: CGFloat = 10,
        cornerRadius: CGFloat = 0,
        shadowOffSet: CGSize = CGSize(width: 5, height: 5),
        shadowOpacity: Float = 1,
        isCircle: Bool = false) {
//        let BKGColor = self.backgroundColor
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = shadowOffSet
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = shadowOpacity
        if isCircle {
            layer.cornerRadius = min(bounds.width, bounds.height) / 2
        } else {
            self.layer.cornerRadius = cornerRadius
        }
//        self.backgroundColor = BKGColor
    }
    // Using a function since `var image` might conflict with an existing variable
    // (like on `UIImageView`)
    func asImage() -> UIImage {
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(bounds: bounds)
            return renderer.image { rendererContext in
                layer.render(in: rendererContext.cgContext)
            }
        } else {
            UIGraphicsBeginImageContext(self.frame.size)
            self.layer.render(in: UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return UIImage(cgImage: image!.cgImage!)
        }
    }
    func copyView<T: UIView>() -> T {
        return NSKeyedUnarchiver.unarchiveObject(with: NSKeyedArchiver.archivedData(withRootObject: self)) as! T
    }
    func setGradientBackground(colorLeft: UIColor, colorRight: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorLeft.cgColor, colorRight.cgColor]
        gradientLayer.startPoint = CGPoint(x: 1, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 0.0)
        gradientLayer.locations = [0, 0.5]
        gradientLayer.frame = bounds

       layer.insertSublayer(gradientLayer, at: 0)
    }
}
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

