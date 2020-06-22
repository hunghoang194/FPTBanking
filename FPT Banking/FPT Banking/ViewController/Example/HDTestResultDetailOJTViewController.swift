////
////  HDTestResultDetailOJTViewController.swift
////  
////
////  Created by Hung Hoang on 5/20/20.
////
//
//import UIKit
//import Firebase
//import MBProgressHUD
//import Toaster
//
//class HDTestResultDetailOJTViewController: HDBaseViewController {
//    @IBOutlet weak var stResult: UIStackView!
//    @IBOutlet weak var resultView: UIView!
//    @IBOutlet weak var yearView: UIView!
//    @IBOutlet weak var dropMenuYear: KPDropMenu!
//    @IBOutlet weak var monthView: UIView!
//    @IBOutlet weak var dropMenuMonth: KPDropMenu!
//    @IBOutlet weak var testTB: UITableView!
//    @IBOutlet weak var btnshowAll: UIButton!
//    
//    var objs: HDListHistoryElearningTestResult?
//    var page = 1
//    var isNextPage = true
//    var listLevel = [HDListHistoryElearningTestResult]()
//    var currentMonth:Int?
//    var currentYear:Int?
//    var arrYear = [String]()
//    var arrMonth = [String]()
//    
//    // MARK: - Life cycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.title = " Kết quả bài kiểm tra"
//        self.isShowBackButton = true
//        self.isShowRightMenu = true
//        self.isShowNoti = true
//        self.isBackgroundGray = true
//        self.getDataHistoryResult()
//        getDataDrop()
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
//        testTB.addInfiniteScroll { (cl) in
//            if self.isNextPage == true{
//                self.getDataHistoryResult(year: self.currentYear, month: self.currentMonth)
//            } else {
//                self.testTB.finishInfiniteScroll()
//            }
//        }
//        Analytics.setScreenName("testResultDetailOJT", screenClass: "testResultDetailOJT")
//    }
//    
//    // MARK: - Support method
//    override func initData() {
//        testTB.delegate = self
//        testTB.dataSource = self
//        self.testTB?.register(UINib.init(nibName: "HDTestResultOJTTableViewCell", bundle: nil), forCellReuseIdentifier: "HDTestResultOJTTableViewCell")
//        self.testTB?.tableFooterView = UIView.init()
//        
//        dropMenuMonth?.delegate = self
//        dropMenuMonth.viewBase = AppDelegate.sharedInstance.window
//        dropMenuYear?.delegate = self
//        dropMenuYear.viewBase = AppDelegate.sharedInstance.window
//    }
//    
//    override func initUI() {
//        dropMenuMonth?.itemsFont = UIFont.init(name: "Montserrat-Regular", size: 13.0)
//        dropMenuMonth?.titleTextAlignment = .left
//        dropMenuMonth?.setTextToLabelColor()
//        dropMenuMonth?.setDefaultItemBackgroundColor()
//        dropMenuYear?.itemsFont = UIFont.init(name: "Montserrat-Regular", size: 13.0)
//        dropMenuYear?.titleTextAlignment = .left
//        dropMenuYear?.setTextToLabelColor()
//        dropMenuYear?.setDefaultItemBackgroundColor()
//        
//        yearView.setBorder(color: UIColor(hex: "#BDBDBD"), width: 1, isCircle: true, mutilColorName: ColorName.BorderCellColor)
//        monthView.setBorder(color: UIColor(hex: "#BDBDBD"), width: 1, isCircle: true, mutilColorName: ColorName.BorderCellColor)
//    }
//    
//    func goResultOJT() {
//        let vc = ElearningUltil.share.storyboard.instantiateViewController(withIdentifier: "HDTestResultOJTViewController") as! HDTestResultOJTViewController
//        AppDelegate.sharedInstance.mainNavigation?.pushViewController(vc, animated: true)
//    }
//    func validateTimeInPut(_ year: Int?, _ month: Int?) -> Bool {
//        if currentMonth != nil, currentYear == nil {
//            Toast(text: "Bạn chưa chọn năm", duration: 2.0).show()
//            return false
//        }
//        return true
//    }
//    
//    // MARK: - Data & API
//    func reloadData() {
//        page = 1
//        isNextPage = true
//        getDataHistoryResult(year: currentYear, month: currentMonth)
//    }
//    
//    func getDataHistoryResult(year: Int? = nil, month: Int? = nil) {
//        if isNextPage {
//            MBProgressHUD.showAdded(to: self.view, animated: true)
//            HDServices.shareInstance.getListHistoryElearningTest(year: year, month: month, page: self.page) { (response, message, errorCode,isNextPage) in
//                MBProgressHUD.hide(for: self.view, animated: true)
//                self.testTB?.finishInfiniteScroll()
//                if errorCode == SUCCESS_CODE{
//                    if self.page == 1 {
//                        self.listLevel = ((response as? [HDListHistoryElearningTestResult]) ?? [HDListHistoryElearningTestResult]())
//                    } else {
//                        self.listLevel = self.listLevel + ((response as? [HDListHistoryElearningTestResult]) ?? [HDListHistoryElearningTestResult]())
//                    }
//                    self.isNextPage = isNextPage ?? false
//                    if self.isNextPage {
//                        self.page += 1
//                    }
//                    self.testTB?.reloadData()
//                } else {
//                    self.listLevel.removeAll()
//                    self.testTB?.reloadData()
//                    Toast(text: "Không tìm thấy dữ liệu mà bạn cần tìm kiếm", duration: 2.0).show()
//                }
//            }
//        }
//    }
//    
//    // MARK: - Actions method
//    @IBAction func showAllPress(_ sender: Any) {
//        currentMonth = nil
//        currentYear = nil
//        dropMenuMonth.reloadDrop()
//        dropMenuYear.reloadDrop()
//        self.reloadData()
//    }
//}
//// MARK: - TableView
//extension HDTestResultDetailOJTViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return listLevel.count
//    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 70
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "HDTestResultOJTTableViewCell", for: indexPath) as! HDTestResultOJTTableViewCell
//        cell.selectionStyle = .none
//        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, UIScreen.main.bounds.width)
//        if indexPath.row < listLevel.count {
//            cell.setupData(obj: listLevel[indexPath.row], index: indexPath)
//        }
//        return cell
//    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = ElearningUltil.share.storyboard.instantiateViewController(withIdentifier: "HDTestResultOJTViewController") as! HDTestResultOJTViewController
//        vc.dataResult = listLevel[indexPath.row]
//        AppDelegate.sharedInstance.mainNavigation?.pushViewController(vc, animated: true)
//    }
//}
//
//// MARK: - DropMenu
//extension HDTestResultDetailOJTViewController: KPDropMenuDelegate {
//    func didSelectItem(_ dropMenu: KPDropMenu!, at atIndex: Int32) {
//        if dropMenu == dropMenuYear {
//            currentYear = Int(arrYear[Int(atIndex)])
//            self.listLevel.removeAll()
//            self.testTB.reloadData()
//            if validateTimeInPut(currentYear, currentMonth) {
//                self.reloadData()
//            }
//        }
//        if dropMenu == dropMenuMonth {
//            currentMonth = Int(atIndex) + 1
//            self.listLevel.removeAll()
//            self.testTB.reloadData()
//            if validateTimeInPut(currentYear, currentMonth) {
//                self.reloadData()
//            }
//        }
//    }
//    func getDataDrop() {
//        let year = Int(Date().getTextFromDate("yyyy") ?? "") ?? 0
//        for i in 0...4 {
//            arrYear.append("\(year - i)")
//        }
//        for i in 1...12 {
//            arrMonth.append("Tháng \(i)")
//        }
//        dropMenuMonth.items = arrMonth
//        dropMenuYear.items = arrYear
//    }
//}
