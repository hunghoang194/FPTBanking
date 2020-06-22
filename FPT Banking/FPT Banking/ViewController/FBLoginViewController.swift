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

class FBLoginViewController: UIViewController {
    @IBOutlet weak var userNameView: UIView!
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var btnLogin: UIButton!
    
    var savedResJson: JSON = JSON(parseJSON: "{}")
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        userNameView.setBorder(color: UIColor(red: 189, green: 189, blue: 189, alpha: 1), width: 1,isCircle: true, mutilColorName: ColorName.Gray4Clear)
        passwordView.setBorder(color: UIColor(red: 189, green: 189, blue: 189, alpha: 1), width: 1,isCircle: true, mutilColorName: ColorName.Gray4Clear)
        loginView.setBorder(color: UIColor(red: 189, green: 189, blue: 189, alpha: 1), width: 1,isCircle: true, mutilColorName: ColorName.Gray4Clear)
    }
    
    // check validate login
    func checkValid() -> Bool {
        var check:Bool = true
        var message = NSLocalizedString("Vui lòng nhập tài khoản của bạn", comment: "")
        if WTUtilitys.isEmptyString(textCheck: self.txtUserName?.text) {
            check = false
        }
        else if WTUtilitys.isEmptyString(textCheck: self.txtPassword?.text)
        {
            message = NSLocalizedString("Vui lòng nhập mật khẩu của bạn", comment: "")
        }
//        if !check {
//            Toast.init(text: message, delay: 0, duration: 2.0).show()
//        }
        return check
    }
    //    @IBAction func onRecoverPass(_ sender: Any) {
    //        self.toForgotPass()
    //    }
    
    @IBAction func actionLoginPress(_ sender: Any) {
//        if checkValid() {
//            MBProgressHUD.showAdded(to: self.view, animated: true)
//            FBServices.shareInstance.checkLogin(username: txtUserName.text ?? "") { (response, message, errorCode) in
//                MBProgressHUD.hide(for: self.view, animated: true)
//                if errorCode == SUCCESS_CODE {
//                    if (response as? [JSON])?.count ?? 0 > 0{
//                        let alert = UIAlertController(title: AppConstant.Alert.Title.alert, message: AppConstant.Alert.Message.login_notification, preferredStyle: .alert)
//                        alert.addAction(UIAlertAction.init(title: AppConstant.Alert.Action.yes, style: .default, handler: { (action) in
//                            self.login()
//                        }))
//                        alert.addAction(UIAlertAction.init(title: AppConstant.Alert.Action.no, style: .cancel, handler: { (action) in
//
//                        }))
//                        self.present(alert, animated: true, completion: nil)
//                    }
//                    else{
//                        self.login()
//                    }
//                }
//                else{
//                    Toast(text: message, duration: 3.0).show()
//                }
//            }
//        }
    }
    func login() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        FBServices.shareInstance.login(username: txtUserName.text!, password: txtPassword.text!) { (response, message, error) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if error == SUCCESS_CODE {
                if response != nil {
                    let resJson = JSON.init(response!)
                    FBDataCenter.sharedInstance.userInfo = FBUserProfile.init(json: resJson["data"]["data"])
                    FBKeychainService.savePassword(token:self.txtPassword.text ?? "")
                    FBKeychainService.saveUsername(token:self.txtUserName.text ?? "")
                    FBKeychainService.saveToken(token:"Bearer \(resJson["data"]["access_token"].string ?? "")")
                    print("TEST access_token login: \("Bearer \(resJson["data"]["access_token"].string ?? "")")")
                    
                    let encodedData = NSKeyedArchiver.archivedData(withRootObject: FBDataCenter.sharedInstance.userInfo!)
                    UserDefaults.standard.set(encodedData, forKey: "save_user_obj")
                    FBDataCenter.sharedInstance.token = "Bearer \(resJson["data"]["access_token"].string ?? "")"
                    self.savedResJson = resJson
                }
            } else {
//                Toast.init(text: message).show()
            }
        }
    }
}


