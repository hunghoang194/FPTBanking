//
//  MyAUserProfile.swift
//  MyApp
//
//  Created by Admin on 4/24/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import SwiftyJSON

public class FBUserProfile: NSObject {
    // MARK: - Properties
    var id: Int?
    var fullname: String?
    var username: String?
    var email: String?
    var birthday: String?
    var address: String?
    var gender: String?
    var image: UIImage?
    var imageUrl: String?
    var idCardNumber: String?
    var phone:String?
    var createdAt: String?
    var updatedAt: String?
    var status: Bool?
    var lock: Bool?
    // MARK: - Declaration for string constants to be used to decode and also serialize.
    private let FBid: String = "id"
    private let FBFullname: String = "fullname"
    private let FBEmail: String = "email"
    private let FBBirthday: String = "birthday"
    private let FBAddress: String = "address"
    private let FBGender: String = "gender"
    private let FBIdCardNumber: String = "idCardNumber"
    private let FBPhone: String = "phone"
    private let FBCreatedAt: String = "createdAt"
    private let FBUpdatedAt: String = "updatedAt"
    private let FBStatus: Bool = true
    private let FBLocked: Bool = false
    
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
        id = json[FBid].int
        fullname = json[FBFullname].string
        email = json[FBEmail].string
        birthday = json[FBBirthday].string
        address = json[FBAddress].string
        gender = json[FBGender].string
        idCardNumber = json[FBIdCardNumber].string
        phone = json[FBPhone].string
        createdAt = json[FBCreatedAt].string
        updatedAt = json[FBUpdatedAt].string
        
    }
    
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = id { dictionary[FBid] = value }
        if let value = fullname { dictionary[FBFullname] = value }
        if let value = email { dictionary[FBEmail] = value }
        if let value = birthday { dictionary[FBBirthday] = value }
        if let value = address { dictionary[FBAddress] = value }
        if let value = gender { dictionary[FBGender] = value }
        if let value = phone { dictionary[FBPhone] = value }
        if let value = idCardNumber { dictionary[FBIdCardNumber] = value }
        if let value = createdAt { dictionary[FBCreatedAt] = value }
        if let value = updatedAt { dictionary[FBUpdatedAt] = value }
        return dictionary
    }
    // MARK: - NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.id = aDecoder.decodeObject(forKey: FBid) as? Int
        self.fullname = aDecoder.decodeObject(forKey: FBFullname) as? String
        
    }
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: FBid)
        aCoder.encode(fullname, forKey: FBFullname)
        
    }
}
