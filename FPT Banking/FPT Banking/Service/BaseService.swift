//
//  BaseService.swift
//  FPT Banking
//
//  Created by hưng hoàng on 6/30/20.
//  Copyright © 2020 hưng hoàng. All rights reserved.
//


import Foundation
import Alamofire
import SwiftyJSON
import Photos
import CommonCrypto
import RNCryptor
import AdSupport

typealias CompletionBlockDoubleResult = (_ result1: Any?,_ result2: Any?, _ message: String?, _ errorCode: Int) -> Void
typealias CompletionBlock = (_ result: Any?, _ message: String?, _ errorCode: Int) -> Void
typealias CompletionPageBlock = (_ result: Any?, _ message: String?, _ errorCode: Int, _ isNextPage: Bool?) -> Void
typealias ProgressBlock = (_ currentProgress: Double) -> Void

class BaseServices:NSObject{
    static let shareInstance = BaseServices()
    func post(_ url:URL,parameter:[String:Any]?, header:HTTPHeaders?,block:@escaping CompletionBlock){
        postToServiceWith(url, parameter: parameter, httpMethod: .post, header: header, block: block)
    }
    func get(_ url:URL,parameter:[String:String]?, header:HTTPHeaders?,block:@escaping CompletionBlock){
        postToServiceWith(url, parameter: parameter, httpMethod: .get, header: header, block: block)
    }
    
    // MARK: request get string html
    func getStringHtml(_ url:URL,parameter:[String:String]?, header:HTTPHeaders?,block:@escaping CompletionBlock){
        postToServiceBodyWithHTML(url, parameter: parameter, httpMethod: .get, header: header, block: block)
    }
    
    func postWithBody(_ url:URL,parameter:[String:Any]?, header:HTTPHeaders?,block:@escaping CompletionBlock){
        postToServiceBodyWith(url, parameter: parameter, httpMethod: .post, header: header, block: block)
    }
    private  func postToServiceBodyWith(_ url:URL,parameter:[String:Any]?, httpMethod:HTTPMethod, header:HTTPHeaders?,block:@escaping CompletionBlock){
        Alamofire.request(URL.init(string: url.absoluteString)!, method: httpMethod, parameters: parameter, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            if response.result.isSuccess && response.data != nil {
                do {
                    let resJson = try JSON.init(data: response.data!)
                    
                    block(resJson, resJson["message"].string, resJson[KEY.KEY_API.error].int  ?? ERROR_CODE)
                }
                catch{
                    block(nil,error.localizedDescription,ERROR_CODE)
                }
            } else {
                block(nil, response.error?.localizedDescription, ERROR_CODE)
            }
        }
    }
    
    // MARK: post to service body with html
    private  func postToServiceBodyWithHTML(_ url:URL,parameter:[String:Any]?, httpMethod:HTTPMethod, header:HTTPHeaders?,block:@escaping CompletionBlock){
        print("URL URL URL \(url.absoluteURL)")
        Alamofire.request(URL.init(string: url.absoluteString)!, method: httpMethod, parameters: parameter, encoding: JSONEncoding.default, headers: header).responseString { (response) in
            if response.result.isSuccess {
                block(response.value, "Success", SUCCESS_CODE)
            } else {
                block(nil, "Fail", SUCCESS_CODE)
            }
        }
    }
    
    //MARK: Post to service with
    private func postToServiceWith(_ url:URL,parameter: [String:Any]?, httpMethod:HTTPMethod, header:HTTPHeaders?,block:@escaping CompletionBlock){
        var urlStr = url.absoluteString
        if urlStr.contains(Character.init("?")){
            urlStr = "\(urlStr)&version=\(WTUtilitys.getVersionApp())&platform=0"
        }
        else{
            urlStr = "\(urlStr)?version=\(WTUtilitys.getVersionApp())&platform=0"
        }
        Alamofire.request(URL.init(string: urlStr)!, method: httpMethod, parameters: parameter, encoding: URLEncoding.httpBody, headers: header).responseJSON { (response) in
            #if DEBUG
            print(response.debugDescription)
            #endif
            if response.result.isSuccess && response.data != nil {
                do {
                    let resJson = try JSON.init(data: response.data!)
                    
                    block(resJson, resJson["message"].string, resJson[KEY.KEY_API.error].int  ?? ERROR_CODE)
                }
                catch{
                    block(nil,error.localizedDescription,ERROR_CODE)
                }
            } else {
                block(nil, response.error?.localizedDescription, ERROR_CODE)
            }
        }
    }
    
