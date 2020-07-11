//
//  FBUserDetailViewController.swift
//  FPT Banking
//
//  Created by hưng hoàng on 7/2/20.
//  Copyright © 2020 hưng hoàng. All rights reserved.
//

import UIKit

class FBUserDetailViewController: FBBaseViewController {
    
    @IBOutlet weak var avatarView: UIView!
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbDateOfBirth: UILabel!
    @IBOutlet weak var lbGender: UILabel!
    @IBOutlet weak var lbPhoneNumber: UILabel!
    @IBOutlet weak var lbEmail: UILabel!
    @IBOutlet weak var lbAddress: UILabel!
    @IBOutlet weak var lbIdCardNumber: UILabel!
    //view
    @IBOutlet weak var detailAvatarView: UIView!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var dateOfBirthView: UIView!
    @IBOutlet weak var genderView: UIView!
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var idCardNumberView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isBackgroundGray = true
    }
    override func initUI() {
        detailAvatarView.setMutilColorForView(nameColor: ColorName.CallBackground)
        nameView.setMutilColorForView(nameColor: ColorName.CallBackground)
        dateOfBirthView.setMutilColorForView(nameColor: ColorName.CallBackground)
        genderView.setMutilColorForView(nameColor: ColorName.CallBackground)
        phoneView.setMutilColorForView(nameColor: ColorName.CallBackground)
        emailView.setMutilColorForView(nameColor: ColorName.CallBackground)
        addressView.setMutilColorForView(nameColor: ColorName.CallBackground)
        idCardNumberView.setMutilColorForView(nameColor: ColorName.CallBackground)
    }
    override func initData() {
        lbName.text = FBDataCenter.sharedInstance.userInfo?.fullname
        lbDateOfBirth.text = FBDataCenter.sharedInstance.userInfo?.birthday
        lbGender.text = FBDataCenter.sharedInstance.userInfo?.gender
        lbPhoneNumber.text = FBDataCenter.sharedInstance.userInfo?.phone
        lbEmail.text = FBDataCenter.sharedInstance.userInfo?.email
        lbAddress.text = FBDataCenter.sharedInstance.userInfo?.address
        lbIdCardNumber.text = FBDataCenter.sharedInstance.userInfo?.idCardNumber
    }
    @IBAction func backPress(_ sender: Any) {
        backButtonPress()
    }
    
}
