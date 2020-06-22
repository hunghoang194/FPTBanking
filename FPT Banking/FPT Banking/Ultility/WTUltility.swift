//
//  WTUtilitys.swift
//  HVN MACs
//
//  Created by Hoang Mai Long on 4/17/17.
//  Copyright © 2017 SUSOFT. All rights reserved.
//

import UIKit
import Security
import AVKit
import CommonCrypto
import RNCryptor
//import QBImagePickerController
let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

let IS_ENCRYPT = true
let MASTER_KEY = "*F-JaNdRgUkXn2r5u8x/A?D(G+KbPeSh"

//let passwordKey = "keyPassword"
//let accountKey = "keyAccount"



public class WTUtilitys:NSObject {
    class func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    class func isEmptyString(textCheck:String?) -> Bool {
        var check:Bool? = false
        if textCheck == nil {
            return true
        }
        if ((textCheck? .isKind(of: NSNull.classForCoder()))! || textCheck?.utf8CString.count == 0)
        {
            check = true
        }
        return check!
    }
    class func blurView(_ view: UIView, with alpha: CGFloat) {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.alpha = alpha
        blurEffectView.layer.cornerRadius = 6.0
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        
    }
    let IS_IPHONE_5:Bool = {
        return (SCREEN_HEIGHT == 568.0)
    }()
    let IS_IPHONE_6:Bool = {
        return (SCREEN_HEIGHT == 667.0)
    }()
    let IS_IPHONE_6P:Bool = {
        return (SCREEN_HEIGHT == 736.0)
    }()
    class func getDefaultStringPriceFromString(originString:AnyObject?)->String {
        if originString == nil || (originString is NSNull) || (originString?.isKind(of: NSNull.classForCoder()))!
        {
            return "0"
        }
        else
        {
            if originString is String {
                if (originString as! String).isEmpty {
                    return "0"
                }
                let formatter = NumberFormatter()
                formatter.numberStyle = NumberFormatter.Style.decimal
                formatter.locale = NSLocale(localeIdentifier: "vi_VN") as Locale?
                let strOrigin = originString?.replacingOccurrences(of: ".", with: "")
                let textAsFloat = Float(strOrigin!)
                let strReturn = formatter.string(from:NSNumber(value:textAsFloat!))
                return strReturn!
            }
            else
            {
                let formatter = NumberFormatter()
                formatter.numberStyle = NumberFormatter.Style.decimal
                formatter.locale = NSLocale(localeIdentifier: "vi_VN") as Locale?
                let strReturn = formatter.string(from:NSNumber(value:originString as! Float))
                return strReturn!
            }
        }
    }
    class func getDefaultStringPrice(originString:AnyObject?)->String {
        if originString == nil || (originString is NSNull) || (originString?.isKind(of: NSNull.classForCoder()))!
        {
            return "0"
        }
        else
        {
            if originString is String {
                return originString as! String
            }
            else
            {
                let formatter = NumberFormatter()
                formatter.numberStyle = NumberFormatter.Style.decimal
                formatter.locale = NSLocale(localeIdentifier: "vi_VN") as Locale?
                let strReturn = formatter.string(from:NSNumber(value:originString as! Float))
                return strReturn!
            }
        }
    }
    class func encryptAES256(_ string: String) -> String? {
        if IS_ENCRYPT {
            return WTUtilitys.encrypt(plainText: string, password: MASTER_KEY)
        }
        else
        {
            return string
        }
    }
    class func encrypt(plainText : String, password: String) -> String {
        let data: Data = plainText.data(using: .utf8)!
        let encryptedData = RNCryptor.encrypt(data: data, withPassword: password)
        let encryptedString : String = encryptedData.base64EncodedString() // getting base64encoded string of encrypted data.
        return encryptedString
    }
    
    class func decrypt(encryptedText : String, password: String) -> String {
        do  {
            let data: Data = Data(base64Encoded: encryptedText)! // Just get data from encrypted base64Encoded string.
            let decryptedData = try RNCryptor.decrypt(data: data, withPassword: password)
            let decryptedString = String(data: decryptedData, encoding: .utf8) // Getting original string, using same .utf8 encoding option,which we used for encryption.
            return decryptedString ?? ""
        }
        catch {
            return "FAILED"
        }
    }
    
