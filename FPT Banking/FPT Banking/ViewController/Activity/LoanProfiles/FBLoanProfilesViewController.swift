//
//  FBLoanProfilesViewController.swift
//  FPT Banking
//
//  Created by hưng hoàng on 7/16/20.
//  Copyright © 2020 hưng hoàng. All rights reserved.
//

import UIKit
import MBProgressHUD
import Alamofire

class FBLoanProfilesViewController: FBBaseViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tbListLoan: UITableView!
    var listLoan = [FBLoanprofiles]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isBackgroundGray = true
    }
    // MARK: - Support method
    override func initData() {
        self.getListLoan()
        self.tbListLoan?.register(UINib.init(nibName: "FBLoanProfilesTableViewCell", bundle: nil), forCellReuseIdentifier: "FBLoanProfilesTableViewCell")
        tbListLoan.delegate = self
        tbListLoan.dataSource = self
        self.tbListLoan?.reloadData()
    }
    @IBAction func backPress(_ sender: Any) {
        self.backButtonPress()
    }
    func getListLoan() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        BaseServices.shareInstance.getLoanProfiles{ (response, message, errorCode) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let data = response as? [FBLoanprofiles]{
                self.listLoan = data
                self.tbListLoan?.reloadData()
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listLoan.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 625
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FBLoanProfilesTableViewCell", for: indexPath) as! FBLoanProfilesTableViewCell
        cell.selectionStyle = .none
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
        if indexPath.row < listLoan.count {
            cell.setData(obj: listLoan[indexPath.row], index: indexPath)
        }
        return cell
    }

}

