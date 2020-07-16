//
//  FBChequeTableViewCell.swift
//  FPT Banking
//
//  Created by hưng hoàng on 7/5/20.
//  Copyright © 2020 hưng hoàng. All rights reserved.
//

import UIKit
protocol ChequeTableViewCellDelegate {
    func edit(index: IndexPath)
}
class FBChequeTableViewCell: UITableViewCell {

    @IBOutlet weak var lbWithdrawAt: UILabel!
    @IBOutlet weak var btnStatus: UIButton!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbMoney: UILabel!
    @IBOutlet weak var lbNumberCard: UILabel!
    @IBOutlet weak var lbDateFrom: UILabel!
    @IBOutlet weak var lbDateExpire: UILabel!

    @IBOutlet weak var lbId: UILabel!
    var index: IndexPath?
    var delegate: ChequeTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func setupUI() {
        btnStatus.layer.cornerRadius = 5
        btnStatus.layer.masksToBounds = true
        btnStatus.layer.borderWidth = 1
        btnStatus.layer.borderColor = UIColor.red.cgColor
    }
    func setData(obj:FBListsCheque? , index:IndexPath) {
        self.index = index
        lbWithdrawAt.text = obj?.withdrawAt
        lbName.text = obj?.cheque?.recieverFullname
        lbMoney.text = "\(obj?.cheque?.transactionAmount?.formatnumber() ?? "")"
        lbDateFrom.text = tail(s: obj?.cheque?.createdAt! ?? "")
        lbDateExpire.text = tail(s: obj?.cheque?.expiredDate! ?? "")
        lbNumberCard.text = obj?.cheque?.recieverIdCardNumber
        lbId.text = "\(obj?.cheque?.id ?? 0)"
        if obj?.cheque?.status == 0 {
            btnStatus.setTitle("Chưa Chuyển", for: .normal)
        } else if obj?.cheque?.status == 1 {
            btnStatus.setTitle("Hoàn tất", for: .normal)
        } else if obj?.cheque?.canceled == 1 {
            btnStatus.setTitle("Bị thu hồi", for: .normal)
        } else if obj?.cheque?.withdrawDate != nil {
            btnStatus.setTitle("Đã rút \(obj?.cheque?.withdrawDate ?? "")", for: .normal)
        }
    }
    
    func tail(s: String) -> String {
        return String(s.prefix(10))
    }

    
}
