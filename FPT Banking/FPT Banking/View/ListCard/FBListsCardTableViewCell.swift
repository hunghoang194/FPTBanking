//
//  FBListsCardTableViewCell.swift
//  FPT Banking
//
//  Created by Hung Hoang on 6/26/20.
//  Copyright © 2020 hưng hoàng. All rights reserved.
//

import UIKit

class FBListsCardTableViewCell: UITableViewCell {
    @IBOutlet weak var viewListCard: UIView!
    @IBOutlet weak var lbCardNumber: UILabel!
    @IBOutlet weak var lbDateActive: UILabel!
    @IBOutlet weak var lbExpirationDate: UILabel!
    @IBOutlet weak var lbName: UILabel!
    var indexPath: IndexPath?
    override func awakeFromNib() {
        super.awakeFromNib()
        viewListCard.layer.cornerRadius = 10
        viewListCard.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func setupDataCard(obj:FBProductObj) {
        lbCardNumber.text = obj.numberCard
        lbDateActive.text = obj.dateActive
        lbExpirationDate.text = obj.dateExpiriation
        lbName.text = obj.productName
    }
}
