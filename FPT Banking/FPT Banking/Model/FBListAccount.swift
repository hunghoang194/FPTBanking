//
//  FBListAccount.swift
//  FPT Banking
//
//  Created by hưng hoàng on 6/30/20.
//  Copyright © 2020 hưng hoàng. All rights reserved.
//

import Foundation
import SwiftyJSON

public class FBListAccount: NSObject {
    // MARK: - Properties
    var id: Int?
    var otpTranferEnabled: Bool?
    var amount: Int?
    var pinCode: String?
    var accountNumber: String?
    var cardNumber: String?
    var createdAt: String?
    var updatedAt: String?
    var card: CardObj?
    // MARK: - Declaration for string constants to be used to decode and also serialize.
    private let FBid: String = "id"
    private let FBOtpTranferEnabled: Bool = true
    private let FBAmount: String = "amount"
    private let FBPinCode: String = "pinCode"
    private let FBAccountNumber: String = "accountNumber"
    private let FBCreatedAt: String = "createdAt"
    private let FBUpdatedAt: String = "updatedAt"
    
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
        amount = json[FBAmount].int
        pinCode = json[FBPinCode].string
        accountNumber = json[FBAccountNumber].string
        createdAt = json[FBCreatedAt].string
        cardNumber = json["card"]["cardNumber"].string
        updatedAt = json[FBUpdatedAt].string
        card = CardObj.init(json: json["card"])
        
    }
    
    func setAmount(amount:Int) {
        self.amount = amount
    }
}


final class CardObj {
    private let FBid: String = "id"
    private let FBCardNumber: String = "cardNumber"
    
    var id: Int?
    var cardNumber: String?
    
    convenience public init(object: Any) {
           self.init(json: JSON(object))
       }
       public init(json: JSON) {
           id = json[FBid].int
           cardNumber = json[FBCardNumber].string
       }

}
