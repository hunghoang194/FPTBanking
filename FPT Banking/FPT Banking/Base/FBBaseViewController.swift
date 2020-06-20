//
//  FBBaseViewController.swift
//  FPT Banking
//
//  Created by Hung Hoang on 6/19/20.
//  Copyright © 2020 hưng hoàng. All rights reserved.
//

import UIKit
import SwiftyJSON
import AVKit
import Photos

class FBBaseViewController: UIViewController,UIGestureRecognizerDelegate {
    var isShowBackButton:Bool = false
    var isTransParentBar:Bool = false
    var isSetupNavigation = false
    var isBackgroundGray = false
    var isShowRightMenu = false
    var isNotificationView = false
    var isAllowSwipeToBack: Bool? {
        didSet {
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = isAllowSwipeToBack ?? false
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.navigationController?.navigationItem.backBarButtonItem?.isEnabled = false
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        if UIDevice.current.userInterfaceIdiom == .pad{
            
        }
        self.initData()
        self.initUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.isAllowSwipeToBack = isAllowSwipeToBack != nil ? isAllowSwipeToBack : isShowBackButton
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppDelegate.sharedInstance.leftMenu?.delegate = self
        AppDelegate.sharedInstance.rightMenu?.delegate = self
        if isShowBackButton || isTransParentBar {
            self.slideMenuController()?.removeLeftGestures()
        } else {
            self.slideMenuController()?.addLeftGestures()
        }
        if !isShowRightMenu || isTransParentBar {
            self.slideMenuController()?.removeRightGestures()
        } else {
            self.slideMenuController()?.addRightGestures()
        }
        if isBackgroundGray{
            if #available(iOS 11.0, *) {
                self.view.setMutilColorForView(nameColor: ColorName.ScrollViewListCatalogColor)
            } else {
                self.view.backgroundColor = UIColor(hex: "#E5E5E5")
            }
        }
        if !isSetupNavigation{
            if self.isShowBackButton {
                let imgLeft = UIImage.init(named: "ic_back")
                self.LeftBarButtonWithImage(imgLeft!)
            }
            if self.isTransParentBar {
                self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
                self.navigationController?.navigationBar.shadowImage = UIImage()
                self.navigationController?.navigationBar.isTranslucent = true
                self.navigationController?.view.backgroundColor = UIColor.clear
            }
            if isShowRightMenu {
                isRightMenu = true
                addTwoRightButton()
            }
//            else
//            {
//                self.navigationController?.navigationBar.layer.shadowColor = UIColor.clear.cgColor
//                self.navigationController?.navigationBar.tintColor = .white
//                self.navigationController?.navigationBar.backgroundColor = .clear
//                self.navigationController?.navigationBar.isTranslucent = false
//                self.navigationController?.navigationBar.barTintColor = NAVIGATION_COLOR
//                self.navigationController?.view.backgroundColor = UIColor.clear
//                self.navigationController?.navigationBar.setBackgroundImage(UIImage.init(named: "topbar"), for: UIBarMetrics.default)
//            }
            
            slideMenuController()?.closeLeft()
            slideMenuController()?.closeRight()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.removeRightGestures()
    }

    func addTwoRightButton(){
        navigationItem.rightBarButtonItem = nil
        let notiButton = UIBarButtonItemWithBadge()
        notiButton.image = UIImage.init(named: "ic_noti")
        notiButton.target = self
        notiButton.action = #selector(self.tapNoti)
        notiButton.tag = 1234
        if UIApplication.shared.applicationIconBadgeNumber > 0{
            if #available(iOS 11.0 , *) {
                notiButton.addBadge(numberOfNoti: UIApplication.shared.applicationIconBadgeNumber, offsetFromTopRight: CGPoint(x: 4, y: -4), background: UIColor.init(named: ColorName.BlackRedButtonColor)!)
            } else {
                notiButton.addBadge(numberOfNoti: UIApplication.shared.applicationIconBadgeNumber, offsetFromTopRight: CGPoint(x: 4, y: -4))
            }
        }
        let menuRight = UIButton(type: .custom)
        menuRight.setImage(UIImage.init(named: "ic_menu"), for: .normal)
        menuRight.frame = CGRect(x: -10, y: 0, width: 44, height: 44)
        menuRight.addTarget(self, action: #selector(self.tapRightMenu), for: .touchUpInside)
        menuRight.contentHorizontalAlignment = UIControlContentHorizontalAlignment.right
        let menuButton = UIBarButtonItem(customView: menuRight)
        
        // check show icon notification
        let isIconNotification = self.isShowIconNotification()
        if !isIconNotification {
            navigationItem.rightBarButtonItems = [menuButton,notiButton]
            return
        }
        navigationItem.rightBarButtonItems = [menuButton]
    }
    @objc func reloadBadge(){
        addNotiBtn()
        updateContentViewsBadge()
    }
    
    func updateContentViewsBadge() { }
    
    @objc func tapRightMenu(){
        self.toggleRight()
    }
    func initData(){}
    func initUI(){}
    func share(link:String){
        let shareText = link
        let image = UIImage.init(named: "logo")
        if image != nil  {
            let activityViewController = UIActivityViewController(activityItems: [shareText, image!], applicationActivities: [])
            present(activityViewController, animated: true)
        }
    }
    public func LeftBarButtonWithImage(_ buttonImage: UIImage) {
        let btnLeft = UIButton(type: .custom)
        btnLeft.setImage(buttonImage, for: .normal)
        btnLeft.frame = CGRect(x: -10, y: 0, width: 44, height: 44)
        btnLeft.addTarget(self, action: #selector(self.tapLeft), for: .touchUpInside)
        btnLeft.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        let leftButton = UIBarButtonItem(customView: btnLeft)
        navigationItem.leftBarButtonItem = leftButton
    }
    
    @objc func tapLeft() {
        if self.isShowBackButton
        {
            if self.isModal {
                self.dismiss(animated: true, completion: nil)
            }
            else
            {
                self.navigationController?.popViewController(animated: true)
            }
        }
        
    }

    // MARK: - UIGestureRecognizerDelegate
    
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        return true
//    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension UIViewController {
    var isModal: Bool {
        if let index = navigationController?.viewControllers.index(of: self), index > 0 {
            return false
        } else if presentingViewController != nil {
            return true
        } else if navigationController?.presentingViewController?.presentedViewController == navigationController  {
            return true
        } else if tabBarController?.presentingViewController is UITabBarController {
            return true
        } else {
            return false
        }
    }
}

extension FBBaseViewController: TBLeftMenuDelegate {
    func logout() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
    }

    func logoutSuccess() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
}

