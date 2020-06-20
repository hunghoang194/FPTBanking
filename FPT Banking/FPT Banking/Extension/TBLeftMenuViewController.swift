//
//  TBLeftMenuViewController.swift
//  FPT Banking
//
//  Created by Hung Hoang on 6/19/20.
//  Copyright © 2020 hưng hoàng. All rights reserved.
//

import UIKit
import Toast_Swift
import MBProgressHUD

class TBLeftMenuViewController: UIViewController {
    @IBOutlet weak var tbMenu: UITableView!
    @IBOutlet weak var avatar: AvatarView!
    @IBOutlet weak var dropList: KPDropMenu?
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbHead: UILabel!
    @IBOutlet weak var lbVersion: UILabel!
    @IBOutlet weak var lbPermission: UILabel!

    @IBOutlet weak var btnChangePass: UIButton!
    @IBOutlet weak var btnLogout: UIButton!
    @IBOutlet weak var btnRecoverPass: UIButton!
    
    weak var delegate: TBLeftMenuDelegate?
    var menuList = [HDMenuObj]()
    override func viewDidLoad() {
        super.viewDidLoad()
        lbVersion.text = "Phiên bản: \(WTUtilitys.getVersionApp())"
        lbHead.adjustsFontSizeToFitWidth = true
        dropList?.viewBase = AppDelegate.sharedInstance.window
        dropList?.itemsFont = UIFont.init(name: "Montserrat-Regular", size: 13.0)
        // Do any additional setup after loading the view.
        self.btnLogout.layer.cornerRadius = 15.0
        self.btnChangePass.layer.cornerRadius = 15.0
        self.btnRecoverPass.layer.cornerRadius = 15.0
        self.avatar.image = UIImage.init(named: "logo_bike")
        NotificationCenter.default.addObserver(self, selector: #selector(reloadMenu), name: Notification.Name.init("reload_menu"), object: nil)
        tbMenu.register(UINib.init(nibName: "HDMenuTableViewCell", bundle: nil), forCellReuseIdentifier: "HDMenuTableViewCell")
        tbMenu.delegate = self
        tbMenu.dataSource = self
        lbName.setTextColorForIos13(nameColor: ColorName.NameColor)
//        self.btnLogout.setMutilColorForView(nameColor: ColorName.BlackRedButtonColor)
//        self.btnChangePass.setMutilColorForView(nameColor: ColorName.BlackRedButtonColor)
//        self.btnRecoverPass.setMutilColorForView(nameColor: ColorName.BlackRedButtonColor)
    }

    @objc func reloadMenu() {
        lbName.text = HDDataCenter.sharedInstance.userInfo?.displayName
        if HDDataCenter.sharedInstance.typeAccount == .CS {
            lbHead.isHidden = true
            lbPermission.text = "CS"
            loadItemMenu(isShowReport: true, isHeadSale: false)
        } else {
            lbHead.isHidden = false
            lbHead.text = HDDataCenter.sharedInstance.userInfo?.headName
            switch HDDataCenter.sharedInstance.typeAccount {
            case .Head_staff:
                lbPermission.text = "Nhân viên"
                loadItemMenu(isShowReport: false, isHeadSale: false)
            case .Head_manager:
                lbPermission.text = "Quản lý"
                loadItemMenu(isShowReport: true, isHeadSale: false)
            case .Head_manager_sale:
                lbPermission.text = "Nhân viên bán hàng"
                loadItemMenu(isShowReport: true, isHeadSale: true)
            default:
                lbPermission.text = "Quản lý"
                loadItemMenu(isShowReport: true, isHeadSale: false)
                break
            }
        }
    }
    
    //MARK: load Item menu
    func loadItemMenu(isShowReport: Bool, isHeadSale: Bool) {
        menuList.removeAll()
        let homeMenu = HDMenuObj()
        homeMenu.id = 0
        homeMenu.image = "ic_home"
        homeMenu.title = "Trang chủ"
        menuList.append(homeMenu)

        // check type account
        if HDDataCenter.sharedInstance.typeAccount == .Manager_report {
            let listReportId = [11, 12]
            let listTileReport = ["Báo cáo self-study", "Báo cáo OJT"]
            for (i, str) in listTileReport.enumerated() {
                let reportMenu = HDMenuObj()
                reportMenu.id = listReportId[i]
                reportMenu.image = "ic_bar_chart"
                reportMenu.title = str
                menuList.append(reportMenu)
            }
        } else {
            // check account head sale
            if !isHeadSale {
                let faqMenu = HDMenuObj()
                faqMenu.id = 1
                faqMenu.image = "ic_faq"
                faqMenu.title = "Vấn đề thường gặp"
                menuList.append(faqMenu)
                let refMenu = HDMenuObj()
                refMenu.id = 2
                refMenu.image = "ic_reference"
                refMenu.title = "Học trực tuyến"
                menuList.append(refMenu)
                let catalogMenu = HDMenuObj()
                catalogMenu.id = 3
                catalogMenu.image = "ic_catalog"
                catalogMenu.title = "Sách phụ tùng"
                menuList.append(catalogMenu)
                if isShowReport {
                    let reportMenu = HDMenuObj()
                    reportMenu.id = 4
                    reportMenu.image = "ic_my_report"
                    reportMenu.title = "Danh sách báo cáo"
                    menuList.append(reportMenu)
                }
                let itemTermOfUse = HDMenuObj()
                itemTermOfUse.id = 7
                itemTermOfUse.image = "ic_info"
                itemTermOfUse.title = "Điều khoản sử dụng"
                menuList.append(itemTermOfUse)
            } else {
                let managerPictureMenu = HDMenuObj()
                managerPictureMenu.id = 1
                managerPictureMenu.image = "ic_camera"
                managerPictureMenu.title = "Chụp ảnh bảo hành"
                menuList.append(managerPictureMenu)
                let tackingPictureMenu = HDMenuObj()
                tackingPictureMenu.id = 2
                tackingPictureMenu.image = "ic_reference"
                tackingPictureMenu.title = "Quản lý DK CNBH"
                menuList.append(tackingPictureMenu)
            }
        }
        tbMenu.reloadData()
    }

    func handlerSlideMenu() {
        if isRightMenu == true {
            slideMenuController()?.toggleRight()
        } else {
            slideMenuController()?.toggleLeft()
        }
        slideMenuController()?.closeLeft()
        slideMenuController()?.closeRight()
    }

    // goto Home
    func gotoHome() {
        handlerSlideMenu()
        DispatchQueue.main.async {
            AppDelegate.sharedInstance.mainNavigation?.popToViewController(AppDelegate.sharedInstance.mainNavigation?.viewControllers[1] ?? UIViewController(), animated: true)
        }
    }

    // goto TableView index one
    func gotoMenuOne() {
        handlerSlideMenu()
        DispatchQueue.main.async {
            if HDDataCenter.sharedInstance.typeAccount == .Head_manager_sale {
                let managerPicture = UIStoryboard.init(name: AppDelegate.sharedInstance.storyboardName, bundle: nil).instantiateViewController(withIdentifier: "TackingPictureController") as! TackingPictureController
                AppDelegate.sharedInstance.mainNavigation?.pushViewController(managerPicture, animated: true)
            } else {
                let faqVC = UIStoryboard.init(name: AppDelegate.sharedInstance.storyboardName, bundle: nil).instantiateViewController(withIdentifier: "HDListFAQViewController") as! HDListFAQViewController
                AppDelegate.sharedInstance.mainNavigation?.pushViewController(faqVC, animated: true)
            }
        }
    }

    // goto TableView index Two
    func gotoMenuTwo() {
        handlerSlideMenu()
        DispatchQueue.main.async {
            if HDDataCenter.sharedInstance.typeAccount == .Head_manager_sale {
                let tackingPicture = UIStoryboard.init(name: AppDelegate.sharedInstance.storyboardName, bundle: nil).instantiateViewController(withIdentifier: "ManagerPictureController") as! ManagerPictureController
                AppDelegate.sharedInstance.mainNavigation?.pushViewController(tackingPicture, animated: true)
            } else {
                let vc = ElearningUltil.share.getVcElearning()
                AppDelegate.sharedInstance.mainNavigation?.pushViewController(vc, animated: true)
            }
        }
    }
    func gotoPartCatalog() {
        handlerSlideMenu()
        DispatchQueue.main.async {
            let catalogVC = UIStoryboard.init(name: AppDelegate.sharedInstance.storyboardName, bundle: nil).instantiateViewController(withIdentifier: "HDCatalogViewController") as! HDCatalogViewController
            AppDelegate.sharedInstance.mainNavigation?.pushViewController(catalogVC, animated: true)
        }
    }

    func gotoListReport() {
        handlerSlideMenu()
        DispatchQueue.main.async {
            let reportListOpen = UIStoryboard.init(name: AppDelegate.sharedInstance.storyboardName, bundle: nil).instantiateViewController(withIdentifier: "HDListReportSearchViewController") as! HDListReportSearchViewController
            reportListOpen.typeVC = .MY_REPORT
            AppDelegate.sharedInstance.mainNavigation?.pushViewController(reportListOpen, animated: true)
        }
    }

    func gotoTerm() {
        slideMenuController()?.closeLeft()
        slideMenuController()?.closeRight()
    }

    func gotoHelp() {
        slideMenuController()?.closeLeft()
        slideMenuController()?.closeRight()
    }

    func gotoTermOfUse() {
        handlerSlideMenu()
        DispatchQueue.main.async {
            let termOfUseVC = HDAgreementViewController()
            AppDelegate.sharedInstance.mainNavigation?.pushViewController(termOfUseVC, animated: true)
        }
    }

    func gotoLearningCenter() {
        slideMenuController()?.closeLeft()
        slideMenuController()?.closeRight()
        let level = MTLevelUltil.share.getListLevel()
        AppDelegate.sharedInstance.mainNavigation?.pushViewController(level, animated: true)
    }

    func gotoOJT() {
        slideMenuController()?.closeLeft()
        slideMenuController()?.closeRight()
        let vcOJT = ElearningUltil.share.getActivityOJT()
        AppDelegate.sharedInstance.mainNavigation?.pushViewController(vcOJT, animated: true)
    }
    func gotoChangepass() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            let changePassVC = UIStoryboard.init(name: AppDelegate.sharedInstance.storyboardName, bundle: nil).instantiateViewController(withIdentifier: "HDChangePassViewController") as! HDChangePassViewController
            AppDelegate.sharedInstance.mainNavigation?.pushViewController(changePassVC, animated: true)
        }
    }
    // MARK: to thu vien ky thuat
    func gotoReference() {
        if AppDelegate.sharedInstance.isPad {
            let vcCourse = ReferenceUltil.share.getVCCourse()
            self.navigationController?.pushViewController(vcCourse, animated: true)
        }
        else{
            let vcListRefence = ReferenceUltil.share.getVCListReference()
            self.navigationController?.pushViewController(vcListRefence, animated: true)
        }
    }
    func actionLogout() {
        KLCPopup.dismissAllPopups()
        handlerSlideMenu()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            let viewAccept: VEAcceptPopupView = Bundle.main.loadNibNamed("VEAcceptPopupView", owner: nil, options: nil)![0] as! VEAcceptPopupView
            let popUp: KLCPopup = KLCPopup.init(contentView: viewAccept, showType: KLCPopupShowType.bounceInFromBottom, dismissType: KLCPopupDismissType.growOut, maskType: KLCPopupMaskType.dimmed, dismissOnBackgroundTouch: true, dismissOnContentTouch: false)
            viewAccept.lbMessage.setTextColorToSystemColor()
            viewAccept.lbMessage.text = "Bạn có muốn đăng xuất?"
            viewAccept.delegate = self
            viewAccept.popup = popUp
            popUp.show()
        }
    }
    
    @IBAction func recoverPasswordPressed(_ sender: Any) {
        handlerSlideMenu()
        if delegate?.onPressRecoverPass != nil {
            delegate?.onPressRecoverPass?()
            return
        }
        self.toForgotPass()
    }
    
    @IBAction func changePasswordPressed(_ sender: Any) {
        handlerSlideMenu()
        if delegate?.onPressChangepass != nil {
            delegate?.onPressChangepass?()
            return
        }
        self.gotoChangepass()
    }
    
    // MAR: to forgot pass
    func toForgotPass() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            let vcForgotPass = ForgotPassUltil.share.getVCForgotPass()
            vcForgotPass.isFirstLogin = true
            AppDelegate.sharedInstance.mainNavigation?.pushViewController(vcForgotPass, animated: true)
        }
    }
    
    @IBAction func onLogoutPressed(_ sender: Any) {
        KLCPopup.dismissAllPopups()
        handlerSlideMenu()
        if delegate?.onPressLogout != nil {
            delegate?.onPressLogout?()
            return
        }
        actionLogout()
    }
    
    //MARK: to report Study
    func toReportStudy() {
        handlerSlideMenu()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            let vcReportStudy = HomeUltil.share.getVCReportStudy()
            AppDelegate.sharedInstance.mainNavigation?.pushViewController(vcReportStudy, animated: true)
        }
    }
    
    //MARK: to report OJT
    func toReportOJT() {
        handlerSlideMenu()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            let vcReportOjt = HomeUltil.share.getVCReportOjt()
            AppDelegate.sharedInstance.mainNavigation?.pushViewController(vcReportOjt, animated: true)
        }
    }
}
extension TBLeftMenuViewController: VEAcceptPopupDelegate
{
    func onCancelPopupPressed() {
        delegate?.onCancelLogout?()
    }

