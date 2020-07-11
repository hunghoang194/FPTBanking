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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isBackgroundGray = true
    }
    override func initUI() {
        sendInBankView.setBorder(color: UIColor(red: 189, green: 189, blue: 189, alpha: 1), width: 1,isCircle: true)
        sendToCardView.setBorder(color: UIColor(red: 189, green: 189, blue: 189, alpha: 1), width: 1,isCircle: true)
        listChequeView.setBorder(color: UIColor(red: 189, green: 189, blue: 189, alpha: 1), width: 1,isCircle: true)
        addChequeView.setBorder(color: UIColor(red: 189, green: 189, blue: 189, alpha: 1), width: 1,isCircle: true)
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
    
}
