//
//  MyAUserProfile.swift
//  MyApp
//
//  Created by Admin on 4/24/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
class FBUserProfile: NSObject {
        var id: String?
        var name: String?
        var email: String?
        var image: UIImage?
        var imageUrl: String?
        var gender: String?
        var birthday: String?
        var phone:String?
        var password:String?
        var accessToken: String?
//        var arrayCategory = [BVCategoryFavoriteModel]()
        override init() {
            super.init()
        }
        
        required init(_ json: NSDictionary) {
            super.init()
             let data = json["data"] as? [String:Any]
            let userRespon = data!["user"] as? [String:Any]
            if let tokenAccess = data!["token"] as? String {
            self.accessToken = tokenAccess
           }
           if let value = userRespon?["phone"] as? String {
               self.phone = value
           }
           if let value = userRespon?["avatar"] as? String {
               self.imageUrl = value
           }
           if let value = userRespon?["id"] as? String {
              self.id = value
           }
           if let value = userRespon?["birthday"] as? String {
              self.birthday = value
           }
           if let value = userRespon?["email"] as? String {
               self.email = value
           }
           if let value = userRespon?["full_name"] as? String {
              self.name = value
           }

        }
}
