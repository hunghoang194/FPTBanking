//
//  FBConfirmOTPViewController.swift
//  FPT Banking
//
//  Created by hưng hoàng on 7/17/20.
//  Copyright © 2020 hưng hoàng. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MBProgressHUD

class FBConfirmOTPViewController: FBBaseViewController {
    @IBOutlet weak var pinView: UIView!
    @IBOutlet weak var txtPinCode: UITextField!
    @IBOutlet weak var btnConfirm: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isBackgroundGray = true
    }
    override func initUI() {
        pinView.setBorder(color: UIColor(red: 189, green: 189, blue: 189, alpha: 1), width: 1,isCircle: true, mutilColorName: ColorName.CallBackground)
        btnConfirm.setBorder(color: UIColor(red: 189, green: 189, blue: 189, alpha: 1), width: 1,isCircle: true)

    }
    @IBAction func backPress(_ sender: Any) {
        self.backButtonPress()
    }
    //bay h check cai gi
    @IBAction func confirmOTP(_ sender: Any) {
    }
    
}
