//
//  FBMainViewController.swift
//  FPT Banking
//
//  Created by Hung Hoang on 6/22/20.
//  Copyright © 2020 hưng hoàng. All rights reserved.
//

import UIKit
import Firebase

class FBMainViewController: UINavigationController,SlideMenuControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        for view in view.subviews {
            view.clipsToBounds = true
        }
        view.clipsToBounds = true
        if #available(iOS 11.0, *) {
            view.backgroundColor = UIColor.init(named: ColorName.NavigationBackgroundColor)
        } else {
            // Fallback on earlier versions
            view.backgroundColor = RED_COLOR
        }
        let rootVC = UIStoryboard.init(name: AppDelegate.sharedInstance.storyboardName, bundle: nil).instantiateViewController(withIdentifier: "FBLoginViewController") as! FBLoginViewController
        self.viewControllers = [rootVC]
    }
    
    
    func leftWillOpen() {
        
    }
    func leftDidClose() {
        
    }
}
