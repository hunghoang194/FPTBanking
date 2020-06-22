//
//  CustomPhotoPickerViewController.swift
//  HVN MACs
//
//

import Foundation
import TLPhotoPicker
import Firebase

class CustomPhotoPickerViewController: TLPhotosPickerViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            isModalInPresentation = true
        } else {
            // Fallback on earlier versions
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Analytics.setScreenName("Custome Photo Picker", screenClass: "Custome Photo Picker")
    }
    
    override func makeUI() {
        super.makeUI()
        self.customNavItem.leftBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .stop, target: nil, action: #selector(customAction))
    }
    @objc func customAction() {
        self.delegate?.photoPickerDidCancel()
//        AppDelegate.sharedInstance.isChooseImage = false
        self.dismiss(animated: true) { [weak self] in
//            self?.delegate?.dismissComplete()
            self?.dismissCompletion?()
        }
    }
}
