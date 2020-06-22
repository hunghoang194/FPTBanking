////
////  HDContentOJTViewController.swift
////  HVN MACs
////
////  Created by Hung Hoang on 5/18/20.
////  Copyright © 2020 Tung Nguyen. All rights reserved.
////
//
//import UIKit
//import MBProgressHUD
//import Toaster
//import Firebase
//
//class HDContentOJTViewController: HDBaseViewController {
//    @IBOutlet weak var clData: UICollectionView?
//    var listData = [HDListOJT]()
//    var content: LevelObj?
//    var currentMonth:Int?
//    var currentYear:Int?
//    var arrYear = [String]()
//    var arrMonth = [String]()
//    
//    // MARK: - Life cycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.title = "Nội dung OJT"
//        isShowBackButton = true
//        isShowRightMenu = true
//        self.isBackgroundGray = true
//    }
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        if #available(iOS 13.0, *) {
//            slideMenuController()?.closeLeft()
//            slideMenuController()?.closeRight()
//        } else {
//            // Fallback on earlier versions
//        }
//        Analytics.setScreenName("ContentOJT", screenClass: "ContentOJT")
//    }
//    
//    // MARK: - Support method
//    override func initData() {
//        self.getContent()
//        clData?.register(HDContentCollectionViewCell.nib, forCellWithReuseIdentifier: HDContentCollectionViewCell.name)
//        clData?.register(UINib(nibName: "HDContentHeaderCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HDContentHeaderCollectionReusableView")
//        clData?.delegate = self
//        clData?.dataSource = self
//        self.getContent(year: nil ,month: nil)
//        self.clData?.reloadData()
//    }
//    
//    func validateTimeInPut(_ year: Int?, _ month: Int?) -> Bool {
//        if currentMonth != nil, currentYear == nil {
//            return false
//        }
//        return true
//    }
//    
//    func toDetailOJT() {
//        let vc = ElearningUltil.share.storyboard.instantiateViewController(withIdentifier: "HDDetailOJTViewController") as! HDDetailOJTViewController
//        AppDelegate.sharedInstance.mainNavigation?.pushViewController(vc, animated: true)
//    }
//    // MARK: - Data & API
//    func getContent(year: Int? = nil, month: Int? = nil) {
//        MBProgressHUD.showAdded(to: self.view, animated: true)
//        HDServices.shareInstance.getListOjt(year: year, month: month) { (response, message, errorCode) in
//            MBProgressHUD.hide(for: self.view, animated: true)
//            if let data = response as? [HDListOJT], errorCode == SUCCESS_CODE {
//                self.listData = data
//                self.clData?.reloadData()
//            }else{
//                self.listData.removeAll()
//                self.clData?.reloadData()
//                Toast(text: "Không có dữ liệu bạn muốn tìm", duration: 2.0).show()
//            }
//        }
//    }
//    func reloadData() {
//        getContent(year: currentYear, month: currentMonth)
//    }
//    
//    // MARK: - Actions method
//    @IBAction func showAllPress(_ sender: Any) {
//        currentMonth = nil
//        currentYear = nil
//        self.reloadData()
//    }
//}
//// MARK: - CollectionView
//extension HDContentOJTViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return listData.count
//    }
//    // Header CollectionVew
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        guard let headerView = collectionView.dequeueReusableSupplementaryView(
//            ofKind: kind,
//            withReuseIdentifier: "HDContentHeaderCollectionReusableView",
//            for: indexPath) as? HDContentHeaderCollectionReusableView
//            else {
//                fatalError("Invalid view type")
//        }
//        headerView.delegate = self
//        return headerView
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HDContentCollectionViewCell.name, for: indexPath) as! HDContentCollectionViewCell
//        if indexPath.row < listData.count {
//            cell.contentOJT(obj: listData[indexPath.row], index: indexPath)
//            cell.delegate = self
//        }
//        return cell
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = (self.clData?.frame.width ?? 0) / 2 - 5
//        return CGSize(width: width, height: HDContentCollectionViewCell.height)
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: view.frame.width, height: 150)
//    }
//    
//}
//// MARK: - Delegate toLearn-toExam
//extension HDContentOJTViewController: MTLevelCellDelegate {
//    func toLearn(indexPath: IndexPath) {
//        let vc = ElearningUltil.share.iPhoneStorybroard.instantiateViewController(withIdentifier: "HDDetailOJTViewController") as! HDDetailOJTViewController
//        vc.mid = listData[indexPath.row].id
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
//    func toExam(indexPath: IndexPath) {
//        MTLevelUltil.share.toExam(exam: nil, mid: listData[indexPath.row].id, typeModule: .ojt)
//    }
//}
//// MARK: - Delegate Filter
//extension HDContentOJTViewController: HDContentHeaderDelegate {
//    func toFiltterExam(year: Int?, month: Int?) {
//        print("ahihi")
//    }
//    func toFilterContent(year: Int?, month: Int?) {
//        currentYear = year
//        currentMonth = month
//        reloadData()
//    }
//}