    func uploadMedia(_ medias: [Data], mediaType: [String], imageField: String, to url: String, with parameters: [String: Any], and headers: HTTPHeaders?, _ completionBlock: @escaping CompletionBlock) {
        let url = URL(string: "\(url)?version=\(WTUtilitys.getVersionApp())&platform=0")!
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (index, mediaData) in medias.enumerated() {
                let paramName = imageField.replacingOccurrences(of: "{}", with: "\(index)")
                multipartFormData.append(mediaData, withName: paramName, fileName: "data.\(mediaType[index].components(separatedBy: "/").last ?? "")", mimeType: mediaType[index])
            }
            for (key, value) in parameters {
                if let value = value as? String {
                    multipartFormData.append(value.data(using: .utf8)!, withName: key)
                } else if CFGetTypeID(value as CFTypeRef) == CFNumberGetTypeID(), let value = value as? Int {
                    multipartFormData.append(value.description.data(using: .utf8)!, withName: key)
                } else if CFGetTypeID(value as CFTypeRef) == CFBooleanGetTypeID(), let value = value as? Bool {
                    multipartFormData.append(value.description.data(using: .utf8)!, withName: key)
                }
            }
        }, usingThreshold: UInt64(), to: url, method: .post, headers: headers) { (result) in
            switch result{
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    #if DEBUG
                    print(response.debugDescription)
                    #endif
                    do {
                        let resJson = try JSON.init(data: response.data!)
                        completionBlock(resJson, resJson["message"].string, resJson[KEY.KEY_API.error].int  ?? -1)
                    } catch {
                        completionBlock(nil,error.localizedDescription, ERROR_CODE)
                    }
                }
            case .failure(let error):
                completionBlock(nil, error.localizedDescription, ERROR_CODE)
            }
        }
    }
}
extension BaseServices{
    //MARK: - Get: listACC, listTrans, listCheque
    // danh sách giao dịch
    func getListTransactions(block:@escaping CompletionBlock) {
        var url = API.getListTransactions
        let id = FBDataCenter.sharedInstance.userInfo?.id ?? 3
        let idAcc = FBDataCenter.sharedInstance.account?.id ?? 3
        url = url.replacingOccurrences(of: "{user_id}", with: "\(id)")
        url = url.replacingOccurrences(of: "{account_id}", with: "\(idAcc)")
        self.get(URL.init(string: url)!, parameter: nil, header: FBHeader.headerTokenJson()) { (response, message, errorCode) in
            if response != nil {
                let jsonData = JSON(response!)
                var result = [TransactionsObj]()
                if let data = jsonData["items"].array {
                    result = data.map {TransactionsObj(json: $0)}
                }
                block(result, message, ERROR_CODE)
            } else {
                block(nil, message,ERROR_CODE)
            }
        }
    }
    // thông tin tài khoản
    func detailUser(block:@escaping CompletionBlock){
        self.get(URL.init(string: API.detailUser)!, parameter: nil, header: FBHeader.headerTokenJson()) { (response, message, errorCode) in
            if response != nil {
                let jsonData = JSON(response!)
                FBDataCenter.sharedInstance.userInfo = FBUserProfile(json: jsonData)
                block(nil, "Lỗi đăng nhập",ERROR_CODE)
            } else {
                block(nil, "Lỗi đăng nhập1",ERROR_CODE)
            }
        }
    }
    // thông tin thẻ
    func getAccount(block:@escaping CompletionBlock) {
        let id = FBDataCenter.sharedInstance.userInfo?.id ?? 2
        let url = API.getAccount.replacingOccurrences(of: "{id}", with: "\(id)")
        self.get(URL.init(string: url)!, parameter: nil, header: FBHeader.headerTokenJson()) { (response, message, errorCode) in
            if response != nil {
                let jsonData = JSON(response!)
                var result = [FBListAccount]()
                if let data = jsonData.array {
                    result = data.map {FBListAccount(json: $0)}
                }
                block(result, message, ERROR_CODE)
            } else {
                block(nil, message,ERROR_CODE)
            }
        }
    }
    // lấy list séc
    func getListCheque(block:@escaping CompletionBlock) {
        var url = API.listCheque
        let id = FBDataCenter.sharedInstance.userInfo?.id ?? 1
        let idAcc = FBDataCenter.sharedInstance.account?.id ?? 1
        url = url.replacingOccurrences(of: "{user_id}", with: "\(id)")
        url = url.replacingOccurrences(of: "{account_id}", with: "\(idAcc)")
        self.get(URL.init(string: url)!, parameter: nil, header: FBHeader.headerTokenJson()) { (response, message, errorCode) in
            if response != nil {
                let jsonData = JSON(response!)
                var result = [FBListsCheque]()
                if let data = jsonData.array {
                    result = data.map {FBListsCheque(json: $0)}
                }
                block(result, message, ERROR_CODE)
            } else {
                block(nil, message,ERROR_CODE)
            }
        }
    }
    
