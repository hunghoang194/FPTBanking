//
//  FBAddChequeViewController.swift
//  FPT Banking
//
//  Created by hưng hoàng on 7/5/20.
//  Copyright © 2020 hưng hoàng. All rights reserved.
//

import UIKit
import MBProgressHUD
import Alamofire
import SwiftyJSON

class FBAddChequeViewController: FBBaseViewController {
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtCardNumber: UITextField!
    @IBOutlet weak var txtMoney: UITextField!
    @IBOutlet weak var moneyView: UIView!
    @IBOutlet weak var cardNumberView: UIView!
    @IBOutlet weak var userNameView: UIView!
    @IBOutlet weak var addChequeView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isBackgroundGray = true
    }
    override func viewDidLayoutSubviews() {
        moneyView.setBorder(color: UIColor(red: 189, green: 189, blue: 189, alpha: 1), width: 0.5,isCircle: true)
        userNameView.layer.cornerRadius = 10
        userNameView.layer.masksToBounds = true
        cardNumberView.layer.cornerRadius = 10
        cardNumberView.layer.masksToBounds = true
        moneyView.layer.cornerRadius = 10
        moneyView.layer.masksToBounds = true
        addChequeView.setMutilColorForView(nameColor:ColorName.CallBackground)
        moneyView.setMutilColorForView(nameColor:ColorName.CallBackground)
        userNameView.setMutilColorForView(nameColor:ColorName.CallBackground)
        cardNumberView.setMutilColorForView(nameColor:ColorName.CallBackground)
    }
    // check validate input
    func checkValidUserName() {
        let username: String = (self.txtName.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!
        let cardNumber: String = (self.txtCardNumber.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!
        let money: String = (self.txtMoney.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!
        //check nhap tk/mk
        if (username.isEmpty || cardNumber.isEmpty || money.isEmpty ) {
            self.showPopup(string:"Bạn chưa nhập thông tin")
            return
        }
        //check do dai pass
        if !self.isValidCardNumber(testID: cardNumber) {
            self.showPopup(string:"Số CMND hoặc CCCD không hoẹp lệ")
            return
        }
        if !self.isValidPassword(testPass: money) {
            self.showPopup(string:"Số tiền chưa đạt mức tối thiểu")
            return
        }
        self.addCheque()
    }
    func addCheque() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let userName: String = (self.txtName.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!
        let numberCard: String = (self.txtCardNumber.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!
        let money: String = (self.txtMoney.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!
        BaseServices.shareInstance.addCheque(recieverFullname: userName, recieverIdCardNumber: numberCard, transactionAmount: money ) { (response, message, errorCode) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if errorCode == SUCCESS_CODE {
                if response != nil {
                    let jsonData = JSON(response!)
                    self.txtMoney.text = ""
                    self.txtCardNumber.text = ""
                    self.txtName.text = ""
                    self.showPopup(string:"Thêm mới thành công")
                }
                else                     {
                    self.showPopup(string:"Thông tin không chính xác")
                }
            }
        }
    }
    
    @IBAction func backPress(_ sender: Any) {
        self.backButtonPress()
    }
    @IBAction func addCheque(_ sender: Any) {
        checkValidUserName()
    }
    
    
}
