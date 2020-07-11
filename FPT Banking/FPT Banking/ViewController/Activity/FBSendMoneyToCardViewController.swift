//
//  FBSendMoneyToCardViewController.swift
//  FPT Banking
//
//  Created by hưng hoàng on 7/3/20.
//  Copyright © 2020 hưng hoàng. All rights reserved.
//

import UIKit
import MBProgressHUD
import Alamofire
import SwiftyJSON

class FBSendMoneyToCardViewController: FBBaseViewController {
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbAccountNumber: UILabel!
    @IBOutlet weak var lbAmount: UILabel!
    @IBOutlet weak var btnSendMoney: UIButton!
    @IBOutlet weak var cardNumberSendView: UIView!
    @IBOutlet weak var inputMoneyView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var accountNumberTxt: UITextField!
    @IBOutlet weak var moneyInputTxt: UITextField!
    @IBOutlet weak var contentTxt: UITextField!
    @IBOutlet weak var pinCodeTxt: UITextField!
    @IBOutlet weak var pinCodeView: UIView!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var tbSendMoney: UITableView!
    var infoAccount = [FBUserProfile]()
    
    var idTranfer: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isBackgroundGray = true
        pinCodeTxt.isSecureTextEntry = true
    }

    override func initUI() {
        cardNumberSendView.setBorder(color: UIColor(red: 189, green: 189, blue: 189, alpha: 1), width: 1,isCircle: true, mutilColorName: ColorName.CallBackground)
        inputMoneyView.setBorder(color: UIColor(red: 189, green: 189, blue: 189, alpha: 1), width: 1,isCircle: true, mutilColorName: ColorName.CallBackground)
        contentView.setBorder(color: UIColor(red: 189, green: 189, blue: 189, alpha: 1), width: 1,isCircle: true, mutilColorName: ColorName.CallBackground)
        pinCodeView.setBorder(color: UIColor(red: 189, green: 189, blue: 189, alpha: 1), width: 1,isCircle: true, mutilColorName: ColorName.CallBackground)
        nameView.setBorder(color: UIColor(red: 189, green: 189, blue: 189, alpha: 1), width: 1,isCircle: true, mutilColorName: ColorName.CallBackground)
        btnSendMoney.setBorder(color: UIColor(red: 189, green: 189, blue: 189, alpha: 1), width: 1,isCircle: true)
    }
    override func initData() {
        lbName.text = FBDataCenter.sharedInstance.userInfo?.fullname
        lbAccountNumber.text = FBDataCenter.sharedInstance.account?.accountNumber
        lbAmount.text =  "\(FBDataCenter.sharedInstance.account?.amount ?? 0) "
    }
    @IBAction func backPress(_ sender: Any) {
        backButtonPress()
    }
    
    @IBAction func sendMoneyPress(_ sender: Any) {
        self.tranferCard()
    }
    
    @IBAction func checkAccountPress(_ sender: Any) {
        self.findAccount()
    }
    func findAccount() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let term: String = (self.accountNumberTxt.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!
        let type: String = "CARDNUMBER"
        BaseServices.shareInstance.findAccount(term: term, type: type) { (response, message, errorCode) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if errorCode == SUCCESS_CODE {
                self.nameTxt.text = FBDataCenter.sharedInstance.fullName
                self.tbSendMoney?.reloadData()
            } else  {
            }
            self.showToast(message: message ?? "",font: .systemFont(ofSize: 13.0))
        }
    }
    func tranferCard() {
        BaseServices.shareInstance.tranferCard(
            cardNumber: accountNumberTxt.text ?? "",
            amount: moneyInputTxt.text ?? "",
            fullName: nameTxt.text ?? "",
            pin: Int(pinCodeTxt.text ?? "") ?? 1,
            des: contentTxt.text ?? "abc") { (response, messsage, errorCode) in
                if errorCode == SUCCESS_CODE {
//                    "\(FBDataCenter.sharedInstance.account?.amount - Int(moneyInputTxt.text ?? "") ?? 1)"
                    self.idTranfer = response as? String
                    self.otpAlert()
                } else  {
                    self.showToast(message: response as! String,font: .systemFont(ofSize: 13.0))
                }
        }
    }
    
    func otpAlert() {
        let alert = UIAlertController(title: "Xác nhận mã OTP?", message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Gửi", style: .default) { (ACTION) in
            let code = alert.textFields![0].text ?? ""
            self.sendOtp(code: code)
            self.goDetailCard()
        }
        alert.addTextField { (txtDes) in
            txtDes.placeholder = "Nhập OTP "
            ok.isEnabled = false
        }
        NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object:alert.textFields?[0], queue: OperationQueue.main) { (notification) -> Void in
            let des = alert.textFields?[0] as? UITextField
            ok.isEnabled = !(des?.text?.isEmpty ?? false)
        }
        let cancel = UIAlertAction(title: "Hủy", style: .destructive) { (ACTION) in
            self.pinCodeTxt.text = ""
            self.nameTxt.text = ""
            self.contentTxt.text = ""
            self.accountNumberTxt.text = ""
            self.moneyInputTxt.text = ""
            print("cancel")
        }
        alert.addAction(ok)
        alert.addAction(cancel)
        self.present(alert, animated: true)
    }
    
    func sendOtp(code: String) {
        BaseServices.shareInstance.verifyOtpTranfer(idTranfer: self.idTranfer ?? "", otp: code) { (response, messsage, errorCode) in
            if errorCode == SUCCESS_CODE {
                self.idTranfer = response as? String
                self.otpAlert()
                let jsonData = JSON(response!)
                let status = jsonData["status"].int
                if status == 200 {
                    self.goDetailCard()
                }
            } else  {
                self.showToast(message: messsage ?? "",font: .systemFont(ofSize: 13.0))
            }
        }
    }
    func goDetail() {
        let successfullyVC = self.storyboard?.instantiateViewController(withIdentifier: "FBSuccessfulTransactionViewController") as! FBSuccessfulTransactionViewController
        successfullyVC.receiver = FBDataCenter.sharedInstance.fullName
        successfullyVC.accountsGet = self.accountNumberTxt.text
        let timestamp = DateFormatter.localizedString(from: NSDate() as Date, dateStyle: .medium, timeStyle: .short)
        successfullyVC.time = timestamp
        self.navigationController?.pushViewController(successfullyVC, animated: true)
        
    }
    func goDetailCard() {
        let successfullyVC = self.storyboard?.instantiateViewController(withIdentifier: "FBSuccessfulTransactionViewController") as! FBSuccessfulTransactionViewController
        successfullyVC.receiver = FBDataCenter.sharedInstance.fullName
        successfullyVC.accountsGet = self.accountNumberTxt.text
        let timestamp = DateFormatter.localizedString(from: NSDate() as Date, dateStyle: .medium, timeStyle: .short)
        successfullyVC.time = timestamp
        self.navigationController?.pushViewController(successfullyVC, animated: true)
        
    }
}
