//
//  FBSendMoneyViewController.swift
//  FPT Banking
//
//  Created by hưng hoàng on 7/1/20.
//  Copyright © 2020 hưng hoàng. All rights reserved.
//

import UIKit
import MBProgressHUD
import Alamofire
import SwiftyJSON

class FBSendMoneyInBankViewController: FBBaseViewController {
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
    var obj : FBUserProfile?
    var data: FBListAccount?
    var profileUser = [FBListAccount]()
    var idTranfer: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isBackgroundGray = true
        pinCodeTxt.isSecureTextEntry = true
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("ReloadAmountNotification"), object: nil)
    }
    
    @objc func methodOfReceivedNotification(notification: Notification) {
        getDetailAccount()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("ReloadAmountNotification"), object: nil)
    }
    
    override func initUI() {
        cardNumberSendView.setBorder(color: UIColor(red: 189, green: 189, blue: 189, alpha: 1), width: 1,isCircle: true, mutilColorName: ColorName.CallBackground)
        inputMoneyView.setBorder(color: UIColor(red: 189, green: 189, blue: 189, alpha: 1), width: 1,isCircle: true, mutilColorName: ColorName.CallBackground)
        contentView.setBorder(color: UIColor(red: 189, green: 189, blue: 189, alpha: 1), width: 1,isCircle: true, mutilColorName: ColorName.CallBackground)
        pinCodeView.setBorder(color: UIColor(red: 189, green: 189, blue: 189, alpha: 1), width: 1,isCircle: true, mutilColorName: ColorName.CallBackground)
        nameView.setBorder(color: UIColor(red: 189, green: 189, blue: 189, alpha: 1), width: 1,isCircle: true, mutilColorName: ColorName.CallBackground)
        btnSendMoney.setBorder(color: UIColor(red: 189, green: 189, blue: 189, alpha: 1), width: 1,isCircle: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setAmount(data: data)
        lbAmount.text =  "\(FBDataCenter.sharedInstance.account?.amount?.formatnumber() ?? "") "
    }
    
    override func initData() {
        lbName.text = FBDataCenter.sharedInstance.userInfo?.fullname
        lbAccountNumber.text = FBDataCenter.sharedInstance.account?.accountNumber
        lbAmount.text =  "\(FBDataCenter.sharedInstance.account?.amount?.formatnumber() ?? "") "
    }
    
    @IBAction func checkAccount(_ sender: Any) {
        self.validateAccount()
    }
    @IBAction func backPress(_ sender: Any) {
        backButtonPress()
    }
    
    @IBAction func sendMoneyPress(_ sender: Any) {
        self.checkForm()
    }
    func getDetailAccount() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        BaseServices.shareInstance.getAccount { (response, message, errorCode) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let data = response as? [FBListAccount]{
                self.profileUser = data
            }
        }
    }
    func findAccount() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let term: String = (self.accountNumberTxt.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!
        let type: String = "ACCOUNTNUMBER"
        BaseServices.shareInstance.findAccount(term: term, type: type) { (response, message, errorCode) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if errorCode == SUCCESS_CODE {
                self.nameTxt.text = FBDataCenter.sharedInstance.fullName
                self.tbSendMoney?.reloadData()
            } else if errorCode != SUCCESS_CODE {
                self.showPopup(string: "Tài khoản bạn nhập không chính xác")
            }
        }
    }
    func checkForm() {
        let amount: String = (self.moneyInputTxt.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!
        let account: String = (self.accountNumberTxt.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!
        let pin: String = (self.pinCodeTxt.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!
        let content: String = (self.contentTxt.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!
        if amount.isEmpty || account.isEmpty || pin.isEmpty || content.isEmpty{
            self.showPopup(string:"Thông tin không được để trống")
        }
        if !isValidForm(testAccount: amount){
            self.showPopup(string:"Tài khoản không đủ số dư để thực hiện giao dịch. Quý khách vui lòng thử lại")
            return
        }
        self.tranfer()
    }
    func validateAccount() {
        let accountNumber: String = (self.accountNumberTxt.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!
        if !isValidAccount(testAccount: accountNumber) {
            self.showPopup(string:"Số tài khoản bạn nhập không đúng định dạng")
            return
        }
        self.findAccount()
    }
    func setAmount(data: FBListAccount?) {
        self.lbAmount.text = "\(data?.amount ?? 0)"
    }
    func tranfer() {
        BaseServices.shareInstance.tranfer(
            accountNumber: accountNumberTxt.text ?? "",
            amount: moneyInputTxt.text ?? "",
            fullName: nameTxt.text ?? "",
            pin: Int(pinCodeTxt.text ?? "") ?? 1,
            des: contentTxt.text ?? "abc") { (response, messsage, errorCode) in
                if errorCode == SUCCESS_CODE {
                    self.idTranfer = response as? String
                    self.otpAlert()
                    self.getDetailAccount()
                } else  {
                    print(messsage ?? "")
                }
        }
    }
    
    func otpAlert() {
        let alert = UIAlertController(title: "Xác nhận mã OTP?", message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Gửi", style: .default) { (ACTION) in
            let code = alert.textFields![0].text ?? ""
            NotificationCenter.default.post(name: Notification.Name("ReloadAmountNotification"), object: nil, userInfo: [:])
            self.sendOtp(code: code)
            self.getDetailAccount()
            self.goDetail()
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
                    self.goDetail()
                    //send
                }
            } else if response != nil {
                let jsonData = JSON(response!)
                let status = jsonData["status"].int
                if status == 200 {
                    self.goDetail()
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
        successfullyVC.amount = self.moneyInputTxt.text
        let timestamp = DateFormatter.localizedString(from: NSDate() as Date, dateStyle: .medium, timeStyle: .short)
        successfullyVC.time = timestamp
        self.navigationController?.pushViewController(successfullyVC, animated: true)
        
    }
    
}
