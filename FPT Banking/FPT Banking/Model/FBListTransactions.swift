//
//  FBListTransactions.swift
//  FPT Banking
//
//  Created by hưng hoàng on 7/4/20.
//  Copyright © 2020 hưng hoàng. All rights reserved.
//

import Foundation
import SwiftyJSON

public class FBListTransactions: NSObject {
    // MARK: - Properties
    var totalCount: Int?
    var totalPage: Int?
    var pageNumber: Int?
    var pageSize: Int?
    var items: TransactionsObj?
    // MARK: - Declaration for string constants to be used to decode and also serialize.
    private let FBTotalCount: String = "totalCount"
    private let FBTotalPage: String = "totalPage"
    private let FBPageNumber: String = "pageNumber"
    private let FBPageSize: String = "pageSize"
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
        totalCount = json[FBTotalCount].int
        totalPage = json[FBTotalPage].int
        pageNumber = json[FBPageNumber].int
        pageSize = json[FBPageSize].int
        items = TransactionsObj.init(json: json["items"])
        
    }
}

final class TransactionsObj {
    private let FBid: String = "id"
    private let FBAmount: String = "amount"
    private let FBDescription: String = "description"
    private let FBCreatedAt: String = "createdAt"
    private let FBAmountAfterTransaction: String = "amountAfterTransaction"
    
    var id: Int?
    var amount: Int?
    var description : String?
    var createdAt: String?
    var amountAfterTransaction: Int?
    var transactionType: TypeTransactionsObj
    
    convenience public init(object: Any) {
        self.init(json: JSON(object))
    }
    public init(json: JSON) {
        id = json[FBid].int
        amount = json[FBAmount].int
        description = json[FBDescription].string
        createdAt = json[FBCreatedAt].string
        amountAfterTransaction = json[FBAmountAfterTransaction].int
        transactionType = TypeTransactionsObj.init(json: json["transactionType"])
    }
}
final class TypeTransactionsObj {
    private let FBid: String = "id"
    private let FBTransactionType: String = "name"
    
    var id: Int?
    var transactionType: String?
    
    convenience public init(object: Any) {
        self.init(json: JSON(object))
    }
    public init(json: JSON) {
        id = json[FBid].int
        transactionType = json[FBTransactionType].string
    }
}
