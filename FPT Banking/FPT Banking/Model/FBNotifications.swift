//
//  FBNotifications.swift
//  FPT Banking
//
//  Created by hưng hoàng on 7/16/20.
//  Copyright © 2020 hưng hoàng. All rights reserved.
//

import Foundation
import SwiftyJSON

public class FBNotifications : NSObject {
    var message: String?
    var totalCount: Int?
    var totalPage: Int?
    var pageNumber: Int?
    var pageSize: Int?
    var loggedInFailedTime: Int?
    var items: CurrentNotiObj?
    // MARK: - Declaration for string constants to be used to decode and also serialize.
    private let FBMessage: String = "message"
    private let FBTotalCount: String = "totalCount"
    private let FBTotalPage: String = "totalPage"
    private let FBPageNumber: String = "pageNumber"
    private let FBPageSize : String = "pageSize"
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
        message = json[FBMessage].string
        totalCount = json[FBTotalCount].int
        totalPage = json[FBTotalPage].int
        pageNumber = json[FBPageNumber].int
        pageSize = json[FBPageSize].int
        items = CurrentNotiObj.init(json: json["items"])
    }
}
final class CurrentNotiObj {
    private let FBid: String = "id"
    private let FBMessage: String = "message"
    private let FBCreatedAt: String = "createdAt"
    private let FBRead: String = "read"
    
    var id: Int?
    var transactionType: String?
    var message: String?
    var createdAt: String?
    var read: Int?
    
    convenience public init(object: Any) {
        self.init(json: JSON(object))
    }
    public init(json: JSON) {
        id = json[FBid].int
        message = json[FBMessage].string
        createdAt = json[FBCreatedAt].string
        read = json[FBRead].int
    }
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = message { dictionary[FBMessage] = value }
        if let value = createdAt { dictionary[FBCreatedAt] = value }
        if let value = read { dictionary[FBRead] = value }
        return dictionary
    }
    // MARK: - NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.message = aDecoder.decodeObject(forKey: FBMessage) as? String
        self.createdAt = aDecoder.decodeObject(forKey: FBCreatedAt) as? String
        self.read = aDecoder.decodeObject(forKey: FBRead) as? Int
    }
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(message, forKey: FBMessage)
        aCoder.encode(createdAt, forKey: FBCreatedAt)
        aCoder.encode(read, forKey: FBRead)
    }
}

