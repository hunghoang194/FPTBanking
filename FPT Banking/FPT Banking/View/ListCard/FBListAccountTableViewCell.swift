//
//  FBListAccountTableViewCell.swift
//  FPT Banking
//
//  Created by hưng hoàng on 6/30/20.
//  Copyright © 2020 hưng hoàng. All rights reserved.
//

import UIKit

class FBListAccountTableViewCell: UITableViewCell {
    @IBOutlet weak var lbCardNumber: UILabel!
    @IBOutlet weak var lbAccountNumber: UILabel!
    @IBOutlet weak var lbTotalMoney: UILabel!
    @IBOutlet weak var lbId: UILabel!
    var indexPath: IndexPath?
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setupListAccount(obj:FBListAccount?, index: IndexPath) {
        lbCardNumber.text = obj?.card?.cardNumber
        lbAccountNumber.text = obj?.accountNumber
        lbTotalMoney.text = "\(obj?.amount ?? 0)"
        lbId.text = "\(obj?.id ?? 0)"
    }
}
