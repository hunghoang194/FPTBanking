//
//  TransactionHistoryTableViewCell.swift
//  FPT Banking
//
//  Created by hưng hoàng on 6/22/20.
//  Copyright © 2020 hưng hoàng. All rights reserved.
//

import UIKit

class TransactionHistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var transacsionView: UIView!
    @IBOutlet weak var lbAmount: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var lbContent: UILabel!
    @IBOutlet weak var lbTypeSend: UILabel!
    @IBOutlet weak var lbVND: UILabel!
    @IBOutlet weak var lbFromOrToFullName: UILabel!
    @IBOutlet weak var lbFromOrToAccountNumber: UILabel!
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
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func setupDataTransacsion(obj:TransactionsObj?,index: IndexPath) {
        lbDate.text = tail(s: obj?.createdAt! ?? "")
        lbContent.text = obj?.description
        lbFromOrToFullName.text = obj?.fromOrToFullName
        lbFromOrToAccountNumber.text = obj?.fromOrToAccountNumber
//        lbTypeSend.text = obj?.transactionType.transactionType
        if obj?.transactionType.transactionType == "transfer_internal" {
            lbTypeSend.text = "Chuyển tiền"
        } else if obj?.transactionType.transactionType == "withdraw" {
            lbTypeSend.text = "Nạp tiền"
        }
        if obj?.amount ?? 0 >= 0 {
            lbAmount.textColor = .green
            lbAmount.text = "+\(obj?.amount?.formatnumber() ?? "")"
            lbVND.textColor = .green
        } else if obj?.amount ?? 0 < 0 {
            lbAmount.textColor = .red
            lbAmount.text = "\(obj?.amount?.formatnumber() ?? "")"
            lbVND.textColor = .red
        }
    }
    func tail(s: String) -> String {
        return String(s.prefix(10))
    }
}

