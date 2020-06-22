////
////  HDTestResultOJTViewController.swift
////  HVN MACs
////
////  Created by Hung Hoang on 5/20/20.
////  Copyright © 2020 Tung Nguyen. All rights reserved.
////
//
//import UIKit
//import Firebase
//import Toaster
//
//class HDTestResultOJTViewController: HDBaseViewController {
//    @IBOutlet weak var contentView: UIView!
//    @IBOutlet weak var nameView: UIView!
//    @IBOutlet weak var imageShow: UIImageView!
//    @IBOutlet weak var nameLabel: UILabel!
//    @IBOutlet weak var resultView: UIView!
//    @IBOutlet weak var imgResult: UIImageView!
//    @IBOutlet weak var testResultLabel: UILabel!
//    @IBOutlet weak var numberTestResultLabel: UILabel!
//    @IBOutlet weak var timeTestView: UIView!
//    @IBOutlet weak var imageTimeTest: UIImageView!
//    @IBOutlet weak var timeTestLabel: UILabel!
//    @IBOutlet weak var dateTimeTestLabel: UILabel!
//    @IBOutlet weak var timeToDoTestView: UIView!
//    @IBOutlet weak var timeToDoTestImage: UIImageView!
//    @IBOutlet weak var timeToDoTestLabel: UILabel!
//    @IBOutlet weak var dateTimeToDoTestLabel: UILabel!
//
//    var openColor = UIColor(hex: "#FF9900")
//    var passColor = UIColor(hex: "#01D158")
//    var falseColor = UIColor(hex: "#C80A0A")
//    var mid: Int?
//    var dataResult: HDListHistoryElearningTestResult?
//    // MARK: - Life cycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        self.title = " Kết quả bài kiểm tra"
//        self.isShowBackButton = true
//        self.isShowRightMenu = true
//        self.isShowNoti = true
//        self.isBackgroundGray = true
//    }
//    override func initUI() {
//        contentView.layer.cornerRadius = 4
//        contentView.layer.masksToBounds = true
//        contentView.setMutilColorForView(nameColor: ColorName.CallBackground)
//    }
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        if #available(iOS 13.0, *) {
//            slideMenuController()?.closeLeft()
//            slideMenuController()?.closeRight()
//        } else {
//            // Fallback on earlier versions
//        }
//        Analytics.setScreenName("testResultOJT", screenClass: "testResultOJT")
//    }
//    // MARK: - Setup Data
//    func setupResult() {
//        let score = dataResult?.totalScore ?? 0
//        let passScore = dataResult?.passScore ?? 1
//        if dataResult?.passScore == 0 {
//            //chua lam bai hoac chua co diem
//            numberTestResultLabel.textColor = UIColor.init(hex: "#FF9900")
//            numberTestResultLabel.text = "Chờ xử lý"
//        }else {
//            if score >= passScore {
//                numberTestResultLabel.textColor = passColor
//            } else {
//                numberTestResultLabel.textColor = falseColor
//            }
//            numberTestResultLabel.text = "\(dataResult?.totalScore ?? 0) / \(dataResult?.totalPoint ?? 1) điểm"
//        }
//    }
//    // doi sever them api
////    @IBAction func viewDetail(_ sender: Any) {
////        if dataResult?.passScore == 0 {
////            VEAcceptPopupView.showPopup(
////                title: "Bài kiểm tra hiện tại đang chờ xử lý nên bạn chưa thể xem được chi tiết bài làm của mình",
////                titleAccept: "OK",
////                isHiddenCancel: true,
////                aceptAction: {
////                    self.navigationController?.popViewController(animated: true)
////                })
////        } else if dataResult?.passScore != 0 {
////            print ("chuyen sang man chi tiet ket qua kiem tra iphone")
////        }
////    }
//
//    override func initData() {
//        nameLabel.text = dataResult?.staffName
//        dateTimeTestLabel.text = dataResult?.createTest
//        dateTimeToDoTestLabel.text = dataResult?.time
//        dateTimeToDoTestLabel.text = TimeInterval(self.dataResult?.time ?? "")!.getString()
//        self.setupResult()
//    }
//}
