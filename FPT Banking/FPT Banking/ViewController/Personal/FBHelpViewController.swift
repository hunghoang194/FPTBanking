//
//  FBHelpViewController.swift
//  FPT Banking
//
//  Created by hưng hoàng on 6/30/20.
//  Copyright © 2020 hưng hoàng. All rights reserved.
//

import UIKit
import MessageUI
import Alamofire
import SwiftyJSON
import MBProgressHUD

class FBHelpViewController: FBBaseViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var callView: UIView!
    var numberNoti = [FBNotifications]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isBackgroundGray = true
    }

    
    override func initUI() {
//        lbNoti.text = number
        emailView.layer.cornerRadius = 5
        emailView.layer.masksToBounds = true
        callView.layer.cornerRadius = 5
        callView.layer.masksToBounds = true
        emailView.setMutilColorForView(nameColor: ColorName.CallBackground)
        callView.setMutilColorForView(nameColor: ColorName.CallBackground)
    }
    // MARK: - Call API
    func numberUnread() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        BaseServices.shareInstance.unreadMessage{ (response, message, errorCode) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let data = response as? [FBNotifications]{
                self.numberNoti = data
            }
        }
    }
    // MARK: - Support method
    func makeAPhoneCall()  {
        if let phoneCallURL:URL = URL(string: "tel:\(0963558935)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                let alertController = UIAlertController(title: "Gọi tới dịch vụ CSKH", message: "Bạn muốn gọi tới số \n\(0963558935) không?", preferredStyle: .alert)
                let yesPressed = UIAlertAction(title: "Gọi ngay", style: .default, handler: { (action) in
                    application.openURL(phoneCallURL)
                })
                let noPressed = UIAlertAction(title: "Gọi sau", style: .default, handler: { (action) in
                    
                })
                alertController.addAction(yesPressed)
                alertController.addAction(noPressed)
                present(alertController, animated: true, completion: nil)
            }
        }
    }
    @IBAction func backPress(_ sender: Any) {
        backButtonPress()
    }
    @IBAction func emailPress(_ sender: Any) {
            // Modify following variables with your text / recipient
            let recipientEmail = "hunghv3010@gmail.com"
            let subject = "Bạn hãy hỗ trợ tôi vấn đề này"
            let body = "Bạn hãy nhập vào thông tin cần trợ giúp!"

            // Show default mail composer
            if MFMailComposeViewController.canSendMail() {
                let mail = MFMailComposeViewController()
                mail.mailComposeDelegate = self
                mail.setToRecipients([recipientEmail])
                mail.setSubject(subject)
                mail.setMessageBody(body, isHTML: false)
                present(mail, animated: true)

            // Show third party email composer if default Mail app is not present
            } else if let emailUrl = createEmailUrl(to: recipientEmail, subject: subject, body: body) {
                UIApplication.shared.open(emailUrl)
            }
        }

        private func createEmailUrl(to: String, subject: String, body: String) -> URL? {
            let subjectEncoded = subject.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            let bodyEncoded = body.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!

            let gmailUrl = URL(string: "googlegmail://co?to=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
            let outlookUrl = URL(string: "ms-outlook://compose?to=\(to)&subject=\(subjectEncoded)")
            let yahooMail = URL(string: "ymail://mail/compose?to=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
            let sparkUrl = URL(string: "readdle-spark://compose?recipient=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
            let defaultUrl = URL(string: "mailto:\(to)?subject=\(subjectEncoded)&body=\(bodyEncoded)")

            if let gmailUrl = gmailUrl, UIApplication.shared.canOpenURL(gmailUrl) {
                return gmailUrl
            } else if let outlookUrl = outlookUrl, UIApplication.shared.canOpenURL(outlookUrl) {
                return outlookUrl
            } else if let yahooMail = yahooMail, UIApplication.shared.canOpenURL(yahooMail) {
                return yahooMail
            } else if let sparkUrl = sparkUrl, UIApplication.shared.canOpenURL(sparkUrl) {
                return sparkUrl
            }

            return defaultUrl
        }

        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            controller.dismiss(animated: true)
    }

    @IBAction func callPress(_ sender: Any) {
        self.makeAPhoneCall()
    }
    
}
