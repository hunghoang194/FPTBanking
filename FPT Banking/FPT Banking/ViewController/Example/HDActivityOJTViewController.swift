//
////  ActivityOJTViewController.swift
////  HVN MACs
////
////  Created by Hung Hoang on 5/13/20.
////  Copyright © 2020 Tung Nguyen. All rights reserved.
////
//
//import UIKit
//import Firebase
//enum TypeMenuActivity {
//    case staff, content, exam, result
//}
//class HDActivityOJTViewController: HDBaseViewController,UITableViewDelegate, UITableViewDataSource {
//    @IBOutlet weak var tbActivityOJT: UITableView!
//    var listActivityOJT:[HDProductObj] = [HDProductObj]()
//    
//    // MARK: - Life cycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.title = "Hoạt động OJT"
//        isShowBackButton = true
//        isShowRightMenu = true
//    }
//    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        if #available(iOS 13.0, *) {
//            slideMenuController()?.closeLeft()
//            slideMenuController()?.closeRight()
//        } else {
//            // Fallback on earlier versions
//        }
//        Analytics.setScreenName("Hoạt động OJT", screenClass: "Hoạt động OJT")
//    }
//    
//    // MARK: - Support method
//    override func initData() {
//        // Register Cell
//        self.tbActivityOJT?.register(UINib.init(nibName: "HDActivityOJTCollectionViewCell", bundle: nil), forCellReuseIdentifier: "HDActivityOJTCollectionViewCell")
//        // Add item
//        let humanResourceManagementOJT:HDProductObj = HDProductObj()
//        let contentOJT:HDProductObj = HDProductObj()
//        let testOJT:HDProductObj = HDProductObj()
//        let resultOJT:HDProductObj = HDProductObj()
//        
//        // MARK: hrmFlag = 1 -> ON, hrmFlag = 1 -> OFF
//        if HDDataCenter.sharedInstance.typeAccount == .Head_manager, HDDataCenter.sharedInstance.userInfo?.hrmFlag == "1" {
//            humanResourceManagementOJT.coverImage = "ic_ojt_humanResourceManagement"
//            humanResourceManagementOJT.productName = "QUẢN LÝ NHÂN SỰ"
//            humanResourceManagementOJT.typeActivity = .staff
//            self.listActivityOJT.append(humanResourceManagementOJT)
//        }
//        contentOJT.coverImage = "ic_ojt_content"
//        contentOJT.productName = "NỘI DUNG OJT"
//        contentOJT.typeActivity = .content
//        self.listActivityOJT.append(contentOJT)
//        
//        testOJT.coverImage = "ic_ojt_test"
//        testOJT.productName = "BÀI KIỂM TRA"
//        testOJT.typeActivity = .exam
//        self.listActivityOJT.append(testOJT)
//        resultOJT.coverImage = "ic_ojt_result"
//        resultOJT.productName = "KẾT QUẢ BÀI KIỂM TRA"
//        resultOJT.typeActivity = .result
//        self.listActivityOJT.append(resultOJT)
//        self.tbActivityOJT?.reloadData()
//    }
//    func toListAccount() {
//        let vcListAccount = HeadHRMUltil.share.getVCListAccount()
//        self.navigationController?.pushViewController(vcListAccount, animated: true)
//    }
//    func goContentOJT() {
//        let vc = ElearningUltil.share.getContentOJT()
//        AppDelegate.sharedInstance.mainNavigation?.pushViewController(vc, animated: true)
//    }
//    func goExamOJT() {
//        let exam = ElearningUltil.share.getExamOJT()
//        AppDelegate.sharedInstance.mainNavigation?.pushViewController(exam, animated: true)
//    }
//    func goResultDetailOJT() {
//        let result = ElearningUltil.share.getRessultOJT()
//        AppDelegate.sharedInstance.mainNavigation?.pushViewController(result, animated: true)
//    }
//    
//    // MARK: - TableView
//    func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return listActivityOJT.count
//    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 180
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "HDActivityOJTCollectionViewCell", for: indexPath) as! HDActivityOJTCollectionViewCell
//        cell.selectionStyle = .none
//        let obj = listActivityOJT[indexPath.row]
//        cell.setupDataOjt(obj: obj)
//        cell.indexPath = indexPath
//        cell.delegate = self
//        return cell
//    }
//}
//
//extension HDActivityOJTViewController : HDActivityOJTCollectionViewCellDelegate {
//    func onSelectActivity(type: TypeMenuActivity) {
//        switch type {
//        case .staff:
//            self.toListAccount()
//            break
//        case .content:
//            self.goContentOJT()
//            break
//        case .exam:
//            self.goExamOJT()
//            break
//        case .result:
//            self.goResultDetailOJT()
//            break
//        }
//    }
//}
