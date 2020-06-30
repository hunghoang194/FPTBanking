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
    func login(username:String,password:String,block:@escaping CompletionBlock){
        let passwordEncode = WTUtilitys.encryptAES256(password) ?? ""
        let param:[String:Any] = ["name":username,
                                  "password":passwordEncode]
        self.post(URL.init(string: API.login)!, parameter: param, header: nil, block: block)
    }
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

struct API {
    static let baseUrl = "your base url"
    struct PATH {
        static let login = "auth/login"
        static let logout = "auth/logout"
    }
    static let login = "\(baseUrl)\(PATH.login)"
    static let logout = "\(baseUrl)\(PATH.logout)"
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
