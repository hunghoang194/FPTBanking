//
//  FBListCheque.swift
//  FPT Banking
//
//  Created by hưng hoàng on 7/5/20.
//  Copyright © 2020 hưng hoàng. All rights reserved.
//

import Foundation
import SwiftyJSON

public class FBListsCheque: NSObject {
    // MARK: - Properties
    var id: Int?
    var recieverFullname: String?
    var recieverIdCardNumber: String?
    var transactionAmount: Int?
    var status: Int?
    var canceled: Int?
    var createdAt: String?
    var expiredDate: String?
    var withdrawDate: String?
    
    // MARK: - Declaration for string constants to be used to decode and also serialize.
    private let FBId: String = "id"
    private let FBRecieverFullname: String = "recieverFullname"
    private let FBRecieverIdCardNumber: String = "recieverIdCardNumber"
    private let FBTransactionAmount: String = "transactionAmount"
    private let FBStatus: String = "status"
    private let FBCanceled: String = "canceled"
    private let FBCreatedAt: String = "createdAt"
    private let FBExpiredDate: String = "expiredDate"
    private let FBWithdrawDate: String = "withdrawDate"
    
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
        id = json[FBId].int
        recieverFullname = json[FBRecieverFullname].string
        recieverIdCardNumber = json[FBRecieverIdCardNumber].string
        transactionAmount = json[FBTransactionAmount].int
        expiredDate = json[FBExpiredDate].string
        createdAt = json[FBExpiredDate].string
        withdrawDate = json[FBWithdrawDate].string
        canceled = json[FBCanceled].int
        status = json[FBStatus].int
    }
}

