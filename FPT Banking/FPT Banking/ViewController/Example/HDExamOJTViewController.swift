////
////  HDExamOJTViewController.swift
////  HVN MACs
////
////  Created by Hung Hoang on 5/19/20.
////  Copyright © 2020 Tung Nguyen. All rights reserved.
////
//
//import UIKit
//import MBProgressHUD
//import Toaster
//import Firebase
//
//class HDExamOJTViewController: HDBaseViewController {
//    @IBOutlet weak var clData: UICollectionView?
//    
//    var listExam = [HDListOJT]()
//    var obj: HDListOJT?
//    var dataModule = [MTModuleObj]()
//    var mid: Int?
//    var level:MTModuleObj?
//    var page = 1
//    var isNextPage = true
//    var currentMonth:Int?
//    var currentYear:Int?
//    var arrYear = [String]()
//    var arrMonth = [String]()
//    
//    // MARK: - Life cycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.title = "Bài kiểm tra"
//        self.isShowBackButton = true
//        self.isShowRightMenu = true
//        self.isShowNoti = true
//        self.isBackgroundGray = true
//        MTLevelUltil.share.doExamDelegate = self
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
//        clData?.addInfiniteScroll { (cl) in
//            if self.isNextPage == true{
//                self.getListElearningTestOjt(year: self.currentYear, month: self.currentMonth)
//            } else {
//                self.clData?.finishInfiniteScroll()
//            }
//        }
//        Analytics.setScreenName("ExamOJT", screenClass: "ExamOJT")
//    }
//    
//    // MARK: - Support method
//    override func initData() {
//        clData?.register(HDExamCollectionViewCell.nib, forCellWithReuseIdentifier: HDExamCollectionViewCell.name)
//        clData?.register(UINib(nibName: "HDContentHeaderCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HDContentHeaderCollectionReusableView")
//        clData?.delegate = self
//        clData?.dataSource = self
//        getListElearningTestOjt()
//    }
//    
//    func validateTimeInPut(_ year: Int?, _ month: Int?) -> Bool {
//        if currentMonth != nil, currentYear == nil {
//            return false
//        }
//        return true
//    }
//    // MARK: - Data & API
//    func reloadData() {
//        self.listExam.removeAll()
//        self.clData?.reloadData()
//        page = 1
//        isNextPage = true
//        getListElearningTestOjt(year: currentYear, month: currentMonth)
//    }
//    func getListElearningTestOjt(year: Int? = nil, month: Int? = nil) {
//        if isNextPage {
//            MBProgressHUD.showAdded(to: self.view, animated: true)
//            HDServices.shareInstance.getListElearningTestOjt(year: year, month: month,page: self.page ) { (response, message, errorCode, isNextPage) in
//                MBProgressHUD.hide(for: self.view, animated: true)
//                self.clData?.finishInfiniteScroll()
//                if errorCode == SUCCESS_CODE {
//                    if self.page == 1 {
//                        self.listExam = ((response as? [HDListOJT]) ?? [HDListOJT]())
//                    } else {
//                        self.listExam = self.listExam + ((response as? [HDListOJT]) ?? [HDListOJT]())
//                    }
//                    self.isNextPage = isNextPage ?? false
//                    if self.isNextPage {
//                        self.page += 1
//                    }
//                    self.clData?.reloadData()
//                } else {
//                    self.listExam.removeAll()
//                    self.clData?.reloadData()
//                    Toast(text: "Không tìm thấy dữ liệu mà bạn cần tìm kiếm", duration: 2.0).show()
//                }
//            }
//        }
//    }
//}
//
//extension HDExamOJTViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return listExam.count
//    }
//    //Header CollectionView
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        guard let headerView = collectionView.dequeueReusableSupplementaryView(
//            ofKind: kind,
//            withReuseIdentifier: "HDContentHeaderCollectionReusableView",
//            for: indexPath) as? HDContentHeaderCollectionReusableView
//            else { fatalError("Invalid view type") }
//        headerView.delegate = self
//        return headerView
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HDExamCollectionViewCell.name, for: indexPath) as! HDExamCollectionViewCell
//        if indexPath.row < listExam.count {
//            cell.examOJT(obj: listExam[indexPath.row], index: indexPath)
//            cell.delegate = self
//        }
//        return cell
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = (self.clData?.frame.width ?? 0) / 2 - 5
//        return CGSize(width: width, height: HDExamCollectionViewCell.height)
//    }
//}
//extension HDExamOJTViewController: MTLevelCellDelegate {
//    func toExam(indexPath: IndexPath) {
//        MTLevelUltil.share.toExam(exam: nil, mid: listExam[indexPath.row].oid, typeModule: .ojt)
//    }
//}
//// MARK: - DropMenu
//extension HDExamOJTViewController: HDContentHeaderDelegate {
//    func toFiltterExam(year: Int?, month: Int?) {
//        currentYear = year
//        currentMonth = month
//        reloadData()
//    }
//    
//    func toFilterContent(year: Int?, month: Int?) {
//        print("toFilterContent")
//    }
//}
//
//extension HDExamOJTViewController: DoExamDelegate {
//    func success() {
//        reloadData()
//    }
//}