    // lấy số notifications chưa đọc
    func getListNoti(block:@escaping CompletionBlock) {
        let url = API.notifications
        self.get(URL.init(string: url )!, parameter: nil, header: FBHeader.headerTokenJson()) { (response, message, errorCode) in
            if response != nil {
                let jsonData = JSON(response!)
                var result = [FBNotifications]()
                if let data = jsonData.array {
                    result = data.map {FBNotifications(json: $0)}
                }
                block(result, message, ERROR_CODE)
            } else {
                block(nil, message,ERROR_CODE)
            }
        }
    }
    // lấy nội dung notifications
    func getCurrentNoti(block:@escaping CompletionBlock) {
        let url = API.currentNoti
        self.get(URL.init(string: url )!, parameter: nil, header: FBHeader.headerTokenJson()) { (response, message, errorCode) in
            if response != nil {
                let jsonData = JSON(response!)
                var result = [CurrentNotiObj]()
                if let data = jsonData["items"].array {
                    result = data.map {CurrentNotiObj(json: $0)}
                }
                block(result, message, ERROR_CODE)
            } else {
                block(nil, message,ERROR_CODE)
            }
        }
    }
    // lấy số tin nhắn chưa đọc
    func unreadMessage(block:@escaping CompletionBlock) {
        let url = API.unreadMessage
        self.get(URL.init(string: url )!, parameter: nil, header: FBHeader.headerTokenJson()) { (response, message, errorCode) in
            if response != nil {
                let jsonData = JSON(response!)
                var result = [FBNotifications]()
                if let data = jsonData.array {
                    result = data.map {FBNotifications(json: $0)}
                }
                block(result, message, ERROR_CODE)
            } else {
                block(nil, message,ERROR_CODE)
            }
        }
    }
    // lấy nội dung ho so vay
    func getLoanProfiles(block:@escaping CompletionBlock) {
        let url = API.loanProfiles
        self.get(URL.init(string: url )!, parameter: nil, header: FBHeader.headerTokenJson()) { (response, message, errorCode) in
            if response != nil {
                let jsonData = JSON(response!)
                var result = [FBLoanprofiles]()
                if let data = jsonData.array {
                    result = data.map {FBLoanprofiles(json: $0)}
                }
                block(result, message, ERROR_CODE)
            } else {
                block(nil, message,ERROR_CODE)
            }
        }
    }
    
