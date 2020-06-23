//
//  FBService.swift
//  FPT Banking
//
//  Created by Hung Hoang on 6/22/20.
//  Copyright © 2020 hưng hoàng. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import Photos
import CommonCrypto
//import RNCryptor
//import TLPhotoPicker
import AdSupport

typealias CompletionBlockDoubleResult = (_ result1: Any?,_ result2: Any?, _ message: String?, _ errorCode: Int) -> Void
typealias CompletionBlock = (_ result: Any?, _ message: String?, _ errorCode: Int) -> Void
typealias CompletionPageBlock = (_ result: Any?, _ message: String?, _ errorCode: Int, _ isNextPage: Bool?) -> Void
typealias ProgressBlock = (_ currentProgress: Double) -> Void

class FBServices:NSObject{
    static let shareInstance = FBServices()
    }
    
    // MARK: request get string html
    func getStringHtml(_ url:URL,parameter:[String:String]?, header:HTTPHeaders?,block:@escaping CompletionBlock){
        postToServiceBodyWithHTML(url, parameter: parameter, httpMethod: .get, header: header, block: block)
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
extension FBServices {
    func login(username:String,password:String,block:@escaping CompletionBlock){
        let passwordEncode = WTUtilitys.encryptAES256(password) ?? ""
        let param:[String:Any] = ["name":username,
                                  "password":passwordEncode]
    }
//    func login(username:String,password:String,block:@escaping CompletionBlock){
//        var deviceToken:String = WTUtilitys.getDefaultString(originString: UserDefaults.resultUUID() as AnyObject)
//        print("deviceToken \(deviceToken)")
//        var deviceTokenPushkit = WTUtilitys.getDefaultString(originString: UserDefaults.resultUUIDPushkit() as AnyObject)
//        if deviceToken == "" {
//            deviceToken = SIMULATOR_TOKEN
//        }
//        if deviceTokenPushkit == "" {
//            deviceTokenPushkit = SIMULATOR_TOKEN
//        }
//        //        if deviceToken != nil {
//        let passwordEncode = WTUtilitys.encryptAES256(password) ?? ""
//        var udid = ASIdentifierManager.shared().advertisingIdentifier.uuidString
//        if udid.replacingOccurrences(of: "0", with: "").count < 10 {
//            udid = UIDevice.current.identifierForVendor?.uuidString ?? ""
//        }
//        let param:[String:Any] = ["name":username,
//                                  "password":passwordEncode,
//                                  "uuid":deviceToken,
//                                  "uuid_pushkit":deviceTokenPushkit,
//                                  "device_id": udid]
//        self.post(URL.init(string: API.login)!, parameter: param, header: nil, block: block)
//    }
    
//    func refreshToken(username:String,password:String,block:@escaping CompletionBlock){
//        var deviceToken:String = WTUtilitys.getDefaultString(originString: UserDefaults.resultUUID() as AnyObject)
//        if deviceToken == "" {
//            deviceToken = SIMULATOR_TOKEN
//        }
//        //        if deviceToken != nil {
//        let passwordEncode = WTUtilitys.encryptAES256(password) ?? ""
//        let param:[String:Any] = ["name":username,
//                                  "password":passwordEncode,
//                                  "uuid":deviceToken,
//                                  "platform":0] // 0: IOS
//        self.post(URL.init(string: API.refreshToken)!, parameter: param, header: nil){ (response, message, errorCode) in
//            if response != nil{
//                let resJson = JSON.init(response!)
//
//                HDDataCenter.sharedInstance.token = "Bearer \(resJson["data"]["access_token"].string ?? "")"
//                HDKeychainService.saveToken(token:"Bearer \(resJson["data"]["access_token"].string ?? "")")
//
//                print("Bearer \(resJson["data"]["access_token"].string ?? "")")
//                block(resJson["data"].array,resJson["message"].string,errorCode)
//            }
//            else{
//                block(nil,message,errorCode)
//            }
//        }
//    }
    // MARK: HEAD update password
//    func updatePassword(id: String, newPass: String, confirmPass: String, block:@escaping CompletionBlock) {
//        let newPasswordEncode = WTUtilitys.encryptAES256(newPass) ?? ""
//        let confirmPassEncode = WTUtilitys.encryptAES256(confirmPass) ?? ""
//        let param = ["id":id,
//                     "password":newPasswordEncode,
//                     "password_confirm":confirmPassEncode]
//        self.post(URL.init(string: API.updatePass)!, parameter: param, header: FBHeader.headerToken()) { (response, message, errorCode) in
//            if errorCode == SUCCESS_CODE{
//                let resJson = JSON.init(response!)
//                block(nil,resJson["message"].string,resJson["error"].int ?? ERROR_CODE)
//            }
//            else{
//                block(nil,message,ERROR_CODE)
//            }
//        }
//    }
//    func logout(block:@escaping CompletionBlock){
//        var deviceToken:String = WTUtilitys.getDefaultString(originString: UserDefaults.resultUUID() as AnyObject)
//        if deviceToken == "" {
//            deviceToken = SIMULATOR_TOKEN
//        }
//        self.get(URL.init(string: "\(API.logout)\(deviceToken)")!, parameter: nil, header: FBHeader.headerToken(), block: block)
//    }
//    func searchReport(status:Int?,headId:String?,keyword:String?,uid:String?,page:Int?,block:@escaping CompletionPageBlock){
//        var statusStr = ""
//        var pageStr = ""
//        if status != nil{
//            statusStr = "\(status ?? 0)"
//        }
//        if page != nil{
//            pageStr = "\(page ?? 0)"
//        }
//        let keywordEncode = (keyword ?? "").addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
//        //        let headNameEncode = (headName ?? "").addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
//        let api = String.init(format: API.searchReport,statusStr,headId ?? "",keywordEncode ?? "",uid ?? "",pageStr)
//        self.get(URL.init(string: api)!, parameter: nil, header: FBHeader.headerToken()) { (response, message, errorCode) in
//            if response != nil{
//                let resJson = JSON.init(response!)
//                if errorCode == SUCCESS_CODE{
//                    var arrReport = [FBUserProfile]() // doi lai sau
//                    let arrJson = resJson["data"]["data"].array
//                    if arrJson?.count ?? 0 > 0{
//                        for report in arrJson!{
//                            arrReport.append(FBUserProfile.init(json: report))// doi lai sau
//                        }
//                    }
//                    block(arrReport,message,SUCCESS_CODE, resJson["data"]["dataPage"]["nextPage"].bool ?? false)
//                }
//                else{
//                    block(nil, resJson["message"].string, ERROR_CODE, nil)
//                }
//            }
//            else{
//                block(nil,message,errorCode, nil)
//            }
//        }
//    }
//
//    func searchAccount(block:@escaping CompletionBlock){
//        self.get(URL.init(string: API.searchAccount)!, parameter: nil, header: FBHeader.headerToken()) { (response, message, errorCode) in
//            if response != nil{
//                let resJson = JSON.init(response!)
//                if errorCode == SUCCESS_CODE{
//                    var arrCarType = [FBUserProfile]() // sua lai sau
//                    let arrJson = resJson["data"].array
//                    if arrJson?.count ?? 0 > 0{
//                        for carType in arrJson!{
//                            arrCarType.append(FBUserProfile.init(json: carType)) // sua lai sau
//                        }
//                    }
//                    block(arrCarType,message,SUCCESS_CODE)
//                }
//                else{
//                    block(nil, resJson["message"].string, ERROR_CODE)
//                }
//            }
//            else{
//                block(nil,message,errorCode)
//            }
//        }
//    }
//    func getListOjt(year:Int?, month: Int?,block:@escaping CompletionBlock){
//        let yearStr = year == nil ? "" : "\(year ?? 0)"
//        let monthStr = year == nil ? "" : "\(month ?? 0)"
//        let api = "\(API.getListOjt)?year=\(yearStr)&month=\(monthStr)"
//        print(api)
//        self.get(URL.init(string: api)!, parameter: nil, header: FBHeader.headerToken()) { (response, message, errorCode) in
//            if response != nil{
//                let resJson = JSON.init(response!)
//                let datas = resJson["data"].array
//
//                var result = [FBUserProfile]() // sua lai sau
//                for data in datas ?? []
//                {
//                    result.append(FBUserProfile.init(json: data))// sua lai sau
//                }
//                if errorCode == SUCCESS_CODE{
//                    block(result,message,SUCCESS_CODE)
//                }
//                else{
//                    block(nil, resJson["message"].string, ERROR_CODE)
//                }
//            }
//            else{
//                block(nil,message,errorCode)
//            }
//        }
//    }
//    func getDraftTestByModule(mid: Int, block: @escaping CompletionBlock) {
//        HDServices.shareInstance.get(URL.init(string: "\(API.getDraftTestByModule)?mid=\(mid)")!, parameter: nil, header: HDHeader.headerToken()) { (response, message, errorCode) in
//            if response != nil {
//                let resJson = JSON.init(response!)
//                let result = DraftExamObj.init(json: resJson["data"])
//                block(result, message, errorCode)
//            } else {
//                block(nil, message, errorCode)
//            }
//        }
//    }
//    func deleteDraft(tid: Int) {
//        HDServices.shareInstance.get(URL.init(string: "\(API.deleteDraftTest)?tid=\(tid)")!, parameter: nil, header: HDHeader.headerToken()) { (_, _, _) in }
//    }
//    
//    func checkResultExam(data: ExamObj?, time: Int, type: TypeCheckResult, block: @escaping CompletionBlock) {
//        var param = [
//            "tid": data?.internalIdentifier ?? -1,
//            "time": time,
//            "type": type.rawValue
//            ] as [String: Any]
//        var dataAnswer = [[String: Any]]()
//        data?.questions?.forEach { (ques) in
//            let item = [
//                "qid": ques.internalIdentifier ?? 0,
//                "rid": ques.getAnswerSelect()
//                ] as [String: Any]
//            dataAnswer.append(item)
//        }
//        param["data"] = dataAnswer
//        self.postWithBody(URL.init(string: API.checkReultTest)!, parameter: param, header: HDHeader.headerTokenJson()) { (response, message, errorCode) in
//            if response != nil {
//                let resJson = JSON.init(response!)
//                let result = ResultExamObj.init(json: resJson["data"])
//                block(result, message, errorCode)
//            } else {
//                block(nil, message, errorCode)
//            }
//        }
//    }
//    func checkResultExamOjt(data: ExamObj?, time: Int, block: @escaping CompletionBlock) {
//        var param = [
//            "tid": data?.internalIdentifier ?? -1,
//            "time": time,
//            "type": 2
//            ] as [String: Any]
//        var dataAnswer = [[String: Any]]()
//        data?.questions?.forEach { (ques) in
//            let item = [
//                "qid": ques.internalIdentifier ?? 0,
//                "rid": ques.getAnswerSelect()
//                ] as [String: Any]
//            dataAnswer.append(item)
//        }
//        param["data"] = dataAnswer
//        self.postWithBody(URL.init(string: API.saveScoresElearningTest)!, parameter: param, header: HDHeader.headerTokenJson()) { (response, message, errorCode) in
//            if response != nil {
//                let resJson = JSON.init(response!)
//                let result = ResultExamObj.init(json: resJson["data"])
//                block(result, message, errorCode)
//            } else {
//                block(nil, message, errorCode)
//            }
//        }
//    }
//    
//    /// save score ojt
//    func saveScoresElearningTest(data: ExamObj?, time: Int, type: TypeCheckResult, block: @escaping CompletionBlock) {
//        var param = [
//            "id": data?.internalIdentifier ?? -1,
//            "time": time,
//            "type": type.rawValue
//            ] as [String: Any]
//        var dataAnswer = [[String: Any]]()
//        data?.questions?.forEach { (ques) in
//            let item = [
//                "id": ques.internalIdentifier ?? 0,
//                "anwser": "[\(ques.getAnswerSelect())]"
//                ] as [String: Any]
//            dataAnswer.append(item)
//        }
//        param["question"] = dataAnswer
//        print(param)
//        self.postWithBody(URL.init(string: API.saveScoresElearningTest)!, parameter: param, header: HDHeader.headerTokenJson(), block: block)
//    }
//
//    func getListElearningTestOjt(year: Int? = nil, month: Int? = nil,page: Int?, block:@escaping CompletionPageBlock) {
//        let yearStr = year == nil ? "" : "\(year ?? 0)"
//        let monthStr = year == nil ? "" : "\(month ?? 0)"
//        let page = page == nil ? "" : "\(page ?? 0)"
//        let api = "\(API.getListElearningTestOjt)?year=\(yearStr)&month=\(monthStr)&page=\(page)"
//        self.get(URL.init(string: api)!, parameter: nil, header: HDHeader.headerToken()) { (response, message, errorCode) in
//            if response != nil{
//                let resJson = JSON.init(response!)
//                if errorCode == SUCCESS_CODE{
//                    var arrResult = [HDListOJT]()
//                    let arrJson = resJson["data"]["response"].array
//                    if arrJson?.count ?? 0 > 0{
//                        for result in arrJson!{
//                            arrResult.append(HDListOJT.init(json: result))
//                        }
//                    }
//                    block(arrResult,message,SUCCESS_CODE,resJson["data"]["page"]["nextPage"].bool ?? false)
//                }
//                else{
//                    block(nil, resJson["message"].string, ERROR_CODE,nil)
//                }
//            }
//            else{
//                block(nil,message,errorCode,nil)
//            }
//        }
//    }
//    
//    func getListHistoryElearningTest(year: Int?, month:Int?,page:Int?, block:@escaping CompletionPageBlock){
//        let yearStr = year == nil ? "" : "\(year ?? 0)"
//        let monthStr = year == nil ? "" : "\(month ?? 0)"
//        let page = page == nil ? "" : "\(page ?? 0)"
//        let api = "\(API.getListHistoryElearningTest)?year=\(yearStr)&month=\(monthStr)&page=\(page)"
//        self.get(URL.init(string: api)!, parameter: nil, header: HDHeader.headerToken()) { (response, message, errorCode) in
//            if response != nil{
//                let resJson = JSON.init(response!)
//                if errorCode == SUCCESS_CODE{
//                    var arrResult = [HDListHistoryElearningTestResult]()
//                    let arrJson = resJson["data"]["response"].array
//                    if arrJson?.count ?? 0 > 0{
//                        for result in arrJson!{
//                            arrResult.append(HDListHistoryElearningTestResult.init(json: result))
//                        }
//                    }
//                    block(arrResult,message,SUCCESS_CODE,resJson["data"]["page"]["nextPage"].bool ?? false)
//                }
//                else{
//                    block(nil, resJson["message"].string, ERROR_CODE,nil)
//                }
//            }
//            else{
//                block(nil,message,errorCode,nil)
//            }
//        }
//    }
}
class FBHeader {
    class func headerTokenForUpload()-> HTTPHeaders{
        return ["Authorization":FBDataCenter.sharedInstance.token,
                "Content-type": "multipart/form-data"]
    }
    class func headerTokenTitle()-> HTTPHeaders{
        return ["Authorization":FBDataCenter.sharedInstance.token,
                "Content-Type":"application/x-www-form-urlencoded"]
    }
    class  func headerToken() -> HTTPHeaders{
        return ["Authorization":FBDataCenter.sharedInstance.token]
    }
    class func headerTokenJson() -> HTTPHeaders {
        return ["Authorization": FBDataCenter.sharedInstance.token,
                "Content-type": "application/json"]
    }
    class func  headerForLogin() -> HTTPHeaders  {
        return [
            "Content-Type" : "application/x-www-form-urlencoded",
            "deviceid":(UIDevice.current.identifierForVendor?.uuidString)!]
    }
    
}
