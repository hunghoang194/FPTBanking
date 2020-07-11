//
//  FBListChequeViewController.swift
//  FPT Banking
//
//  Created by hưng hoàng on 7/4/20.
//  Copyright © 2020 hưng hoàng. All rights reserved.
//

import UIKit
import MBProgressHUD
import Alamofire

class FBListChequeViewController: FBBaseViewController {
    @IBOutlet weak var tbListCheque: UITableView!
    var listCheque = [FBListsCheque]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isBackgroundGray = true
    }
    @IBAction func backPress(_ sender: Any) {
        self.backButtonPress()
    }
    // MARK: - Support method
    override func initData() {
        self.tbListCheque?.register(UINib.init(nibName: "FBChequeTableViewCell", bundle: nil), forCellReuseIdentifier: "FBChequeTableViewCell")
        tbListCheque.delegate = self
        tbListCheque.dataSource = self
        getListCheque()
        self.tbListCheque?.reloadData()
    }
    
    func getListCheque() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        BaseServices.shareInstance.getListCheque { (response, message, errorCode) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let data = response as? [FBListsCheque]{
                self.listCheque = data
                self.tbListCheque?.reloadData()
            }
        }
    }
}


extension FBListChequeViewController: UITableViewDelegate, UITableViewDataSource, ChequeTableViewCellDelegate {
    func cancel(index: IndexPath) {
        if index.row < listCheque.count {
            let obj = listCheque[index.row]
            MBProgressHUD.showAdded(to: self.view, animated: true)
            BaseServices.shareInstance.getCanceledCheque(chequeId: obj.id ?? -1) { (response, message, errorCode) in
                          MBProgressHUD.hide(for: self.view, animated: true)
                    self.getListCheque()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listCheque.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FBChequeTableViewCell", for: indexPath) as! FBChequeTableViewCell
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
        if indexPath.row < listCheque.count {
            cell.setData(obj: listCheque[indexPath.row], index: indexPath)
//            cell.delegate = self
        }
        return cell
    }
    
}
