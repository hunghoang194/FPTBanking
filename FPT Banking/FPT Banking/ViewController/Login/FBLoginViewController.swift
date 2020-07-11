//
//  FBLoginViewController.swift
//  FPT Banking
//
//  Created by hưng hoàng on 6/16/20.
//  Copyright © 2020 hưng hoàng. All rights reserved.
//

import UIKit
import Toast_Swift
import MBProgressHUD
import Alamofire
import SwiftyJSON

class FBLoginViewController: FBBaseViewController {
    @IBOutlet weak var userNameView: UIView!
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var logoView: UIView!
    var userInfo = [FBLogin]()
    
    var savedResJson: JSON = JSON(parseJSON: "{}")
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isBackgroundGray = true
        dismissKeyboard()
        txtPassword.isSecureTextEntry = true
    }
    override func viewDidLayoutSubviews() {
        userNameView.setBorder(color: UIColor(red: 189, green: 189, blue: 189, alpha: 1), width: 1,isCircle: true)
        logoView.setBorder(color: UIColor(red: 189, green: 189, blue: 189, alpha: 1), width: 1,isCircle: true)
        passwordView.setBorder(color: UIColor(red: 189, green: 189, blue: 189, alpha: 1), width: 1,isCircle: true)
        loginView.setBorder(color: UIColor(red: 189, green: 189, blue: 189, alpha: 1), width: 1,isCircle: true, mutilColorName: ColorName.CallBackground)
        passwordView.setMutilColorForView(nameColor: ColorName.CallBackground)
        userNameView.setMutilColorForView(nameColor: ColorName.CallBackground)
    }
    
    // check validate login
    func checkValidUserName() {
        let userName: String = (self.txtUserName.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!
        let password: String = (self.txtPassword.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!
        //check nhap tk/mk
        if (userName.isEmpty || password.isEmpty ) {
            self.showPopup(string:"Bạn chưa nhập tài khoản hoặc mật khẩu của mình")
            return
        }
        //check do dai pass
        if !self.isValidPassword(testPass: password) {
            self.showPopup(string:"Mật khẩu không hợp lệ")
            return
        }
        self.checkLogin()
    }
    @IBAction func actionLoginPress(_ sender: Any) {
        self.checkValidUserName()
    }
    
    func checkLogin() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let userName: String = (self.txtUserName.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!
        let password: String = (self.txtPassword.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!
        BaseServices.shareInstance.login(username: userName, password: password) { (response, message, errorCode) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if errorCode == SUCCESS_CODE {
                self.getDetailUser()
            } else  {
                 var errMesaage = message ?? "Lỗi api"
                if response != nil {
                    let jsonData = JSON(response!)
                    let status = jsonData["status"].int
                    let countError = jsonData["loggedInFailedTime"].int
                    if status == 403, countError == 1 {
                        errMesaage = "Nhập sai mật khẩu 1 lần , còn \(countError ?? 0) lần"
                    } else if status == 403, countError == 2 {
                        errMesaage = "Nhập sai mật khẩu 2 lần , còn \(countError ?? 0) lần"
                    } else if status == 403, countError == 3 {
                        errMesaage = "Nhập sai mật khẩu 3 lần , còn \(countError ?? 0) lần"
                    } else if status == 403, countError ?? 0 >= 4 {
                        errMesaage = "Nhập sai mật khẩu quá 3 lần vui lòng liên hệ admin để mở khoá"
                    }
                }
                self.showToast(message: errMesaage,font: .systemFont(ofSize: 13.0))
            }
        }
    }
    
    func getDetailUser() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        BaseServices.shareInstance.detailUser { (response, message, errorCode) in
            MBProgressHUD.hide(for: self.view, animated: true)
            self.goListCard()
        }
    }
}


