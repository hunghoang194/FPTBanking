//
//  FBLogin.swift
//  FPT Banking
//
//  Created by hưng hoàng on 6/30/20.
//  Copyright © 2020 hưng hoàng. All rights reserved.
//

import Foundation
import SwiftyJSON

public class FBLogin: NSObject {
    var accessToken: String?
    var status: Int?
    var messages: String?
    var roles: String?
    var loggedInFailedTime: Int?
    // MARK: - Declaration for string constants to be used to decode and also serialize.
    private let FBAccessToken: String = "accessToken"
    private let FBStatus: String = "status"
    private let FBMessages: String = "messgages"
    private let FBRoles: String = "roles"
    private let FBLoggedInFailedTime : String = "loggedInFailedTime"
    // MARK: SwiftyJSON Initalizers
    /**
     Initates the instance based on the object
     - parameter object: The object of either Dictionary or Array kind that was passed.
     - returns: An initalized instance of the class.
    */
    convenience public init(object: Any) {
      self.init(json: JSON(object))
    }
    public init(json: JSON) {
        accessToken = json[FBAccessToken].string
         status = json[FBStatus].int
         messages = json[FBMessages].string
         roles = json[FBRoles].string
        loggedInFailedTime = json[FBLoggedInFailedTime].int
    }
}
