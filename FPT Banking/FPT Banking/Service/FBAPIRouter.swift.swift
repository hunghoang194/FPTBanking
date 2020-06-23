//
//  FBAPIRouter.swift.swift
//  FPT Banking
//
//  Created by Hung Hoang on 6/23/20.
//  Copyright © 2020 hưng hoàng. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    
    // =========== Begin define api ===========
    case login(username: String, password: String)
    case changePassword(pass: String, newPass: String, confirmNewPass: String)
    
    // =========== End define api ===========
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .login, .changePassword:
            return .post
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .login:
            return "user/login"
        case .changePassword:
            return "user/change_password"
        }
    }
    // MARK: - Headers
    private var headers: HTTPHeaders {
        var headers = ["Accept": "application/json"]
        switch self {
        case .login:
            break
        case .changePassword:
            headers["Authorization"] = getAuthorizationHeader()
            break
        }
        
        return headers;
    }

    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .login(let email, let password):
            return [
                "email": email,
                "password": password
            ]
        case .changePassword(let pass, let newPass, let confirmNewPass):
            return[
                "password": pass,
                "new_password": newPass,
                "new_password_confirmation": confirmNewPass
            ]
        }
    }

    // MARK: - URL request
    func asURLRequest() throws -> URLRequest {
        let url = try API.baseUrl.asURL()
        
        // setting path
        var urlRequest: URLRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // setting method
        urlRequest.httpMethod = method.rawValue
        
        // setting header
        for (key, value) in headers {
            urlRequest.addValue(value, forHTTPHeaderField: key)
        }
        
        if let parameters = parameters {
            do {
                urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
            } catch {
                print("Encoding fail")
            }
        }
        
        return urlRequest
    }
    
    private func getAuthorizationHeader() -> String? {
        return "Authorization token"
    }
}