    func onAcceptPopupPressed() {
        self.logout()
    }
    
    func logout() {
        KLCPopup.dismissAllPopups()
        self.delegate?.logout()
        MBProgressHUD.showAdded(to: self.view, animated: true)
        HDServices.shareInstance.logout { (response, message, errorCode) in
            MBProgressHUD.hide(for: self.view, animated: true)
            self.delegate?.logoutSuccess()
            UIApplication.shared.applicationIconBadgeNumber = 0
            UserDefaults.standard.removeObject(forKey: "save_user_obj")
            UserDefaults.standard.removeObject(forKey: "save_type_user")
            HDKeychainService.saveToken(token: "")
            HDKeychainService.savePassword(token: "")
            HDKeychainService.saveUsername(token: "")
            HDDataCenter.sharedInstance.token = ""
            HDDataCenter.sharedInstance.userInfo = nil
            HDDataCenter.sharedInstance.arrHead = nil
            HDDataCenter.sharedInstance.typeAccount = nil
            HDDataCenter.sharedInstance.token = ""
            HDDataCenter.sharedInstance.userInfo = nil
            HDDataCenter.sharedInstance.arrHead = nil
            HDDataCenter.sharedInstance.typeAccount = nil
            Analytics.logEvent("logout", parameters: [:])
            Toast(text: "Đăng xuất thành công.", duration: 3.0).show()
            DispatchQueue.main.async {
                AppDelegate.sharedInstance.mainNavigation?.popToRootViewController(animated: true)
            }

        }
    }

}
extension TBLeftMenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HDMenuTableViewCell", for: indexPath) as! MenuTableViewCell
        cell.imgCover.image = UIImage(named: menuList[indexPath.row].image ?? "")
        cell.lbTitle.text = menuList[indexPath.row].title
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if delegate?.onLeftMenuAction != nil {
            //phuc vu kiem tra chuyen man o man lam bai ktra
            handlerSlideMenu()
            delegate?.onLeftMenuAction?(index: indexPath.row)
        } else {
            handerAction(index: indexPath.row)
        }
    }

    func handerAction(index: Int) {
        let obj = menuList[index]
//        switch obj.id ?? 0 {
//        case 0:
//            self.gotoHome()
//        case 1:
//            self.gotoMenuOne()
//        case 2:
//            self.gotoMenuTwo()
//        case 3:
//            self.gotoPartCatalog()
//        case 4:
//            self.gotoListReport()
//        case 5:
//            self.gotoTerm()
//        case 6:
//            self.gotoHelp()
//        case 7:
//            self.gotoTermOfUse()
//        case 8:
//            self.gotoLearningCenter()
//        case 9:
//            self.gotoOJT()
//        case 10:
//            self.gotoReference()
//        case 11:
//            self.toReportStudy()
//        case 12:
//            self.toReportOJT()
//        default:
//            break
//        }
    }
}

@objc protocol TBLeftMenuDelegate: AnyObject {
    func logout()
    func logoutSuccess()
    @objc optional func onLeftMenuAction(index: Int)
    @objc optional func onPressLogout()
    @objc optional func onCancelLogout()
}