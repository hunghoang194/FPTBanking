//
//  TBLeftMenuViewController.swift
//  FPT Banking
//
//  Created by Hung Hoang on 6/22/20.
//  Copyright © 2020 hưng hoàng. All rights reserved.
//

import UIKit
import Toast_Swift
import MBProgressHUD

class TBLeftMenuViewController: UIViewController {
    @IBOutlet weak var tbMenu: UITableView!
    @IBOutlet weak var avatar: AvatarView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbHead: UILabel!
    @IBOutlet weak var lbVersion: UILabel!
    @IBOutlet weak var lbPermission: UILabel!
    
    @IBOutlet weak var btnChangePass: UIButton!
    @IBOutlet weak var btnLogout: UIButton!
    
    weak var delegate: TBLeftMenuDelegate?
    var menuList = [FBMenuObj]()
    override func viewDidLoad() {
        super.viewDidLoad()
        lbVersion.text = "Phiên bản: 0.1"
        lbHead.adjustsFontSizeToFitWidth = true
        // Do any additional setup after loading the view.
        self.btnLogout.layer.cornerRadius = 15.0
        //        self.btnChangePass.layer.cornerRadius = 15.0
        self.avatar.image = UIImage.init(named: "logo_bike")
        tbMenu.register(UINib.init(nibName: "FBMenuTableViewCell", bundle: nil), forCellReuseIdentifier: "FBMenuTableViewCell")
        tbMenu.delegate = self
        tbMenu.dataSource = self
        //        lbName.setTextColorForIos13(nameColor: ColorName.NameColor)
    }
    
    
    //MARK: load Item menu
    func loadItemMenu(isShowReport: Bool, isHeadSale: Bool) {
        menuList.removeAll()
        let homeMenu = FBMenuObj()
        homeMenu.id = 0
        homeMenu.image = "ic_home"
        homeMenu.title = "Trang chủ"
        menuList.append(homeMenu)
        
        
        let faqMenu = FBMenuObj()
        faqMenu.id = 1
        faqMenu.image = "ic_faq"
        faqMenu.title = "Vấn đề thường gặp"
        menuList.append(faqMenu)
        let refMenu = FBMenuObj()
        refMenu.id = 2
        refMenu.image = "ic_reference"
        refMenu.title = "Học trực tuyến"
        menuList.append(refMenu)
        let catalogMenu = FBMenuObj()
        catalogMenu.id = 3
        catalogMenu.image = "ic_catalog"
        catalogMenu.title = "Sách phụ tùng"
        menuList.append(catalogMenu)
    }
    tbMenu?.reloadData() {
}

func handlerSlideMenu() {
    slideMenuController()?.toggleLeft()
    slideMenuController()?.closeLeft()
}

// goto Home
func gotoHome() {
    handlerSlideMenu()
}

// goto TableView index one
func gotoMenuOne() {
    handlerSlideMenu()
}



//@IBAction func onLogoutPressed(_ sender: Any) {
//    KLCPopup.dismissAllPopups()
//    handlerSlideMenu()
//    if delegate?.onPressLogout != nil {
//        delegate?.onPressLogout?()
//        return
//    }
//    actionLogout()
//}


extension TBLeftMenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FBMenuTableViewCell", for: indexPath) as! FBMenuTableViewCell
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
        
        func handerAction(index: Int) {
            let obj = menuList[index]
            switch obj.id ?? 0 {
            case 0:
                self.gotoHome()
            case 1:
                self.gotoMenuOne()
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
            default:
                break
            }
        }
        
        @objc protocol TBLeftMenuDelegate: AnyObject {
            func logout()
            func logoutSuccess()
            @objc optional func onLeftMenuAction(index: Int)
            @objc optional func onPressLogout()
            @objc optional func onCancelLogout()
            @objc optional func onPressChangepass()
            @objc optional func onPressRecoverPass()
        }
    }
}
