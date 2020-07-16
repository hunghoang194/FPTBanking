//
//  FBNotificationsViewController.swift
//  FPT Banking
//
//  Created by hưng hoàng on 7/16/20.
//  Copyright © 2020 hưng hoàng. All rights reserved.
//

import UIKit
import MBProgressHUD
import Alamofire
import SwiftyJSON

class FBNotificationsViewController: FBBaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tbListNoti: UITableView!
    var listNoti = [CurrentNotiObj]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isBackgroundGray = true
    }
    
    @IBAction func backPress(_ sender: Any) {
        self.backButtonPress()
    }
    // MARK: - Support method
    override func initData() {
        self.getListNoti()
        self.tbListNoti?.register(UINib.init(nibName: "FBNotificationsTableViewCell", bundle: nil), forCellReuseIdentifier: "FBNotificationsTableViewCell")
        tbListNoti.delegate = self
        tbListNoti.dataSource = self
        self.tbListNoti?.reloadData()
    }
    func getListNoti() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        BaseServices.shareInstance.getCurrentNoti{ (response, message, errorCode) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let data = response as? [CurrentNotiObj]{
                self.listNoti = data
                self.tbListNoti?.reloadData()
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listNoti.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FBNotificationsTableViewCell", for: indexPath) as! FBNotificationsTableViewCell
        cell.selectionStyle = .none
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
        if indexPath.row < listNoti.count {
            cell.setData(obj: listNoti[indexPath.row], index: indexPath)
        }
        return cell
    }
    
}
