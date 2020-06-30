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

class FBListCardViewController: FBBaseViewController {
    @IBOutlet weak var tbListCard: UITableView!
    
    var listCard:[FBProductObj] = [FBProductObj]()
    var profileUser:[FBUserProfile] = [FBUserProfile]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tbListCard.delegate = self
        tbListCard.dataSource = self
        getData()
    }
    // MARK: - Support method
    override func initData() {
        // Register Cell
        self.tbListCard?.register(UINib.init(nibName: "FBListsCardTableViewCell", bundle: nil), forCellReuseIdentifier: "FBListsCardTableViewCell")
        // Add item
        let demoListCard:FBProductObj = FBProductObj()
        let demoListCard1:FBProductObj = FBProductObj()
        let demoListCard2:FBProductObj = FBProductObj()
        demoListCard.numberCard = "012255550000"
        demoListCard.dateActive = "06/20"
        demoListCard.dateExpiriation = "05/22"
        demoListCard.productName = "HOANG VAN HUNG"
        demoListCard1.numberCard = "012266668888"
        demoListCard1.dateActive = "06/20"
        demoListCard1.dateExpiriation = "09/22"
        demoListCard1.productName = "HOANG VAN HUNG"
        demoListCard2.numberCard = "012288889999"
        demoListCard2.dateActive = "06/20"
        demoListCard2.dateExpiriation = "05/21"
        demoListCard2.productName = "HOANG VAN HUNG"
        self.listCard.append(demoListCard)
        self.listCard.append(demoListCard1)
        self.listCard.append(demoListCard2)
        var replacement = demoListCard.numberCard
        let start = replacement?.index(replacement!.startIndex, offsetBy: 4);
        let end = replacement?.index(replacement!.startIndex, offsetBy: 4 + 4);
        replacement?.replaceSubrange(start!..<end!, with: "****")
        demoListCard.numberCard = replacement
        self.tbListCard?.reloadData()
    }
    func getData() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        Alamofire.request("http://192.168.1.10:8080/api/user/current").responseJSON {
            (response) in
            MBProgressHUD.hide(for: self.view, animated: true)
            debugPrint(response)
            switch response.result {
            case .success:
                print(response)
                //                        self.goHome()
                break
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension FBListCardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listCard.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FBListsCardTableViewCell", for: indexPath) as! FBListsCardTableViewCell
        let obj = listCard[indexPath.row]
        cell.indexPath = indexPath
        cell.setupDataCard(obj:obj)
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("click\(indexPath.row)")
        let main = UIStoryboard(name: "Home", bundle: nil)
        let homeVC = main.instantiateViewController(withIdentifier: "FBHomeViewController")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = homeVC
    }
}
