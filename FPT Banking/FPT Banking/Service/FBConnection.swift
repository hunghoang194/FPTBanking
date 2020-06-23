//
//  FBConnection.swift
//  FPT Banking
//
//  Created by Hung Hoang on 6/23/20.
//  Copyright © 2020 hưng hoàng. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

class FBConnection {
    
    static func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    static func request<T: Mappable>(_ apiRouter: APIRouter,_ returnType: T.Type, completion: @escaping (_ result: T?, _ error: BaseResponseError?) -> Void) {
        if !isConnectedToInternet() {
            // Xử lý khi lỗi kết nối internet
            return
        }
        
        Alamofire.request(apiRouter).responseObject {(response: DataResponse<BaseResponse<T>>) in
            switch response.result {
            case .success:
                if response.response?.statusCode == 200 {
                    if (response.result.value?.isSuccessCode())! {
                        completion((response.result.value?.data)!, nil)
                    } else {
                        let err: BaseResponseError = BaseResponseError.init(NetworkErrorType.API_ERROR, (response.result.value?.code)!, (response.result.value?.message)!)
                        completion(nil, err)
                    }
                } else {
                    let err: BaseResponseError = BaseResponseError.init(NetworkErrorType.HTTP_ERROR, (response.response?.statusCode)!, "Request is error!")
                    completion(nil, err)
                }
                break
                
            case .failure(let error):
                if error is AFError {
                    let err: BaseResponseError = BaseResponseError.init(NetworkErrorType.HTTP_ERROR, error._code, "Request is error!")
                    completion(nil, err)
                }
                
                break
            }
        }
    }
}
