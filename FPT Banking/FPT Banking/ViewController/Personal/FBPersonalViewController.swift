//
//  FBPersonalViewController.swift
//  FPT Banking
//
//  Created by hưng hoàng on 6/30/20.
//  Copyright © 2020 hưng hoàng. All rights reserved.
//

import UIKit

class FBPersonalViewController: FBBaseViewController {
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var avataView: AvatarView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbCardNumber: UILabel!
    @IBOutlet weak var lbVersion: UILabel!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var btnLogout: UIButton!
    @IBOutlet weak var btnChangePass: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbVersion.text = "1.0 by FPT Banking"

        // Do any additional setup after loading the view.
    }
    @IBAction func infoAccountPress(_ sender: Any) {
    }
    @IBAction func callPress(_ sender: Any) {
    }
    @IBAction func switchAccountPress(_ sender: Any) {
    }
    @IBAction func logoutPress(_ sender: Any) {
    }
    @IBAction func changePassPress(_ sender: Any) {
    }
    

}