    class func priceToString(price: Float?) -> String{
        if price == nil
        {
            return ""
        }
        else
        {
            let formatter = NumberFormatter()
            let strReturn = formatter.string(from:NSNumber(value:price!))
            return strReturn!
        }
    }
    
    //
    class func calculateBadgeValue(withNumber numberOfNoti: Int) -> String {
        if numberOfNoti > 99 {
            return "\(99)+"
        }
        return "\(numberOfNoti)"
    }
    
    class func getDefaultString(originString:AnyObject?)->String {
        if originString == nil || (originString is NSNull) || (originString?.isKind(of: NSNull.classForCoder()))!
        {
            return ""
        }
        else
        {
            if originString is String {
                return originString as! String
            }
            else
            {
                let str = String.init(format:"%0.0f",(originString as? Float) ?? 0)
                return str
            }
        }
    }
    class func convertDateFormatter() -> String
    {
        let date = NSDate()
        let calendar = NSCalendar.current
        let year = calendar.component(.year, from: date as Date)
        let month = calendar.component(.month, from: date as Date)
        let day = calendar.component(.day, from: date as Date)
        let hour = calendar.component(.hour, from: date as Date)
        let minute = calendar.component(.minute, from: date as Date)
        let second = calendar.component(.second, from: date as Date)
        return String(format:"%d%d%d%d%d%d", day,month,year,hour,minute,second)
    }
    class func getCurrentDateString()->String
    {
        let date = NSDate()
        let calendar = NSCalendar.current
        let year = calendar.component(.year, from: date as Date)
        let month = calendar.component(.month, from: date as Date)
        let day = calendar.component(.day, from: date as Date)
        return String(format:"Ngày %d tháng %d năm %d", day,month,year)
    }
    class func getFontRegularWithSize(size:CGFloat) ->UIFont
    {
        return UIFont.init(name: "Helvetica", size: size)!
    }
    class func getFontWithSize(size:CGFloat) ->UIFont
    {
        return UIFont.init(name: "Helvetica Light", size: size)!
    }
    class func getDateFromText(_ FormatDate:String?,_ stringDate:String?)->Date?
    {
        let dateFormatter:DateFormatter =  DateFormatter()
        if WTUtilitys.isEmptyString(textCheck: FormatDate)
        {
            dateFormatter.dateFormat = "dd/MM/yyyy"
        }else
        {
            dateFormatter.dateFormat = FormatDate
        }
        var date:Date?  = Date.init()
        do {
            try date = dateFormatter.date(from: stringDate ?? "")
        } catch  {
            
        }
        return date
    }
    class func getDateFromTextApi(_ FormatDate:String?,_ stringDate:String?)->Date?
    {
        let dateFormatter:DateFormatter =  DateFormatter()
        if WTUtilitys.isEmptyString(textCheck: FormatDate)
        {
            dateFormatter.dateFormat = "yyy-MM-dd HH:mm:ss"
        }else
        {
            dateFormatter.dateFormat = FormatDate
        }
        var date:Date?  = Date.init()
        do {
            try date = dateFormatter.date(from: stringDate!)
        } catch  {
            
        }
        return date
    }
    class func getTypeNameFormArrayType(arrData:NSMutableArray,index:Int)->String
    {
        if arrData.count > index {
            return arrData[index] as! String
        }
        return ""
    }
    class func getTimeWithType(arrData:NSMutableArray,index:Int)->Float
    {
        var timeDay:Float = 0
        if arrData.count > index {
            let textShow = arrData[index] as! String
            if textShow == "am" || textShow == "pm" {
                timeDay = 0.5
            }
            else
                if textShow == "fullday" {
                    timeDay = 1
            }
        }
        return timeDay
    }
    class func getTextFullFromDate(_ date:Date)->String?
    {
        
