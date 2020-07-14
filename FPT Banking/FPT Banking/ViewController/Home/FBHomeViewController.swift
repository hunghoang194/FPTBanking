//
//  FBHomeViewController.swift
//  FPT Banking
//
//  Created by hưng hoàng on 6/22/20.
//  Copyright © 2020 hưng hoàng. All rights reserved.
//

import UIKit
import MBProgressHUD
import Alamofire
enum TypeMenuActivity {
    case sendInBank, SendToCard, listCheque, addCheque
}
class FBHomeViewController: FBBaseViewController {
    
    @IBOutlet weak var avatarView: UIView!
    @IBOutlet weak var lbAmount: UILabel!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var clActivity: UICollectionView!
    @IBOutlet weak var tbTransacsion: UITableView!
    var listTransactions = [TransactionsObj]()
    var id: Int?
    var listActivity:[FBProductObj] = [FBProductObj]()
    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isBackgroundGray = true
        avatarView.layer.cornerRadius = 5
        avatarView.layer.masksToBounds = true
    }
    override func viewDidLayoutSubviews() {
        lbAmount.text =  "\(FBDataCenter.sharedInstance.account?.amount ?? 0) "
    }
    override func initData() {
        self.getListTransacsion()
        lbName.text = FBDataCenter.sharedInstance.userInfo?.fullname
        // cap quyen
        tbTransacsion.delegate = self
        tbTransacsion.dataSource = self
        clActivity.delegate = self
        clActivity.dataSource = self
        // Register Cell
        self.tbTransacsion?.register(UINib.init(nibName: "TransactionHistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "TransactionHistoryTableViewCell")
        self.clActivity?.register(UINib.init(nibName: "UtilitysCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "UtilitysCollectionViewCell")
        // Add item
        let demoListActivity1:FBProductObj = FBProductObj()
        let demoListActivity2:FBProductObj = FBProductObj()
        let demoListActivity3:FBProductObj = FBProductObj()
        let demoListActivity4:FBProductObj = FBProductObj()
        let demoListActivity5:FBProductObj = FBProductObj()
        // collectionview
        demoListActivity1.title = "Chuyển tiền trong ngân hàng"
        demoListActivity2.title = "Chuyển tiền qua thẻ"
        demoListActivity3.title = "Danh sách Séc"
        demoListActivity4.title = "Tạo séc"
        demoListActivity5.title = "Hồ sơ vay"
        demoListActivity1.image = UIImage.init(named: "ic_send3")
        demoListActivity2.image = UIImage.init(named: "ic_send3")
        demoListActivity3.image = UIImage.init(named: "ic_listCV")
        demoListActivity4.image = UIImage.init(named: "ic_add2")
        demoListActivity5.image = UIImage.init(named: "ic_listLoanProfile")
        self.listActivity.append(demoListActivity1)
        self.listActivity.append(demoListActivity2)
        self.listActivity.append(demoListActivity3)
        self.listActivity.append(demoListActivity4)
        self.listActivity.append(demoListActivity5)
        self.tbTransacsion?.reloadData()
        self.clActivity?.reloadData()
    }
    override func initUI() {
        
    }
    func getListTransacsion() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        BaseServices.shareInstance.getListTransactions{ (response, message, errorCode) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let data = response as? [TransactionsObj]{
                self.listTransactions = data
                self.tbTransacsion?.reloadData()
            }
        }
    }
    // MARK: - Action
    @IBAction func gotoAccount(_ sender: Any) {
    }
    
}
extension FBHomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listTransactions.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
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
extension FBHomeViewController:UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listActivity.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UtilitysCollectionViewCell", for: indexPath) as! UtilitysCollectionViewCell
        let obj = listActivity[indexPath.row]
        cell.setDataUtility(obj: obj)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.clActivity?.frame.width ?? 0) / 0 - 5
        return CGSize(width: width, height: 135)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 135)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.goInbBank()
        case 1:
            self.sendCard()
        case 2:
            self.goListCheque()
        case 3:
            self.goAddCheque()
        default:
            return
        }
    }
}
