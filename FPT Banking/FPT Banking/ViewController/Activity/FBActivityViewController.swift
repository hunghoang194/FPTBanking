//
//  FBActivityViewController.swift
//  FPT Banking
//
//  Created by hưng hoàng on 7/4/20.
//  Copyright © 2020 hưng hoàng. All rights reserved.
//

import UIKit

class FBActivityViewController: FBBaseViewController {
    
    @IBOutlet weak var sendInBankView: UIView!
    @IBOutlet weak var sendToCardView: UIView!
    @IBOutlet weak var listChequeView: UIView!
    @IBOutlet weak var addChequeView: UIView!
    @IBOutlet weak var listLoanProfileView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isBackgroundGray = true
    }
    override func initUI() {
        sendInBankView.layer.cornerRadius = 10
        sendInBankView.layer.masksToBounds = true
        listChequeView.layer.cornerRadius = 10
        listChequeView.layer.masksToBounds = true
        sendToCardView.layer.cornerRadius = 10
        sendToCardView.layer.masksToBounds = true
        addChequeView.layer.cornerRadius = 10
        addChequeView.layer.masksToBounds = true
        listLoanProfileView.layer.cornerRadius = 10
        listLoanProfileView.layer.masksToBounds = true
        listLoanProfileView.setMutilColorForView(nameColor:ColorName.CallBackground)
        sendInBankView.setMutilColorForView(nameColor:ColorName.CallBackground)
        sendToCardView.setMutilColorForView(nameColor:ColorName.CallBackground)
        listChequeView.setMutilColorForView(nameColor:ColorName.CallBackground)
        addChequeView.setMutilColorForView(nameColor:ColorName.CallBackground)
    }
    @IBAction func sendMoneyInBank(_ sender: Any) {
        self.goInbBank()
    }
    @IBAction func sendATM(_ sender: Any) {
        self.sendCard()
    }
    @IBAction func listSec(_ sender: Any) {
        self.goListCheque()
    }
    @IBAction func addCheque(_ sender: Any) {
        self.goAddCheque()
    }
    @IBAction func loanProfile(_ sender: Any) {
        self.goLoanProfiles()
    }
    
}
