//
//  FBListTransactionsDetailViewController.swift
//  FPT Banking
//
//  Created by hưng hoàng on 7/4/20.
//  Copyright © 2020 hưng hoàng. All rights reserved.
//

import UIKit
import MBProgressHUD
import Alamofire

class FBListTransactionsDetailViewController: FBBaseViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tbListTransactions: UITableView!
    var listTransactions = [TransactionsObj]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isBackgroundGray = true
    }
    // MARK: - Support method
    override func initData() {
        self.getListTransacsion()
        self.tbListTransactions?.register(UINib.init(nibName: "TransactionHistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "TransactionHistoryTableViewCell")
        tbListTransactions.delegate = self
        tbListTransactions.dataSource = self
        self.tbListTransactions?.reloadData()
    }
    func getListTransacsion() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        BaseServices.shareInstance.getListTransactions{ (response, message, errorCode) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let data = response as? [TransactionsObj]{
                self.listTransactions = data
                self.tbListTransactions?.reloadData()
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listTransactions.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionHistoryTableViewCell", for: indexPath) as! TransactionHistoryTableViewCell
        cell.selectionStyle = .none
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
        if indexPath.row < listTransactions.count {
            cell.setupDataTransacsion(obj: listTransactions[indexPath.row], index: indexPath)
        }
        return cell
    }

}
