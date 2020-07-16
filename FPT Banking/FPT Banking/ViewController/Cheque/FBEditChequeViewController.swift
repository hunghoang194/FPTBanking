//
//  FBEditViewController.swift
//  FPT Banking
//
//  Created by hưng hoàng on 7/16/20.
//  Copyright © 2020 hưng hoàng. All rights reserved.
//

import UIKit
import MBProgressHUD
import Alamofire
import SwiftyJSON

class FBEditChequeViewController: FBBaseViewController {
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtCardNumber: UITextField!
    @IBOutlet weak var txtMoney: UITextField!
    @IBOutlet weak var moneyView: UIView!
    @IBOutlet weak var txtID: UITextField!
    @IBOutlet weak var IDView: UIView!
    @IBOutlet weak var cardNumberView: UIView!
    @IBOutlet weak var userNameView: UIView!

    @IBOutlet weak var btnEditCheque: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isBackgroundGray = true
        updateCheque()
    }
    override func initUI() {
        userNameView.layer.cornerRadius = 10
        userNameView.layer.masksToBounds = true
        cardNumberView.layer.cornerRadius = 10
        cardNumberView.layer.masksToBounds = true
        moneyView.layer.cornerRadius = 10
        moneyView.layer.masksToBounds = true
        IDView.layer.cornerRadius = 10
        IDView.layer.masksToBounds = true
        IDView.setMutilColorForView(nameColor:ColorName.CallBackground)
        moneyView.setMutilColorForView(nameColor:ColorName.CallBackground)
        userNameView.setMutilColorForView(nameColor:ColorName.CallBackground)
        cardNumberView.setMutilColorForView(nameColor:ColorName.CallBackground)
        btnEditCheque.setBorder(color: UIColor(red: 189, green: 189, blue: 189, alpha: 1), width: 1,isCircle: true)
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
        self.updateCheque()
    }
    func updateCheque() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let id: String = (self.txtID.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!
        let userName: String = (self.txtName.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!
        let numberCard: String = (self.txtCardNumber.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!
        let money: String = (self.txtMoney.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!
        BaseServices.shareInstance.editCheque(id: id, recieverFullname: userName, recieverIdCardNumber: numberCard, transactionAmount: money ) { (response, message, errorCode) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if errorCode == SUCCESS_CODE {
                if response != nil {
                    let jsonData = JSON(response!)
                    self.txtID.text = ""
                    self.txtMoney.text = ""
                    self.txtCardNumber.text = ""
                    self.txtName.text = ""
                    self.showPopup(string:"Cập nhật thông tin séc thành công")
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
    @IBAction func editCheque(_ sender: Any) {
        checkValidUserName()
    }
    
    
}

