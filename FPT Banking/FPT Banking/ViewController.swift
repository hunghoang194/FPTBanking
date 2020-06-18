//
//  ViewController.swift
//  FPT Banking
//
//  Created by hưng hoàng on 6/16/20.
//  Copyright © 2020 hưng hoàng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
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
        loginView.layer.borderWidth = 10
        loginView.layer.masksToBounds = true
        passwordView.layer.borderWidth = 10
        passwordView.layer.masksToBounds = true
        userNameView.layer.borderWidth = 10
        userNameView.layer.masksToBounds = true

    }
    func validate() {
        if txtPassword == nil
    }
    @IBAction func actionLoginPress(_ sender: Any) {
    }
    

}

