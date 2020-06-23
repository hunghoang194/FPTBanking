//
//  FBLoginResponse.swift
//  FPT Banking
//
//  Created by Hung Hoang on 6/23/20.
//  Copyright © 2020 hưng hoàng. All rights reserved.
//

import Foundation
import ObjectMapper

class LoginResponse: Mappable {
    var user: FBUser?
    var auth: FBAuth?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        user <- map["user"]
        auth <- map["auth"]
    }
}
