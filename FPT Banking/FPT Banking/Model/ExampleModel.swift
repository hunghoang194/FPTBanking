//
//  ExampleModel.swift
//  FPT Banking
//
//  Created by Hung Hoang on 6/22/20.
//  Copyright © 2020 hưng hoàng. All rights reserved.
//

import Foundation
import SwiftyJSON

public class ExampleModel: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private let kMTModuleObjCreatedAtFormatKey: String = "created_at_format"
  private let kMTModuleObjInternalIdentifierKey: String = "id"
  private let kMTModuleObjCodeKey: String = "code"
  private let kMTModuleObjLidKey: String = "lid"
  private let kMTModuleObjCreatedAtKey: String = "created_at"
  private let kMTModuleObjDescriptionValueKey: String = "description"
  private let kMTModuleObjTitleKey: String = "title"
  private let kMTModuleObjProcessPercentKey: String = "process_percent"
  private let kAnswerResult: String = "answert_result"

  // MARK: Properties
  public var createdAtFormat: String?
  public var internalIdentifier: Int?
  public var code: String?
  public var lid: String?
  public var createdAt: String?
  public var descriptionValue: String?
  public var title: String?
  public var processPercent: Int?
  public var answerResult: Int?

  // MARK: SwiftyJSON Initalizers
  /**
   Initates the instance based on the object
   - parameter object: The object of either Dictionary or Array kind that was passed.
   - returns: An initalized instance of the class.
  */
  convenience public init(object: Any) {
    self.init(json: JSON(object))
  }

  /**
   Initates the instance based on the JSON that was passed.
   - parameter json: JSON object from SwiftyJSON.
   - returns: An initalized instance of the class.
  */
  public init(json: JSON) {
    createdAtFormat = json[kMTModuleObjCreatedAtFormatKey].string
    internalIdentifier = json[kMTModuleObjInternalIdentifierKey].int
    code = json[kMTModuleObjCodeKey].string
    lid = json[kMTModuleObjLidKey].string
    createdAt = json[kMTModuleObjCreatedAtKey].string
    descriptionValue = json[kMTModuleObjDescriptionValueKey].string
    title = json[kMTModuleObjTitleKey].string
    processPercent = json[kMTModuleObjProcessPercentKey].int
    answerResult = json[kAnswerResult].int ?? Int(json[kAnswerResult].string ?? "")
  }

  /**
   Generates description of the object in the form of a NSDictionary.
   - returns: A Key value pair containing all valid values in the object.
  */
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = createdAtFormat { dictionary[kMTModuleObjCreatedAtFormatKey] = value }
    if let value = internalIdentifier { dictionary[kMTModuleObjInternalIdentifierKey] = value }
    if let value = code { dictionary[kMTModuleObjCodeKey] = value }
    if let value = lid { dictionary[kMTModuleObjLidKey] = value }
    if let value = createdAt { dictionary[kMTModuleObjCreatedAtKey] = value }
    if let value = descriptionValue { dictionary[kMTModuleObjDescriptionValueKey] = value }
    if let value = title { dictionary[kMTModuleObjTitleKey] = value }
    if let value = processPercent { dictionary[kMTModuleObjProcessPercentKey] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.createdAtFormat = aDecoder.decodeObject(forKey: kMTModuleObjCreatedAtFormatKey) as? String
    self.internalIdentifier = aDecoder.decodeObject(forKey: kMTModuleObjInternalIdentifierKey) as? Int
    self.code = aDecoder.decodeObject(forKey: kMTModuleObjCodeKey) as? String
    self.lid = aDecoder.decodeObject(forKey: kMTModuleObjLidKey) as? String
    self.createdAt = aDecoder.decodeObject(forKey: kMTModuleObjCreatedAtKey) as? String
    self.descriptionValue = aDecoder.decodeObject(forKey: kMTModuleObjDescriptionValueKey) as? String
    self.title = aDecoder.decodeObject(forKey: kMTModuleObjTitleKey) as? String
    self.processPercent = aDecoder.decodeObject(forKey: kMTModuleObjProcessPercentKey) as? Int
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(createdAtFormat, forKey: kMTModuleObjCreatedAtFormatKey)
    aCoder.encode(internalIdentifier, forKey: kMTModuleObjInternalIdentifierKey)
    aCoder.encode(code, forKey: kMTModuleObjCodeKey)
    aCoder.encode(lid, forKey: kMTModuleObjLidKey)
    aCoder.encode(createdAt, forKey: kMTModuleObjCreatedAtKey)
    aCoder.encode(descriptionValue, forKey: kMTModuleObjDescriptionValueKey)
    aCoder.encode(title, forKey: kMTModuleObjTitleKey)
    aCoder.encode(processPercent, forKey: kMTModuleObjProcessPercentKey)
  }

}
