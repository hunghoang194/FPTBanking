//
//  FBLoanProfiles.swift
//  FPT Banking
//
//  Created by hưng hoàng on 7/16/20.
//  Copyright © 2020 hưng hoàng. All rights reserved.
//

import Foundation
import SwiftyJSON
public class FBLoanprofiles: NSObject {
    var amount: Int?
    var descriptionLoan: String?
    var confirmed: Int?
    var approved: Int?
    var rejected: Int?
    var status: Int?
    var employeeConfirmedName: String?
    var rejectedReason: String?
    var createdAt: String?
    var loanInterestRate: loanInterestRateObj?
    var transactionOffice: transactionOfficeObj?
    // MARK: - Declaration for string constants to be used to decode and also serialize.
    private let FBAmount: String = "amount"
    private let FBDescriptionLoan: String = "description"
    private let FBConfirmed: String = "confirmed"
    private let FBApproved: String = "approved"
    private let FBRejected : String = "rejected"
    private let FBStatus: String = "status"
    private let FBEmployeeConfirmedName: String = "employeeConfirmedName"
    private let FBRejectedReason: String = "rejectedReason"
    private let FBCreatedAt: String = "createdAt"
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
        amount = json[FBAmount].int
        descriptionLoan = json[FBDescriptionLoan].string
        confirmed = json[FBConfirmed].int
        approved = json[FBApproved].int
        rejected = json[FBRejected].int
        status = json[FBStatus].int
        employeeConfirmedName = json[FBEmployeeConfirmedName].string
        rejectedReason = json[FBRejectedReason].string
        createdAt = json[FBCreatedAt].string
        loanInterestRate = loanInterestRateObj.init(json: json["loanInterestRate"])
        transactionOffice = transactionOfficeObj.init(json: json["transactionOffice"])
    }
}
final class loanInterestRateObj {
    private let FBInterestRate: String = "interestRate"
    private let FBMonths: String = "months"
    
    var interestRate: Int?
    var months: Int?
    
    convenience public init(object: Any) {
        self.init(json: JSON(object))
    }
    public init(json: JSON) {
        interestRate = json[FBInterestRate].int
        months = json[FBMonths].int
    }
}
final class transactionOfficeObj{
    private let FBAddress: String = "address"
    
    var address: String?
    
    convenience public init(object: Any) {
        self.init(json: JSON(object))
    }
    public init(json: JSON) {
        address = json[FBAddress].string
    }
}

