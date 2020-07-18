//
//  FBListCardViewController.swift
//  FPT Banking
//
//  Created by Hung Hoang on 6/26/20.
//  Copyright © 2020 hưng hoàng. All rights reserved.
//

import UIKit
import MBProgressHUD
import Alamofire

class FBListAccountViewController: FBBaseViewController {
    @IBOutlet weak var tbListCard: UITableView!
    @IBOutlet weak var lbName: UILabel!
    var profileUser = [FBListAccount]()
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var avatarView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("ReloadAmountNotification"), object: nil)
    }
    
    @objc func methodOfReceivedNotification(notification: Notification) {
        getListCard()
    }
    
    deinit {
      NotificationCenter.default.removeObserver(self, name: Notification.Name("ReloadAmountNotification"), object: nil)
    }
    override func initUI() {
        avatarView.setBorder(color: UIColor(red: 189, green: 189, blue: 189, alpha: 1), width: 1,isCircle: true, mutilColorName: ColorName.CallBackground)
    }
    // MARK: - Support method
    override func initData() {
        self.tbListCard?.register(UINib.init(nibName: "FBListAccountTableViewCell", bundle: nil), forCellReuseIdentifier: "FBListAccountTableViewCell")
        tbListCard.delegate = self
        tbListCard.dataSource = self
        lbName.text = FBDataCenter.sharedInstance.userInfo?.fullname
        getListCard()
        self.tbListCard?.reloadData()
    }
    
    func getListCard() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        BaseServices.shareInstance.getAccount { (response, message, errorCode) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let data = response as? [FBListAccount]{
                self.profileUser = data
                self.tbListCard?.reloadData()
            }
        }
    }
}

extension FBListAccountViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileUser.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FBListAccountTableViewCell", for: indexPath) as! FBListAccountTableViewCell
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
        if indexPath.row < profileUser.count {
            cell.setupListAccount(obj: profileUser[indexPath.row], index: indexPath)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("click\(indexPath.row)")
        FBDataCenter.sharedInstance.account = profileUser[indexPath.row]
        self.goHome()
    }
}
