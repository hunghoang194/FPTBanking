//
//  FBLoginViewController.swift
//  FPT Banking
//
//  Created by hưng hoàng on 6/16/20.
//  Copyright © 2020 hưng hoàng. All rights reserved.
//

import UIKit

class FBLoginViewController: UIViewController {
    @IBOutlet weak var userNameView: UIView!
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var btnLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        userNameView.setBorder(color: UIColor(red: 189, green: 189, blue: 189, alpha: 1), width: 1,isCircle: true, mutilColorName: ColorName.Gray4Clear)
        passwordView.setBorder(color: UIColor(red: 189, green: 189, blue: 189, alpha: 1), width: 1,isCircle: true, mutilColorName: ColorName.Gray4Clear)
        loginView.setBorder(color: UIColor(red: 189, green: 189, blue: 189, alpha: 1), width: 1,isCircle: true, mutilColorName: ColorName.Gray4Clear)
    }
    func validate() {
  
    }
    @IBAction func actionLoginPress(_ sender: Any) {
        let vc = UIStoryboard.
    }
    

}