        var calendar = NSCalendar.current
        calendar.timeZone = NSTimeZone.local
        let year = calendar.component(.year, from: date as Date)
        let month = calendar.component(.month, from: date as Date)
        let day = calendar.component(.day, from: date as Date)
        let dateFormatter: DateFormatter = DateFormatter()
        let months = dateFormatter.shortMonthSymbols
        let monthSymbol = months?[month-1]
        let stringDate: String = String.init(format:"%d-%@-%d",day,monthSymbol!,year)
        return stringDate
    }
    class func getTextFullForReportFromDate(_ date:Date)->String?
    {
        
        var calendar = NSCalendar.current
        calendar.timeZone = NSTimeZone.local
        let year = calendar.component(.year, from: date as Date)
        let month = calendar.component(.month, from: date as Date)
        let day = calendar.component(.day, from: date as Date)
        let hour = calendar.component(.hour, from: date as Date)
        let minute = calendar.component(.minute, from: date as Date)
        let second = calendar.component(.second, from: date as Date)
        let dateFormatter: DateFormatter = DateFormatter()
        let months = dateFormatter.shortMonthSymbols
        let monthSymbol = months?[month-1]
        let stringDate: String = String.init(format:"%d:%d:%d %d-%@-%d",hour,minute,second,day,monthSymbol!,year)
        return stringDate
    }
    
    class func getTextFromDate(_ date:Date)->String?
    {
        
        var calendar = NSCalendar.current
        calendar.timeZone = NSTimeZone.local
        let year = calendar.component(.year, from: date as Date)
        let month = calendar.component(.month, from: date as Date)
        let day = calendar.component(.day, from: date as Date)
        let dateFormatter: DateFormatter = DateFormatter()
        let months = dateFormatter.shortMonthSymbols
        let monthSymbol = months?[month-1]
        let stringDate: String = String.init(format:"%d-%@",day,monthSymbol!)
        return stringDate
    }
    class func getDaysInThisWeek(fromDay:Date) -> [Date]? {
        // create calendar
        let timezoneLK = NSTimeZone(forSecondsFromGMT: 25200)
        let calendar = NSCalendar(identifier: NSCalendar.Identifier.gregorian)!
        calendar.timeZone = timezoneLK as TimeZone
        // today's date
        let today = fromDay
        let todayComponent = calendar.components([.day, .month, .year], from: today as Date)
        
        // range of dates in this week
        let thisWeekDateRange = calendar.range(of: .day, in:.weekOfMonth, for:today as Date)
        
        // date interval from today to beginning of week
        _ = thisWeekDateRange.location - todayComponent.day!
        
        var cal = Calendar.current
        cal.timeZone = timezoneLK as TimeZone
        var component = cal.dateComponents([.yearForWeekOfYear, .weekOfYear], from: fromDay)
        component.to12am()
        cal.firstWeekday =  0
        let beginningOfWeek =  cal.date(from: component)!
        
        // date for beginning day of this week, ie. this week's Sunday's date
        //let beginningOfWeek = calendar.date(byAdding: .day, value: dayInterval, to: today as Date, options: .matchNextTime)
        
        var formattedDays: [Date] = []
        
