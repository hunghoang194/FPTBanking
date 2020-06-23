//
//  FBAuth.swift
//  FPT Banking
//
//  Created by Hung Hoang on 6/23/20.
//  Copyright © 2020 hưng hoàng. All rights reserved.
//

import Foundation
import ObjectMapper

class FBAuth: Mappable {
    var tokenType: String?
    var expiresIn: Int?
    var accessToken: String?
    var refreshToken: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        tokenType <- map["token_type"]
        expiresIn <- map["expires_in"]
        accessToken <- map["access_token"]
        refreshToken <- map["refresh_token"]
    }
}
