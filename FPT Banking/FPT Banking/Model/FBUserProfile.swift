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
    // MARK: - Declaration for string constants to be used to decode and also serialize.
    private let FBid: String = "id"
    private let FBFullname: String = "fullname"
    private let FBEmail: String = "email"
    private let FBBirthday: String = "birthday"
    private let FBAddress: String = "address"
    private let FBGender: String = "gender"
    private let FBImageUrl: String = "image"
    
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
        id = json[FBid].int}
    
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = id { dictionary[FBid] = value }
        return dictionary
    }
    // MARK: - NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.id = aDecoder.decodeObject(forKey: FBid) as? Int
        
    }
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: FBid)
        
    }
}
