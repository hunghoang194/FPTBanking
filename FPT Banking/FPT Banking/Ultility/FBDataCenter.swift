//
//  FBDataCenter.swift
//  FPT Banking
//
//  Created by Hung Hoang on 6/22/20.
//  Copyright © 2020 hưng hoàng. All rights reserved.
//

import UIKit

class FBDataCenter: NSObject {
    var token:String = ""
    var userInfo:FBUserProfile?
    class var sharedInstance :FBDataCenter {
        struct Singleton {
            static let instance = FBDataCenter.init()
        }
        return Singleton.instance
    }

}
