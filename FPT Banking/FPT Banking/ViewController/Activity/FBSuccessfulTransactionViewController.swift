//
//  FBSuccessfulTransactionViewController.swift
//  FPT Banking
//
//  Created by hưng hoàng on 7/4/20.
//  Copyright © 2020 hưng hoàng. All rights reserved.
//

import UIKit

class FBSuccessfulTransactionViewController: FBBaseViewController {
    @IBOutlet weak var lbAmount: UILabel!
    @IBOutlet weak var lbNameSend: UILabel!
    @IBOutlet weak var lbAccountNumberSend: UILabel!
    @IBOutlet weak var lbNamePull: UILabel!
    @IBOutlet weak var lbAccountNumberPull: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var lbTransactionCode: UILabel!
    @IBOutlet weak var btnTransactions: UIButton!
    @IBOutlet weak var btnGoHome: UIButton!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var lbNumber: UILabel!
    
    var receiver: String?
    var accountsGet: String?
    var time: String?
    var amount: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isBackgroundGray = true
        contentView.layer.cornerRadius = 5
        contentView.layer.masksToBounds = true
        contentView.setMutilColorForView(nameColor: ColorName.CallBackground)
        
    }

    override func initUI() {
        let names = ["012", "323", "123", "563", "321","042", "363", "923", "513", "721"]
        let randomName = names.randomElement()
        lbNumber.text = randomName
        btnGoHome.layer.cornerRadius = 10
        btnGoHome.layer.masksToBounds = true
        btnTransactions.layer.cornerRadius = 10
        btnTransactions.layer.masksToBounds = true
        lbNameSend.text = FBDataCenter.sharedInstance.userInfo?.fullname
        lbAmount.text = "-\(amount ?? "")"
        lbAmount.textColor = UIColor.red
        lbNamePull.text = receiver
        lbAccountNumberPull.text = accountsGet
        lbTime.text = time
    }
    @IBAction func transactionsPress(_ sender: Any) {
        self.goListActivity()
    }
    @IBAction func goHomePress(_ sender: Any) {
        self.goHome()
    }
    
}
