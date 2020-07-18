//
//  FBNotificationsTableViewCell.swift
//  FPT Banking
//
//  Created by hưng hoàng on 7/16/20.
//  Copyright © 2020 hưng hoàng. All rights reserved.
//

import UIKit

class FBNotificationsTableViewCell: UITableViewCell {
    @IBOutlet weak var listView: UIView!
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var lbMessage: UILabel!
    @IBOutlet weak var lbStatus: UILabel!
    
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
    func setData(obj:CurrentNotiObj?,index: IndexPath) {
        lbMessage.text = obj?.message
        lbDate.text = tail(s: obj?.createdAt ?? "")
        if obj?.read ?? 0 == 1 {
            lbStatus.text = "Đã đọc"
        } else if obj?.read ?? 0 == 0 {
            lbStatus.text = "Chưa đọc"
        }
    }
    func tail(s: String) -> String {
        return String(s.prefix(10))
    }
}
