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
    var userInfo = [FBLogin]()
    
    var savedResJson: JSON = JSON(parseJSON: "{}")
    override func viewDidLoad() {
        super.viewDidLoad()
        dismissKeyboard()
    }
    override func viewDidLayoutSubviews() {
        userNameView.setBorder(color: UIColor(red: 189, green: 189, blue: 189, alpha: 1), width: 1,isCircle: true, mutilColorName: ColorName.Gray4Clear)
        passwordView.setBorder(color: UIColor(red: 189, green: 189, blue: 189, alpha: 1), width: 1,isCircle: true, mutilColorName: ColorName.Gray4Clear)
        loginView.setBorder(color: UIColor(red: 189, green: 189, blue: 189, alpha: 1), width: 1,isCircle: true, mutilColorName: ColorName.Gray4Clear)
    }
    
    // check validate login
    func checkValidUserName() {
        let userName: String = (self.txtUserName.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!
        let password: String = (self.txtPassword.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!
        //check nhap tk/mk
        if (userName.isEmpty || password.isEmpty ) {
        self.showToast(message: "Bạn chưa nhập tài khoản hoặc mật khẩu của mình",font: .systemFont(ofSize: 13.0))
            return
        }
        //check do dai pass
        if !self.isValidPassword(testPass: password) {
        self.showToast(message: "Password không hợp lệ",font: .systemFont(ofSize: 13.0))
            return
        }
        postDataWithBody()
    }
    @IBAction func actionLoginPress(_ sender: Any) {
        self.checkValidUserName()
    }
    
    func postDataWithBody() {
            MBProgressHUD.showAdded(to: self.view, animated: true)
            let userName: String = (self.txtUserName.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!
            let password: String = (self.txtPassword.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!
            let url = "http://198.119.45.100:8080/api/user/auth/login"
            let param = ["usernameOrEmail":userName,"password":password]
            if let jsonData = try? JSONEncoder().encode(param) {
                var request = URLRequest(url: URL(string: url)!)
                request.httpMethod = HTTPMethod.post.rawValue
                request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
                request.httpBody = jsonData
                Alamofire.request(request).responseJSON {
                    (response) in
                    MBProgressHUD.hide(for: self.view, animated: true)
                    debugPrint(response)
                    if response.result.isSuccess {
                        self.userInfo = ((jsonData as? [FBLogin]) ?? [FBLogin]())
                        }
                    }
                }
            }
        }


