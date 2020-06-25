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
    @IBOutlet weak var btnChangePass: UIButton!
    @IBOutlet weak var btnLogout: UIButton!
    
    weak var delegate: TBLeftMenuDelegate?
    var menuList = [FBProductObj]()
    override func viewDidLoad() {
        super.viewDidLoad()
        //        lbVersion.text = "Phiên bản: 0.1"
        // Do any additional setup after loading the view.
        self.btnLogout.layer.cornerRadius = 15.0
        self.btnChangePass.layer.cornerRadius = 15.0
        self.avatar.image = UIImage.init(named: "logo_bike")
        self.tbMenu.register(UINib.init(nibName: "FBMenuTableViewCell", bundle: nil), forCellReuseIdentifier: "FBMenuTableViewCell")
        tbMenu.delegate = self
        tbMenu.dataSource = self
        //        lbName.setTextColorForIos13(nameColor: ColorName.NameColor)
    }
    
    
    //MARK: load Item menu
    func loadItemMenu(isShowReport: Bool, isHeadSale: Bool) {
        menuList.removeAll()
        let homeMenu = FBProductObj()
        homeMenu.id = 0
        homeMenu.image = "ic_home"
        homeMenu.title = "Trang chủ"
        menuList.append(homeMenu)
        
        
        let faqMenu = FBProductObj()
        faqMenu.id = 1
        faqMenu.image = "ic_faq"
        faqMenu.title = "Vấn đề thường gặp"
        menuList.append(faqMenu)
        let refMenu = FBProductObj()
        refMenu.id = 2
        refMenu.image = "ic_reference"
        refMenu.title = "Học trực tuyến"
        menuList.append(refMenu)
        let catalogMenu = FBProductObj()
        catalogMenu.id = 3
        catalogMenu.image = "ic_catalog"
        catalogMenu.title = "Sách phụ tùng"
        menuList.append(catalogMenu)
        tbMenu.reloadData()
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
    func handerAction(index: Int) {
        let obj = menuList[index]
        switch obj.id ?? 0 {
        case 0:
            self.gotoHome()
        case 1:
            self.gotoMenuOne()
        default:
            break
        }
    }
    @IBAction func changePassPress(_ sender: Any) {
    }
    
    
    
    @IBAction func onLogoutPressed(_ sender: Any) {
        //    KLCPopup.dismissAllPopups()
        //    handlerSlideMenu()
        //    if delegate?.onPressLogout != nil {
        //        delegate?.onPressLogout?()
        //        return
        //    }
        //    actionLogout()
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "FBMenuTableViewCell", for: indexPath) as! FBMenuTableViewCell
            cell.imgCover.image = UIImage(named: menuList[indexPath.row].image ?? "")
            cell.lbTitle.text = menuList[indexPath.row].title
            cell.selectionStyle = .none
            return cell
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if delegate?.onLeftMenuAction != nil {
                handlerSlideMenu()
                delegate?.onLeftMenuAction?(index: indexPath.row)
            } else {
                handerAction(index: indexPath.row)
            }
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
