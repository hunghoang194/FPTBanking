//
//  FBChequeTableViewCell.swift
//  FPT Banking
//
//  Created by hưng hoàng on 7/5/20.
//  Copyright © 2020 hưng hoàng. All rights reserved.
//

import UIKit
protocol ChequeTableViewCellDelegate {
    func cancel(index: IndexPath)
}
class FBChequeTableViewCell: UITableViewCell {

    @IBOutlet weak var lbWithdrawAt: UILabel!
    @IBOutlet weak var btnStatus: UIButton!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbMoney: UILabel!
    @IBOutlet weak var lbNumberCard: UILabel!
    @IBOutlet weak var lbDateFrom: UILabel!
    @IBOutlet weak var lbDateExpire: UILabel!
    @IBOutlet weak var btnCancelCheque: UIButton!
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
        btnCancelCheque.layer.cornerRadius = 5
        btnCancelCheque.layer.masksToBounds = true
        btnCancelCheque.layer.borderWidth = 1
        btnCancelCheque.layer.borderColor = UIColor.green.cgColor
    }
    func setData(obj:FBListsCheque? , index:IndexPath) {
        self.index = index
        lbName.text = obj?.recieverFullname
        lbMoney.text = "\(obj?.transactionAmount ?? 0)"
        lbDateFrom.text = tail(s: obj?.createdAt! ?? "")
        lbDateExpire.text = tail(s: obj?.expiredDate! ?? "")
        lbNumberCard.text = obj?.recieverIdCardNumber
        lbId.text = "\(obj?.id ?? 0)"
        if obj?.status == 0 {
            btnStatus.setTitle("Chưa Chuyển", for: .normal)
        } else if obj?.status == 1 {
            btnStatus.setTitle("Hoàn tất", for: .normal)
        } else if obj?.canceled == 1 {
            btnStatus.setTitle("Bị thu hồi", for: .normal)
        } else if obj?.withdrawDate != nil {
            btnStatus.setTitle("Đã rút \(obj?.withdrawDate ?? "")", for: .normal)
        }
    }
    @IBAction func cancelCheque(_ sender: Any) {
        btnStatus.setTitle("Bị thu hồi", for: .normal)
//        if delegate != nil && index != nil {
//            self.delegate?.cancel(index: self.index!)
//        }
    }
    func tail(s: String) -> String {
        return String(s.prefix(10))
    }
    @IBOutlet weak var editChequePRess: NSLayoutConstraint!
    
}
