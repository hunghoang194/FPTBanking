////
////  HDDetailOJTViewController.swift
////  HVN MACs
////
////  Created by Hung Hoang on 5/25/20.
////  Copyright © 2020 Tung Nguyen. All rights reserved.
////
//
//import UIKit
//import Toaster
//import MBProgressHUD
//
//class HDDetailOJTViewController: HDBaseViewController {
//    @IBOutlet weak var clData: UICollectionView?
//    var mid: Int?
//    var cateLessons = [CateLessonObj]()
//    
//    // MARK: - Life cycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.isShowBackButton = true
//        self.isShowRightMenu = true
//        self.isShowNoti = true
//        self.title = "Chi Tiết OJT"
//        self.isBackgroundGray = true
//    }
//    
//    // MARK: - Support method
//    override func initData() {
//        clData?.register(MTLevelIphoneCollectionViewCell.nib, forCellWithReuseIdentifier: MTLevelIphoneCollectionViewCell.name)
//        clData?.delegate = self
//        clData?.dataSource = self
//        self.getData()
//    }
//    
//    func toModule(indexPath: IndexPath) {
//        let vc = MTLevelUltil.share.phoneStorybroard.instantiateViewController(withIdentifier: "ListLessoniPhoneVC") as! ListLessoniPhoneVC
//        vc.mid = self.mid
//        vc.typeExam = .ojt
//        vc.cateLesson = cateLessons[indexPath.row]
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
//    // MARK: - get API
//    func getData() {
//        MBProgressHUD.showAdded(to: self.view, animated: true)
//        HDServices.shareInstance.getListCategoryLessonByOjt(mId: self.mid ?? -1) { (response, message, errorCode) in
//            MBProgressHUD.hide(for: self.view, animated: true)
//            if let data = response as? [CateLessonObj], errorCode == SUCCESS_CODE {
//                print(data)
//                self.cateLessons = data
//                self.clData?.reloadData()
//            } else {
//                Toast(text: "Dữ liệu hiện đang cập nhật", duration: 2.0).show()
//            }
//        }
//    }
//}
//// MARK: - CollectionView
//extension HDDetailOJTViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MTLevelCellDelegate {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return cateLessons.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MTLevelIphoneCollectionViewCell.name, for: indexPath) as! MTLevelIphoneCollectionViewCell
//        if indexPath.row < cateLessons.count {
//            cell.setup(obj: cateLessons[indexPath.row], index: indexPath)
//            cell.delegate = self
//        }
//        return cell
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = (self.clData?.frame.width ?? 0)
//        return CGSize(width: width, height: MTLevelIphoneCollectionViewCell.height)
//    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
////        toModule(indexPath: indexPath)
//        MTLevelUltil.share.toDetailLesson(id: cateLessons[indexPath.row].idLesson, typeModule: .ojt)
//    }
//}
//
