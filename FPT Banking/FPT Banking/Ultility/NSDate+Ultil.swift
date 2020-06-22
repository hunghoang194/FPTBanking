//
//  NSDate+Ultil.swift
//  FPT Banking
//
//  Created by Hung Hoang on 6/22/20.
//  Copyright © 2020 hưng hoàng. All rights reserved.
//

import Foundation
import SwiftyJSON

extension NSDate {
    
    convenience init?(json: JSON) {
        if let dateString = json["date"].string, let timeZoneName = json["timezone"].string {
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSSSS"
            guard let timeZone = NSTimeZone(name: timeZoneName) else { return nil }
            df.timeZone = TimeZone(secondsFromGMT: timeZone.secondsFromGMT)
            if let date_ = df.date(from: dateString) {
                self.init(timeInterval: 0, since: date_)
            } else {
                self.init(timeInterval: 0, since: NSDate.distantPast)
            }
        } else {
            self.init(timeInterval: 0, since: NSDate.distantPast)
        }
    }
}

extension Date {
    func string() -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatterGet.string(from: self)
    }
    
    func getTextFromDate(_ formatDate: String?) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.local
        if isEmptyString(textCheck: formatDate) {
            dateFormatter.dateFormat = "dd-MM-yyyy"
        } else {
            dateFormatter.dateFormat = formatDate
        }
        let stringDate: String = dateFormatter.string(from: self as Date)
        return stringDate
    }

    func getDateFromText(_ formatDate: String?, _ stringDate: String?) -> Date? {
        let dateFormatter: DateFormatter = DateFormatter()
        if isEmptyString(textCheck: formatDate) {
            dateFormatter.dateFormat = "dd/MM/yyyy"
        } else {
            dateFormatter.dateFormat = formatDate
        }
        var date: Date? = Date.init()
        date = dateFormatter.date(from: stringDate ?? "")

        return date
    }

    init?(_ formatDate: String?, _ stringDate: String?) {
        self.init()
        let dateFormatter: DateFormatter = DateFormatter()

        if isEmptyString(textCheck: formatDate) {
            dateFormatter.dateFormat = "dd/MM/yyyy"
        } else {
            dateFormatter.dateFormat = formatDate
        }

        if let date = dateFormatter.date(from: stringDate ?? "") {
            self = date
        } else {
            return nil
        }
    }
    func isEmptyString(textCheck: String?) -> Bool {
        var check: Bool? = false
        if textCheck == nil {
            return true
        }
        if (textCheck? .isKind(of: NSNull.classForCoder()))! || textCheck?.count == 0 {
            check = true
        }
        return check!
    }
}

extension TimeInterval {
    func getString() -> String {
        let hours = Int(self) / 3600
        let minutes = Int(self) / 60 % 60
        let seconds = Int(self) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
}

