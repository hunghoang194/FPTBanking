//
//  FBLoanProfilesTableViewCell.swift
//  FPT Banking
//
//  Created by hưng hoàng on 7/16/20.
//  Copyright © 2020 hưng hoàng. All rights reserved.
//

import UIKit

class FBLoanProfilesTableViewCell: UITableViewCell {
    @IBOutlet weak var lbStatus: UILabel!
    @IBOutlet weak var lbAmount: UILabel!
    @IBOutlet weak var lbFullName: UILabel!
    @IBOutlet weak var lbIdCardNumber: UILabel!
    @IBOutlet weak var lbTimeLoan: UILabel!
    @IBOutlet weak var lbInterestRate: UILabel!
    @IBOutlet weak var lbOffice: UILabel!
    @IBOutlet weak var lbCreateAt: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var lbApproved: UILabel!
    @IBOutlet weak var lbReject: UILabel!
    @IBOutlet weak var lbRejectedReason: UILabel!
    @IBOutlet weak var lbEmployeeConfirmedName: UILabel!
    @IBOutlet weak var lbConfirm: UILabel!
    
    var indexPath: IndexPath?
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0))
        contentView.setMutilColorForView(nameColor: ColorName.CallBackground)
    }
    func setData(obj:FBLoanprofiles?, index: IndexPath) {
        if obj?.status == 0 {
            lbStatus.text = "Từ chối"
        } else if obj?.status == 1 {
            lbStatus.text = "Chưa xác nhận"
        } else if obj?.status == 2 {
            lbStatus.text = "Đã xác nhận"
        } else if obj?.status == 3 {
            lbStatus.text = "Được phê duyệt"
        } else if obj?.status == 4 {
            lbStatus.text = "Vay thành công"
        }
        lbAmount.text = "\(obj?.amount ?? 0)"
        lbFullName.text = FBDataCenter.sharedInstance.userInfo?.fullname
        lbIdCardNumber.text = FBDataCenter.sharedInstance.userInfo?.idCardNumber
        lbTimeLoan.text = "\(obj?.loanInterestRate?.months ?? 0) tháng"
        lbInterestRate.text = "\(obj?.loanInterestRate?.interestRate ?? 0)%"
        lbOffice.text = obj?.transactionOffice?.address
        lbDescription.text = obj?.descriptionLoan
        if obj?.approved == 0 {
            lbApproved.text = "Chưa phê duyệt"
        } else if obj?.approved == 1 {
            lbApproved.text = "Đã phê duyệt"
        }
        if obj?.confirmed == 0 {
            lbApproved.text = "Chưa xác nhận"
        } else if obj?.confirmed == 1 {
            lbApproved.text = "Chưa xác nhận"
        }
        if obj?.confirmed == 0 {
            lbApproved.text = "Chưa xác nhận"
        } else if obj?.confirmed == 1 {
            lbApproved.text = "Đã xác nhận"
        }
        if obj?.rejected == 0 {
            lbApproved.text = "Chưa xác nhận"
        } else if obj?.rejected == 1 {
            lbApproved.text = "Bị từ chối"
        }
        if obj?.rejectedReason == nil {
            lbRejectedReason.text = "Chưa xác nhận"
        } else {
            lbRejectedReason.text = obj?.rejectedReason
        }
        if obj?.employeeConfirmedName == nil {
            lbEmployeeConfirmedName.text = "Chưa có người xác nhận"
        } else {
            lbEmployeeConfirmedName.text = obj?.employeeConfirmedName
        }
    }
    
}