        for i in 0 ..< 7 {
            let date = calendar.date(byAdding: .day, value: i, to: beginningOfWeek, options: .matchNextTime)!
            formattedDays.append(date)
        }
        return formattedDays
    }
    class func getTextFromDate(_ FormatDate:String?,_ date:Date?)->String?
    {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.local
        if WTUtilitys.isEmptyString(textCheck: FormatDate)
        {
            dateFormatter.dateFormat = "dd/MM/YYYY"
        }else
        {
            dateFormatter.dateFormat = FormatDate
        }
        if date == nil
        {
            return ""
        }
        let stringDate: String = dateFormatter.string(from: date! as Date)
        return stringDate
    }
    class func getTextFromDateForAPi(_ FormatDate:String?,_ date:Date?)->String?
    {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.local
        if WTUtilitys.isEmptyString(textCheck: FormatDate)
        {
            dateFormatter.dateFormat = "dd/MM/yyyy"
        }else
        {
            dateFormatter.dateFormat = FormatDate
        }
        if date == nil
        {
            return ""
        }
        let stringDate: String = dateFormatter.string(from: date! as Date)
        return stringDate
    }
    class func isDifferentVersion() -> Bool {
        let userDefault = UserDefaults.standard
        let versionSave = userDefault.string(forKey: "version")
        let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        if versionSave != version {
            saveVersionAppOpen(version)
            return true
        }
        return false
    }
    class func getSystemVersion() -> String
    {
        let systemVersion = UIDevice.current.systemVersion
        if WTUtilitys.isEmptyString(textCheck: systemVersion) {
            return ""
        }
        else
        {
            return systemVersion
        }
    }
    class func getVersionApp ()->String
    {
        let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        if WTUtilitys.isEmptyString(textCheck: version) {
            return ""
        }
        else
        {
            return version
        }
    }
    class func saveVersionAppOpen(_ version:String) {
        let userDefault = UserDefaults.standard
        userDefault.set(version, forKey: "version")
        userDefault.synchronize()
    }
    class func setStrikeText(_ label:UILabel?) ->Void
    {
        if ((label == nil) || WTUtilitys.isEmptyString(textCheck: label?.text))
        {
            label?.text = ""
        }
        let attributes:Dictionary = [NSAttributedString.Key.strikethroughStyle:NSNumber.init(value: NSUnderlineStyle.single.rawValue),NSAttributedString.Key.strikethroughColor:UIColor.red]
        let attributedString:NSAttributedString  = NSAttributedString.init(string: (label?.text)!, attributes: attributes)
        label?.attributedText = attributedString
    }
    class func pushViewWithAnimation(_ mainview: UIViewController, navigation: UINavigationController) {
        let Storyboard = UIStoryboard(name: "Main", bundle: nil)
        let Mainview = Storyboard.instantiateViewController(withIdentifier: String(describing: type(of: mainview)))
        navigation.pushViewController(Mainview, animated: true)
    }
    class func animationNextView(view: UIView){
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        view.window!.layer.add(transition, forKey: kCATransition)
    }
    class func heightForView(text:String, width:CGFloat) -> CGFloat{
        let font = UIFont(name: "Helvetica Light", size: 14.0)
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0,width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        
        label.sizeToFit()
        return label.frame.height
    }

    class func save(service: NSString, data: NSString) {
        let dataFromString: NSData = data.data(using: String.Encoding.utf8.rawValue, allowLossyConversion: false)! as NSData
        
