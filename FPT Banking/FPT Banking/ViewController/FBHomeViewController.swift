//
//  FBHomeViewController.swift
//  FPT Banking
//
//  Created by hưng hoàng on 6/22/20.
//  Copyright © 2020 hưng hoàng. All rights reserved.
//

import UIKit

class FBHomeViewController: FBBaseViewController {
    
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lbAmount: UILabel!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var avataView: AvatarView!
    @IBOutlet weak var clActivity: UICollectionView!
    @IBOutlet weak var tbTransacsion: UITableView!
    var listTransacsion:[FBProductObj] = [FBProductObj]()
    
    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func initData() {
        tbTransacsion.delegate = self
        tbTransacsion.dataSource = self
        // Register Cell
        self.tbTransacsion?.register(UINib.init(nibName: "TransactionHistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "TransactionHistoryTableViewCell")
        // Add item
        let demoListTransacsion:FBProductObj = FBProductObj()
        let demoListTransacsion1:FBProductObj = FBProductObj()
        let demoListTransacsion2:FBProductObj = FBProductObj()
        let demoListTransacsion3:FBProductObj = FBProductObj()
        let demoListTransacsion4:FBProductObj = FBProductObj()
        let demoListTransacsion5:FBProductObj = FBProductObj()
        demoListTransacsion.transacsion = 200000
        demoListTransacsion.price = 12
        demoListTransacsion3.transacsion = -200000
        demoListTransacsion3.price = 20
        demoListTransacsion1.transacsion = -20000
        demoListTransacsion1.price = 2
        demoListTransacsion2.transacsion = 500000
        demoListTransacsion2.price = 25
        demoListTransacsion4.transacsion = 20000
        demoListTransacsion4.price = 1
        demoListTransacsion5.transacsion = -40000
        demoListTransacsion5.price = 10
        self.listTransacsion.append(demoListTransacsion)
        self.listTransacsion.append(demoListTransacsion1)
        self.listTransacsion.append(demoListTransacsion2)
        self.listTransacsion.append(demoListTransacsion3)
        self.listTransacsion.append(demoListTransacsion4)
        self.listTransacsion.append(demoListTransacsion5)
        self.tbTransacsion?.reloadData()
    }
    // MARK: - Action
    @IBAction func gotoAccount(_ sender: Any) {
    }
}
extension FBHomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listTransacsion.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionHistoryTableViewCell", for: indexPath) as! TransactionHistoryTableViewCell
        cell.selectionStyle = .none
        let obj = listTransacsion[indexPath.row]
        cell.indexPath = indexPath
        cell.setupDataTransacsion(obj:obj)
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
        return cell
    }
}
