//
//  FBBaseViewController.swift
//  FPT Banking
//
//  Created by Hung Hoang on 6/22/20.
//  Copyright © 2020 hưng hoàng. All rights reserved.
//

import UIKit
import SwiftyJSON
import MBProgressHUD
import AVKit
import Photos

class FBBaseViewController: UIViewController {
    var isShowBackButton:Bool = false
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
//        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
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
        self.slideMenuController()?.addLeftGestures()
        
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
            slideMenuController()?.closeLeft()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.removeRightGestures()
    }
    
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
            if WTUtilitys.isIpad() {
                activityViewController.popoverPresentationController?.sourceView = self.view
                activityViewController.popoverPresentationController?.sourceRect = self.view.bounds
                activityViewController.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
            }
            present(activityViewController, animated: true)
        }
    }
    public func LeftBarButtonWithImage(_ buttonImage: UIImage) {
        let btnLeft = UIButton(type: .custom)
        btnLeft.setImage(buttonImage, for: .normal)
        btnLeft.frame = CGRect(x: -10, y: 0, width: 44, height: 44)
        btnLeft.addTarget(self, action: #selector(self.tapLeft), for: .touchUpInside)
        btnLeft.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
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
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
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

//extension FBBaseViewController: TBLeftMenuDelegate {
//    func logout() {
//        MBProgressHUD.showAdded(to: self.view, animated: true)
//    }
//
//    func logoutSuccess() {
//        MBProgressHUD.hide(for: self.view, animated: true)
//    }
//}
enum HDRequiredPermission: String {
case photoLibrary = "thư viện ảnh"
case none // Exec hiển thị đòi quyền
}

extension FBBaseViewController {
//    func check(permissions: [HDRequiredPermission], completion: (() -> Void)? = nil) -> Bool {
//        var shouldRequest = false
//        for perm in permissions {
//            switch perm {
//            case .photoLibrary:
//                if !(PHPhotoLibrary.authorizationStatus() == .authorized) {
//                    shouldRequest = true
//                }
//            default:
//                break
//            }
//            if shouldRequest {
//                let alertVC = UIAlertController(title: "FPT Banking chưa được cấp quyền truy cập \(perm.rawValue)", message: "Vào cài đặt của máy để cấp quyền cho FPT Banking", preferredStyle: .alert)
//                let okAction = UIAlertAction(title: "Từ chối", style: .cancel) { _ in
//                    alertVC.dismiss(animated: true)
//                    self.navigationController?.popViewController(animated: true)
//                }
//                let toSettingsAction = UIAlertAction(title: "Cài đặt", style: .destructive) { _ in
//                    alertVC.dismiss(animated: true, completion: nil)
//                    self.navigationController?.popViewController(animated: true)
//                    DispatchQueue.main.async {
//                        completion?()
//                    }
//                }
//                alertVC.addAction(okAction)
//                alertVC.addAction(toSettingsAction)
//                self.present(alertVC, animated: true, completion: nil)
//                return false
//            }
//        }
//        return true
//    }
}