        // Instantiate a new default keychain query
        let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, service, userAccount, dataFromString], forKeys: [kSecClassValue, kSecAttrServiceValue, kSecAttrAccountValue, kSecValueDataValue])
        
        // Delete any existing items
        SecItemDelete(keychainQuery as CFDictionary)
        
        // Add the new keychain item
        SecItemAdd(keychainQuery as CFDictionary, nil)
    }
    class func isIpad() -> Bool
    {
        if ( UIDevice.current.model.range(of: "iPad") != nil){
            return true
        } else {
            return false
        }
    }
    class func load(service: NSString) -> NSString? {
        // Instantiate a new default keychain query
        // Tell the query to return a result
        // Limit our results to one item
        let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, service, userAccount, kCFBooleanTrue, kSecMatchLimitOneValue], forKeys: [kSecClassValue, kSecAttrServiceValue, kSecAttrAccountValue, kSecReturnDataValue, kSecMatchLimitValue])
        
        var dataTypeRef :AnyObject?
        
        // Search for the keychain items
        let status: OSStatus = SecItemCopyMatching(keychainQuery, &dataTypeRef)
        var contentsOfKeychain: NSString? = ""
        
        if status == errSecSuccess {
            if let retrievedData = dataTypeRef as? NSData {
                contentsOfKeychain = NSString(data: retrievedData as Data, encoding: String.Encoding.utf8.rawValue)
            }
        } else {
            print("Nothing was retrieved from the keychain. Status code \(status)")
        }
        
        return contentsOfKeychain
    }
    //MARK : FONT
    //IMAGE
    class func imageFromText(text: String,size: CGSize) -> UIImage {
        // Make a copy of the textView first so that it can be resized
        // without affecting the original.
        let textViewCopy = UITextView(frame: CGRect.init(x: 0, y: 0, width: size.width, height: size.height))
        // resize if the contentView is larger than the frame
        if textViewCopy.contentSize.height > textViewCopy.frame.height {
            textViewCopy.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        // draw the text view to an image
        UIGraphicsBeginImageContextWithOptions(textViewCopy.bounds.size, false, UIScreen.main.scale)
        textViewCopy.drawHierarchy(in: textViewCopy.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        return image!
    }
    class func imagesFromHTMLString(_ htmlString: String) -> [String] {
        let htmlNSString = htmlString as NSString;
        var images: [String] = Array();
        
        do {
            let regex = try NSRegularExpression(pattern: "(https?)\\S*(png|jpg|jpeg|gif)", options: [NSRegularExpression.Options.caseInsensitive])
            
            regex.enumerateMatches(in: htmlString, options: [NSRegularExpression.MatchingOptions.reportProgress], range: NSMakeRange(0, htmlString.utf8CString.count)) { (result, flags, stop) -> Void in
                if let range = result?.range {
                    images.append(htmlNSString.substring(with: range))  //because Swift ranges are still completely ridiculous
                }
            }
        }
            
        catch {
            
        }
        
        return images;
    }
    class func dropShadow(view:UIView?){
        view?.setShadowColorForLayoutView(nameColor: ColorName.ShadowColor)
        view?.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        view?.layer.shadowRadius = 10.0
        view?.layer.shadowOpacity = 0.4
        //        view?.layer.cornerRadius = 10.0
    }
    class func getDayOfWeekVietnameseName(index:Int) -> String {
        var str = ""
        let listArray:[String] = ["thứ 2","thứ 3","thứ 4","thứ 5","thứ 6","thứ 7","chủ nhật"]
        if index < listArray.count {
            str = listArray[index]
        }
        return str
    }
    class func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    class func loadImage(filePath: String) -> UIImage? {
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = directoryURL.appendingPathComponent(filePath)
        do {
            let imageData = try Data(contentsOf: fileURL)
            return UIImage(data: imageData)
        } catch {
            print("Error loading image : \(error)")
        }
        return nil
    }
    class func urlVideoWithPath(filePath: String) -> URL{
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return directoryURL.appendingPathComponent(filePath)
    }
    class func loadAllFileWith(nameCategory:String) -> [URL]?{
        let fileManager = FileManager.default
        var documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        documentsURL = documentsURL.appendingPathComponent(nameCategory)
        do {
            let fileURLs = try fileManager.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
            return fileURLs
            // process files
        } catch {
            print("Error while enumerating files : \(error.localizedDescription)")
        }
        return nil
    }
    class func jsonParser(parameters:Any) -> String{
        do{
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions.prettyPrinted)
            var JSONString = ""
            JSONString = String(data: jsonData, encoding: String.Encoding.utf8)!
            return JSONString
        }
        catch{
            return ""
        }
    }

    class func getThumbnailImage(forUrl url: URL) -> UIImage? {
        let asset: AVAsset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        
        do {
            let thumbnailImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 60) , actualTime: nil)
            return UIImage(cgImage: thumbnailImage)
        } catch let error {
            print(error)
        }
        
        return nil
    }
}
extension UIView {
    class func fromNib<T : UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}
extension String {
    var boolValue: Bool {
        return NSString(string: self).boolValue
    }
}
internal extension DateComponents {
    mutating func to12am() {
        self.hour = 0
        self.minute = 0
        self.second = 0
    }
}
extension NSMutableArray {
    func shuffle() {
        if count < 2 { return }
        for i in 0..<(count - 1) {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            swap(&self[i], &self[j])
        }
    }
}
extension Date {
    func dayNumberOfWeek() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday
    }
}
extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}

struct AppUtility {
    
    
    /// OPTIONAL Added method to adjust lock and rotate to the desired orientation
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation:UIInterfaceOrientation) {
        
        //        self.lockOrientation(orientation)
        
        UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
    }
    
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(hex: String) {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
