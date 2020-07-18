//
//  FBPersonalViewController.swift
//  FPT Banking
//
//  Created by hưng hoàng on 6/30/20.
//  Copyright © 2020 hưng hoàng. All rights reserved.
//

import UIKit

class FBPersonalViewController: FBBaseViewController {
    @IBOutlet weak var avataView: UIView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbCardNumber: UILabel!
    @IBOutlet weak var lbVersion: UILabel!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var btnLogout: UIButton!
    @IBOutlet weak var btnChangePass: UIButton!
    //view
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var helpView: UIView!
    @IBOutlet weak var switchAccountView: UIView!
    @IBOutlet weak var questionView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isBackgroundGray = true
    }
    override func initUI() {
        detailView.setMutilColorForView(nameColor: ColorName.CallBackground)
        helpView.setMutilColorForView(nameColor: ColorName.CallBackground)
        switchAccountView.setMutilColorForView(nameColor: ColorName.CallBackground)
//        questionView.setMutilColorForView(nameColor: ColorName.CallBackground)
        
        lbVersion.text = "1.0 by FPT Banking"
        avataView.setBorder(color: UIColor(red: 189, green: 189, blue: 189, alpha: 1), width: 1,isCircle: true, mutilColorName: ColorName.CallBackground)
        btnLogout.setBorder(color: UIColor(red: 189, green: 189, blue: 189, alpha: 1), width: 1,isCircle: true)
        btnChangePass.setBorder(color: UIColor(red: 189, green: 189, blue: 189, alpha: 1), width: 1,isCircle: true)
        lbName.text = FBDataCenter.sharedInstance.userInfo?.fullname
        lbCardNumber.text = FBDataCenter.sharedInstance.account?.accountNumber
    }
    @IBAction func infoAccountPress(_ sender: Any) {
        let userDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "FBUserDetailViewController") as! FBUserDetailViewController
        self.navigationController?.pushViewController(userDetailVC, animated: true)
    }
    @IBAction func frequentlyAskedQuestions(_ sender: Any) {
        let questionVC = self.storyboard?.instantiateViewController(withIdentifier: "FBQuestionViewController") as! FBQuestionViewController
        self.navigationController?.pushViewController(questionVC, animated: true)
    }
    @IBAction func callPress(_ sender: Any) {
        let helpVC = self.storyboard?.instantiateViewController(withIdentifier: "FBHelpViewController") as! FBHelpViewController
        self.navigationController?.pushViewController(helpVC, animated: true)
    }
    @IBAction func switchAccountPress(_ sender: Any) {
        self.goListCard()
    }
    @IBAction func logoutPress(_ sender: Any) {
        let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "FBLoginViewController") as! FBLoginViewController
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    @IBAction func changePassPress(_ sender: Any) {
        let changePassVC = self.storyboard?.instantiateViewController(withIdentifier: "FBChangePasswordViewController") as! FBChangePasswordViewController
        self.navigationController?.pushViewController(changePassVC, animated: true)        
    }
    
    
}
