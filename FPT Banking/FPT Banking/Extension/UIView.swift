//
//  UIView.swift
//  FPT Banking
//
//  Created by Hung Hoang on 6/19/20.
//  Copyright © 2020 hưng hoàng. All rights reserved.
//

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
    func setGradientBackground(colorTop: UIColor, colorBottom: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorBottom.cgColor, colorTop.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = bounds

       layer.insertSublayer(gradientLayer, at: 0)
    }

}

