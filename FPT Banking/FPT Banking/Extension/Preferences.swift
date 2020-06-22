//
//  Preferences.swift
//  NewProject
//
//  Created by Admin on 4/23/20.
//  Copyright © 2020 hưng hoàng. All rights reserved.
//

import UIKit
class Preferences {
    var userModel:FBUserProfile?
    static let sharedInstance: Preferences = {
        let instance = Preferences()
        return instance
    }()
    
    static var LoginStoryboard: UIStoryboard {
        get {
            return UIStoryboard(name: "Login", bundle: nil)
        }
    }
    
    static var MainStoryboard: UIStoryboard {
        get {
            return UIStoryboard(name: "Main", bundle: nil)
        }
    }
}