    //MARK: - Post: tranfer, login, verifyOtp, find account
    // đăng nhập
    func login(username:String,password:String,block:@escaping CompletionBlock){
        let passwordEncode = WTUtilitys.encryptAES256(password) ?? ""
        let param:[String:Any] = ["usernameOrEmail":username,
                                  "password":password]
        self.postWithBody(URL.init(string: API.login)!, parameter: param, header: nil) { (response, message, errorCode) in
            if response != nil {
                let jsonData = JSON(response!)
                if let token = jsonData["accessToken"].string {
                    FBDataCenter.sharedInstance.token = token
                    block(response, "Thành công",SUCCESS_CODE)
                } else {
                    block(response, message,ERROR_CODE)
                }
            } else {
                block(response, "Lỗi đăng nhập",ERROR_CODE)
            }
        }
    }
    // chuyển tiền qua stk
    func tranfer(accountNumber: String, amount: String, fullName: String, pin: Int, des: String,block:@escaping CompletionBlock) {
        let param = [
            "accountNumber": accountNumber,
            "amount": amount,
            "fullName": fullName,
            "pin": pin,
            "description": des,
            ] as [String : Any]
        var url = API.tranfer
        let id = FBDataCenter.sharedInstance.userInfo?.id ?? 2
        let idAcc = FBDataCenter.sharedInstance.account?.id ?? 2
        url = url.replacingOccurrences(of: "{user_id}", with: "\(id)")
        url = url.replacingOccurrences(of: "{account_id}", with: "\(idAcc)")
        self.postWithBody(URL.init(string: url)!, parameter: param, header: FBHeader.headerTokenJson()) { (response, message, errorCode) in
            if response != nil {
                let jsonData = JSON(response!)
                let code = jsonData["status"] == 200 ? SUCCESS_CODE : errorCode
                block(jsonData["message"].string, "Thành công",code)
            } else {
                block(response, "Lỗi đăng nhập",ERROR_CODE)
            }
        }
    }
    // chuyển tiền qua thẻ
    func tranferCard(cardNumber: String, amount: String, fullName: String, pin: Int, des: String,block:@escaping CompletionBlock) {
        let param = [
            "cardNumber": cardNumber,
            "amount": amount,
            "fullName": fullName,
            "pin": pin,
            "description": des,
            ] as [String : Any]
        var url = API.tranferCard
        let id = FBDataCenter.sharedInstance.userInfo?.id ?? 2
        let idAcc = FBDataCenter.sharedInstance.account?.id ?? 2
        url = url.replacingOccurrences(of: "{user_id}", with: "\(id)")
        url = url.replacingOccurrences(of: "{account_id}", with: "\(idAcc)")
        self.postWithBody(URL.init(string: url)!, parameter: param, header: FBHeader.headerTokenJson()) { (response, message, errorCode) in
            if response != nil {
                let jsonData = JSON(response!)
                let code = jsonData["status"] == 200 ? SUCCESS_CODE : errorCode
                block(jsonData["message"].string, "Thành công",code)
            } else {
                block(response, "Lỗi đăng nhập",ERROR_CODE)
            }
        }
    }
    // thêm séc
    func addCheque(recieverFullname: String, recieverIdCardNumber: String, transactionAmount: String,block:@escaping CompletionBlock) {
        let param:[String : Any] = [
            "recieverFullname": recieverFullname,
            "recieverIdCardNumber": recieverIdCardNumber,
            "transactionAmount": transactionAmount]
        var url = API.addCheque
        let id = FBDataCenter.sharedInstance.userInfo?.id ?? 2
        let idAcc = FBDataCenter.sharedInstance.account?.id ?? 2
        url = url.replacingOccurrences(of: "{user_id}", with: "\(id)")
        url = url.replacingOccurrences(of: "{account_id}", with: "\(idAcc)")
        self.postWithBody(URL.init(string: url)!, parameter: param, header: FBHeader.headerTokenJson()) { (response, message, errorCode) in
            if response != nil {
                let jsonData = JSON(response!)
                let code = jsonData["status"] == 200 ? SUCCESS_CODE : errorCode
                block(jsonData["message"].string, "Thành công",code)
            } else {
                block(response, "Lỗi đăng nhập",ERROR_CODE)
            }
        }
    }
    // sửa séc
    func editCheque(id: String,recieverFullname: String, recieverIdCardNumber: String, transactionAmount: String,block:@escaping CompletionBlock) {
        let param:[String : Any] = [
            "chequeId" :id,
            "recieverFullname": recieverFullname,
            "recieverIdCardNumber": recieverIdCardNumber,
            "transactionAmount": transactionAmount]
        let url = API.editCheque
        self.postWithBody(URL.init(string: url)!, parameter: param, header: FBHeader.headerTokenJson()) { (response, message, errorCode) in
            if response != nil {
                let jsonData = JSON(response!)
                let code = jsonData["status"] == 200 ? SUCCESS_CODE : errorCode
                block(jsonData["message"].string, "Thành công",code)
            } else {
                block(response, "Lỗi đăng nhập",ERROR_CODE)
            }
        }
    }
    // thay pass
    func changePassword(password: String, passwordConfirm: String,block:@escaping CompletionBlock) {
        let param:[String : Any] = [
            "password": password,
            "passwordConfirm": passwordConfirm]
        var url = API.changePassword
        let id = FBDataCenter.sharedInstance.userInfo?.id ?? 2
        let idAcc = FBDataCenter.sharedInstance.account?.id ?? 2
        url = url.replacingOccurrences(of: "{user_id}", with: "\(id)")
        url = url.replacingOccurrences(of: "{account_id}", with: "\(idAcc)")
        self.postWithBody(URL.init(string: url)!, parameter: param, header: FBHeader.headerTokenJson()) { (response, message, errorCode) in
            if response != nil {
                let jsonData = JSON(response!)
                let code = jsonData["status"] == 200 ? SUCCESS_CODE : errorCode
                block(jsonData["message"].string, "Thành công",code)
            } else {
                block(response, "Lỗi đăng nhập",ERROR_CODE)
            }
        }
    }
    // xác thực otp
    func verifyOtpTranfer(idTranfer: String, otp: String ,block:@escaping CompletionBlock)  {
        let param = [
            "transactionQueueId": idTranfer,
            "otpCode": otp
            ] as [String : Any]
        var url = API.tranferVerify
        self.postWithBody(URL.init(string: url)!, parameter: param, header: FBHeader.headerTokenJson()) { (response, message, errorCode) in
            if response != nil {
                let jsonData = JSON(response!)
                block(jsonData["message"].string, "Thành công",errorCode)
            } else {
                block(response, "Lỗi đăng nhập",ERROR_CODE)
            }
        }
    }
    // tìm kiếm
    func findAccount(term: String, type: String ,block:@escaping CompletionBlock)  {
        let param = [
            "term": term,
            "type": type
            ] as [String : Any]
        var url = API.findAccount
        self.postWithBody(URL.init(string: url)!, parameter: param, header: FBHeader.headerTokenJson()) { (response, message, errorCode) in
            if response != nil {
                let jsonData = JSON(response!)
                if let fullName = jsonData["fullname"].string {
                    FBDataCenter.sharedInstance.fullName = fullName
                    block(response, "Thành công",SUCCESS_CODE)
                } else {
                    block(response, message,ERROR_CODE)
                }
            } else {
                block(response, "Lỗi đăng nhập",ERROR_CODE)
            }        }
    }
    
}

