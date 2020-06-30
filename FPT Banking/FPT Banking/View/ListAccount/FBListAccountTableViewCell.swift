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
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setupListAccount(obj:FBProductObj) {
        lbCardNumber.text = obj.numberCard
    }
}
