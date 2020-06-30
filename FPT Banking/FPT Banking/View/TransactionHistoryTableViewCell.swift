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
    @IBOutlet weak var lbTransacsion: UILabel!
    @IBOutlet weak var lbInfo: UILabel!
    @IBOutlet weak var imgStatus: UIImageView!
    @IBOutlet weak var imgShowStatus: UIImageView!
    @IBOutlet weak var lbContent: UILabel!
    var indexPath: IndexPath?
    override func awakeFromNib() {
        super.awakeFromNib()
        transacsionView.layer.cornerRadius = 10
        transacsionView.layer.masksToBounds = true
        self.contentView.setMutilColorForView(nameColor: ColorName.CallBackground)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func setupDataTransacsion(obj:FBProductObj?) {
        if obj?.transacsion ?? 0 >= 0 {
            lbTransacsion.textColor = .green
            lbInfo.textColor = .green
            lbInfo.text = "\(obj?.price ?? 0)"
            lbContent.text = obj?.title
            lbTransacsion.text = "\(obj?.transacsion ?? 0)"
        } else if obj?.transacsion ?? 0 < 0 {
            lbTransacsion.textColor = .red
            lbInfo.textColor = .red
            lbInfo.text = "\(obj?.price ?? 0)"
            lbContent.text = obj?.title
            lbTransacsion.text = "\(obj?.transacsion ?? 0)"
        }
    }
}