class FBHeader {
    class func headerTokenForUpload()-> HTTPHeaders{
        return ["Authorization":"Bearer \(FBDataCenter.sharedInstance.token)",
            "Content-type": "multipart/form-data"]
    }
    class func headerTokenTitle()-> HTTPHeaders{
        return ["Authorization":"Bearer \(FBDataCenter.sharedInstance.token)",
            "Content-Type":"application/x-www-form-urlencoded"]
    }
    class  func headerToken() -> HTTPHeaders{
        return ["Authorization":"Bearer \(FBDataCenter.sharedInstance.token)"]
    }
    class func headerTokenJson() -> HTTPHeaders {
        return ["Authorization": "Bearer \(FBDataCenter.sharedInstance.token)",
            "Content-type": "application/json"]
    }
    class func  headerForLogin() -> HTTPHeaders  {
        return [
            "Content-Type" : "application/x-www-form-urlencoded",
            "deviceid":(UIDevice.current.identifierForVendor?.uuidString)!]
    }
    
}

struct API {
    static let baseUrl = "http://198.119.45.100:8080/api/"
    struct PATH {
        static let login = "user/auth/login"
        static let logout = "auth/logout"
        static let detailUser = "users/current"
        static let getAccount = "users/{id}/accounts"
        static let findAccount = "users/find"
        static let getListTransactions = "users/{user_id}/accounts/{account_id}/transactions"
        static let transfer = "users/{user_id}/accounts/{account_id}/transferInternal/accountNumber"
        static let transferCard = "users/{user_id}/accounts/{account_id}/transferInternal/cardNumber"
        static let tranferVerify = "transfer/confirm"
        static let listCheque = "users/{user_id}/accounts/{account_id}/cheques"
        static let editCheque = "users/current/accounts/cheques/edit"
        static let addCheque = "users/{user_id}/accounts/{account_id}/cheques"
        static let changePassword = "users/current/change-password"
        static let notifications = "users/current/notifications/totalUnread"
        static let unreadMessage = "users/current/conversations/total-unread"
        static let curentNoti = "users/current/notifications"
        static let loanProfiles = "users/current/loanProfiles"
        
    }
    static let login = "\(baseUrl)\(PATH.login)"
    static let logout = "\(baseUrl)\(PATH.logout)"
    static let detailUser = "\(baseUrl)\(PATH.detailUser)"
    static let getAccount = "\(baseUrl)\(PATH.getAccount)"
    static let findAccount = "\(baseUrl)\(PATH.findAccount)"
    static let tranfer = "\(baseUrl)\(PATH.transfer)"
    static let tranferCard = "\(baseUrl)\(PATH.transferCard)"
    static let tranferVerify = "\(baseUrl)\(PATH.tranferVerify)"
    static let getListTransactions = "\(baseUrl)\(PATH.getListTransactions)"
    static let listCheque = "\(baseUrl)\(PATH.listCheque)"
    static let editCheque = "\(baseUrl)\(PATH.editCheque)"
    static let addCheque = "\(baseUrl)\(PATH.addCheque)"
    static let changePassword = "\(baseUrl)\(PATH.changePassword)"
    static let notifications = "\(baseUrl)\(PATH.notifications)"
    static let unreadMessage = "\(baseUrl)\(PATH.unreadMessage)"
    static let currentNoti = "\(baseUrl)\(PATH.curentNoti)"
    static let loanProfiles = "\(baseUrl)\(PATH.loanProfiles)"
    
}
struct KEY {
    struct KEY_API {
        static let rememberLogin = "rememberID"
        static let userName = "username"
        static let id = "id"
        static let password = "password"
        static let error = "error"
        static let message = "message"
        static let data = "data"
        static let access_token = "access_token"
        
    }
}
