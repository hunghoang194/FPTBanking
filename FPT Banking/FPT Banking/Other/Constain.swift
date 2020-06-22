//
//  Constain.swift
//  FPT Banking
//
//  Created by Hung Hoang on 6/22/20.
//  Copyright © 2020 hưng hoàng. All rights reserved.
//

import Foundation
import UIKit
let ERROR_CODE = 1
let SUCCESS_CODE = 0
let TOKEN_EXPIRED_CODE = 2
let LOGOUT_ERROR_CODE = 3
let NEW_VERSION_CODE = 1001
let NAVIGATION_COLOR = UIColor.init(red: 27.0/255.0, green: 31.0/255.0, blue: 37.0/255.0, alpha: 1.0)
let BLACK_COLOR_DEFAULT = UIColor.init(red: 22.0/255.0, green: 25.0/255.0, blue: 30.0/255.0, alpha: 1.0)
let RED_COLOR = UIColor(red:0.93, green:0.11, blue:0.19, alpha:1)
let BKG_GRAY = UIColor.init(red: 229.0/255.0, green: 229.0/255.0, blue: 229.0/255.0, alpha: 1.0)
let DATE_FOMAT_SERVER = "YYYY-MM-dd HH:mm:ss"
let DATE_FOMAT_SHOW = "dd-MMM-YYYY"

extension UserDefaults {
    class func savePassword(_ id:String){
        self.standard.set(id, forKey: KEY.KEY_API.password)
        self.standard.synchronize()
    }
    class func resultPassword() -> String{
        if let id = self.standard.object(forKey: KEY.KEY_API.password) {
            return id as! String
        }
        return ""
    }
    class func saveRememberLogin(_ id:String){
        self.standard.set(id, forKey: KEY.KEY_API.rememberLogin)
        self.standard.synchronize()
    }
}
struct API {
    static let baseUrl = "your base url"


    struct PATH {
        static let login = "auth/login"
        static let logout = "auth/logout"

    }
//    static let exportModuleTable = "\(baseUrl)\(PATH.exportModuleTable)"?
}
struct KEY {
    struct KEY_API {
        static let rememberLogin = "rememberID"
        static let userName = "username"
        static let id = "id"
        static let password = "password"
        static let dealer_id = "dealer_id"
        static let error = "error"
        static let message = "message"
        static let data = "data"
        static let access_token = "access_token"
        
    }
}
extension Date {
    var yesterday: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var tomorrow: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var nextMont:Date{
        return Calendar.current.date(byAdding: .month, value: 1, to: noon)!
    }
    var isLastDayOfMonth: Bool {
        return tomorrow.month != month
    }
}
extension Date
{    
    func dateAt(hours: Int, minutes: Int) -> Date
    {
        let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        
        //get the month/day/year componentsfor today's date.
        
        
        var date_components = calendar.components(
            [NSCalendar.Unit.year,
             NSCalendar.Unit.month,
             NSCalendar.Unit.day],
            from: self)
        
        //Create an NSDate for the specified time today.
        date_components.hour = hours
        date_components.minute = minutes
        date_components.second = 0
        
        let newDate = calendar.date(from: date_components)!
        return newDate
    }
}
