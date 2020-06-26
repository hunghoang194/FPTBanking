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
    var indexPath: IndexPath?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func setupDataTransacsion(obj:FBProductObj?) {
        if obj?.transacsion ?? 0 >= 0 {
            lbTransacsion.textColor = .green
            lbInfo.textColor = .green
            imgStatus.image = UIImage.init(named: "ic_up")
            imgShowStatus.image = UIImage.init(named: "ic_up")
            lbInfo.text = "\(obj?.price ?? 0)"
            lbTransacsion.text = "\(obj?.transacsion ?? 0)"
        } else if obj?.transacsion ?? 0 < 0 {
            lbTransacsion.textColor = .red
            lbInfo.textColor = .red
            imgStatus.image = UIImage.init(named: "ic_down")
            imgShowStatus.image = UIImage.init(named: "ic_down")
            lbInfo.text = "\(obj?.price ?? 0)"
            lbTransacsion.text = "\(obj?.transacsion ?? 0)"
        }
    }
}
