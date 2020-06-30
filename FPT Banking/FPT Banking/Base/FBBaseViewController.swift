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

enum FBRequiredPermission: String {
case photoLibrary = "thư viện ảnh"
case none // Exec hiển thị đòi quyền
}

class FBBaseViewController: UIViewController {
    var isShowBackButton:Bool = false
    var isSetupNavigation = false
    var isBackgroundGray = false
    var isAllowSwipeToBack: Bool? {
        didSet {
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = isAllowSwipeToBack ?? false
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initData()
        self.initUI()
        self.hideKeyboardWhenTappedAround()
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
        if isBackgroundGray{
            if #available(iOS 11.0, *) {
                self.view.setMutilColorForView(nameColor: ColorName.ScrollViewListCatalogColor)
            } else {
                self.view.backgroundColor = UIColor(hex: "#E5E5E5")
            }
        }
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
        // MARK: - Support method
    @objc public func goListCard() {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = main.instantiateViewController(withIdentifier: "FBListCardViewController")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = homeVC
    }
    @objc public func goHome() {
        let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "FBHomeViewController") as! FBHomeViewController
        homeVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(homeVC, animated: true)
    }
    @objc public func showToast(message : String, font: UIFont) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 250, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 3.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    @objc public func isValidPassword(testPass:String?) -> Bool {
        let length: Int = testPass?.count ?? 0
        if length >= 6 {
            return true
        } else {
            return false
        }
    }
    // MARK: - UIGestureRecognizerDelegate
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension FBBaseViewController {
    func check(permissions: [FBRequiredPermission], completion: (() -> Void)? = nil) -> Bool {
        var shouldRequest = false
        for perm in permissions {
            switch perm {
            case .photoLibrary:
                if !(PHPhotoLibrary.authorizationStatus() == .authorized) {
                    shouldRequest = true
                }
            default:
                break
            }
            if shouldRequest {
                let alertVC = UIAlertController(title: "FPT Banking chưa được cấp quyền truy cập \(perm.rawValue)", message: "Vào cài đặt của máy để cấp quyền cho FPT Banking", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Từ chối", style: .cancel) { _ in
                    alertVC.dismiss(animated: true)
                    self.navigationController?.popViewController(animated: true)
                }
                let toSettingsAction = UIAlertAction(title: "Cài đặt", style: .destructive) { _ in
                    alertVC.dismiss(animated: true, completion: nil)
                    self.navigationController?.popViewController(animated: true)
                    DispatchQueue.main.async {
                        completion?()
                    }
                }
                alertVC.addAction(okAction)
                alertVC.addAction(toSettingsAction)
                self.present(alertVC, animated: true, completion: nil)
                return false
            }
        }
        return true
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
