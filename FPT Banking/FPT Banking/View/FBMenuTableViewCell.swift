//
//  HDMenuTableViewCell.swift
//  HVN MACs
//
//  Created by Tung Nguyen on 3/14/19.
//  Copyright © 2019 Tung Nguyen. All rights reserved.
//

import UIKit

class FBMenuTableViewCell: UITableViewCell {
    @IBOutlet weak var imgCover: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lineView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
//        lineView.setMutilColorForView(nameColor: ColorName.LineColor)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
