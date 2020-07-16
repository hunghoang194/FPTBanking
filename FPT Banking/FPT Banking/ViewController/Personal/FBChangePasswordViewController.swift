//
//  FBChangePasswordViewController.swift
//  FPT Banking
//
//  Created by hưng hoàng on 7/7/20.
//  Copyright © 2020 hưng hoàng. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
import SwiftyJSON

class FBChangePasswordViewController: FBBaseViewController {
    @IBOutlet weak var txtCurrentPass: UITextField!
    @IBOutlet weak var txtNewPass: UITextField!
    @IBOutlet weak var txtConfirmPass: UITextField!
    @IBOutlet weak var currentPassView: UIView!
    @IBOutlet weak var confirmPassView: UIView!
    @IBOutlet weak var newPassView: UIView!
    @IBOutlet weak var changePassView: UIView!
    @IBOutlet weak var btnChangePass: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
            self.isBackgroundGray = true
    }
    override func initUI() {
        txtCurrentPass.isSecureTextEntry = true
        txtConfirmPass.isSecureTextEntry = true
        txtNewPass.isSecureTextEntry = true
        currentPassView.setBorder(color: UIColor(red: 189, green: 189, blue: 189, alpha: 1), width: 1,isCircle: true, mutilColorName: ColorName.CallBackground)
        confirmPassView.setBorder(color: UIColor(red: 189, green: 189, blue: 189, alpha: 1), width: 1,isCircle: true, mutilColorName: ColorName.CallBackground)
        newPassView.setBorder(color: UIColor(red: 189, green: 189, blue: 189, alpha: 1), width: 1,isCircle: true, mutilColorName: ColorName.CallBackground)
        btnChangePass.setBorder(color: UIColor(red: 189, green: 189, blue: 189, alpha: 1), width: 1,isCircle: true)
    }
    @IBAction func backPres(_ sender: Any) {
        self.backButtonPress()
    }
    @IBAction func changedPass(_ sender: Any) {
        self.checkValidate()
    }
    func checkValidate() {
        let password: String = (self.txtNewPass.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!
        let confirmPass: String = (self.txtConfirmPass.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!
        let current:String = (self.txtCurrentPass.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!
        if !self.isValidPassword(testPass: password),!self.isValidPassword(testPass: confirmPass), !self.isValidPassword(testPass: current) {
            self.showPopup(string:"Mật khẩu không hợp lệ")
            return
        }
        if self.txtNewPass.text != self.txtConfirmPass.text {
            self.showPopup(string: "Mật khẩu không khớp")
        } else if  self.txtNewPass.text == self.txtConfirmPass.text {
            self.changePassword()
        }
    }
    func changePassword() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let password: String = (self.txtNewPass.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!
        let confirmPass: String = (self.txtConfirmPass.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!
        BaseServices.shareInstance.changePassword(password: password, passwordConfirm: confirmPass) { (response, message, errorCode) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if errorCode == SUCCESS_CODE {
                if response != nil {
                    let jsonData = JSON(response!)
                    self.txtNewPass.text = ""
                    self.txtConfirmPass.text = ""
                    self.alertSuccess()
                }
                else                     {
                    self.showPopup(string:"Thông tin không chính xác")
                }
            }
        }
    }
    func logOut() {
        let logOutVC = self.storyboard?.instantiateViewController(withIdentifier: "FBLoginViewController") as! FBLoginViewController
        self.navigationController?.pushViewController(logOutVC, animated: true)
    }
    func alertSuccess() {
        let alert = UIAlertController(title: "Thông báo", message: "Bạn đã đổi mật khẩu thành công", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Đông ý", style: UIAlertAction.Style.default, handler: { (ACTION) in
            self.logOut()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
