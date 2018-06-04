//
//  Utils.swift
//  tuniservice
//
//  Created by MacBook Pro on 10/08/2017.
//  Copyright © 2017 tuniservice. All rights reserved.
//

import UIKit
import TTGSnackbar
import UserNotifications

class Utils: NSObject {
    
    
    //
    /*
     import KeychainSwift
                    -- Keychain --
     
     Stores sensitive data such as passwords  , certificates , tokens ect ..
     Is implemented as SQLite Database
     Application can Accesss only items in its keychain-access-group
     Can be arbitarily read on a jailbroken device using keychain-dumper
     
     */
    
    /*
                  -- Application SandBox --
     
     */
    static let preferences =  UserDefaults.standard

    
    public static func snackBar ( message : String ){
        let snackbar: TTGSnackbar = TTGSnackbar.init(message: message, duration:  .middle)
        
        // Change the content padding inset
        snackbar.contentInset = UIEdgeInsets.init(top: 8, left: 8, bottom: 8, right: 8)
        
        // Change margin
        snackbar.leftMargin = 8
        snackbar.rightMargin = 8
        
        // Change message text font and color
        snackbar.messageTextColor = UIColor.white
        snackbar.messageTextFont = UIFont.boldSystemFont(ofSize: 18)
        
        // Change snackbar background color
        snackbar.backgroundColor = UIColor(hexString: "#1D7CE3")
        snackbar.backgroundColor?.withAlphaComponent(0.4)
        // Change animation duration
        snackbar.animationDuration = 0.5
        
        // Animation type
        snackbar.animationType = .slideFromBottomBackToBottom
        
        snackbar.show()
        
    }
    public static func snackBarLong ( message : String ){
        let snackbar: TTGSnackbar = TTGSnackbar.init(message: message, duration:  .long)
        
        // Change the content padding inset
        snackbar.contentInset = UIEdgeInsets.init(top: 8, left: 8, bottom: 8, right: 8)
        
        // Change margin
        snackbar.leftMargin = 8
        snackbar.rightMargin = 8
        
        // Change message text font and color
        snackbar.messageTextColor = UIColor.white
        snackbar.messageTextFont = UIFont.boldSystemFont(ofSize: 18)
        
        // Change snackbar background color
        snackbar.backgroundColor = UIColor(hexString: "#1D7CE3")
        snackbar.backgroundColor?.withAlphaComponent(0.4)
        // Change animation duration
        snackbar.animationDuration = 0.5
        
        // Animation type
        snackbar.animationType = .slideFromBottomBackToBottom
        
        snackbar.show()
        
    }
    
    public static func  isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    
   /* public static func userDataExist() -> Bool{
       
        
        let email : String? = preferences.string(forKey: "currentUserEmail")
        print("userDataExist ",email)
        
        return !( ( email == nil ) || (email == "" ) )
    }*/
    
    
   /* public static func saveUserData( user : User , type : typeAccount) -> Bool{
        preferences.set(user.email, forKey: "currentUserEmail")
        preferences.set(user.first_name, forKey: "currentUserFirstName")
        preferences.set(user.last_name, forKey: "currentUserLastName")
        preferences.set(user.id, forKey: "currentUserId")
        preferences.set(user.password, forKey: "currentUserPassword")
        preferences.set(user.profilePictureUrl, forKey: "currentUserProfilePictureUrl")
        preferences.set(user.token, forKey: "currentUserToken")
        
        if ( type == .Normal  ){
            preferences.set("Normal", forKey: "typeAccount")

        }else if ( type == .Facebook ) {
            preferences.set("Facebook" , forKey : "typeAccount")
        } else {
            preferences.set("Google" , forKey : "typeAccount")
        }
        
        let didSave = preferences.synchronize()
        return didSave
     }
    
    public static func readUserData( from : String)  -> User{
        print("from from ",from)
        let preferences =  UserDefaults.standard
        
        let user : User = User()
   
        user.email = preferences.string(forKey: "currentUserEmail")!
        user.first_name = preferences.string(forKey: "currentUserFirstName")!
      
        user.last_name = preferences.string(forKey: "currentUserLastName")!
        user.id = preferences.string(forKey: "currentUserId")!
        
        user.password = preferences.string(forKey: "currentUserPassword")!
        user.profilePictureUrl = preferences.string(forKey: "currentUserProfilePictureUrl")!
        
        user.token = preferences.string(forKey: "currentUserToken")!

        let type = preferences.string(forKey: "typeAccount")!
        if (type == "Facebook" ){
            user.accountType = .Facebook
        }else if (type == "Google"){
            user.accountType = .Google
        }else {
            user.accountType = .Normal
        }
        
        return user
    }
    
    public static func removeUser() -> Bool{
        
        let preferences =  UserDefaults.standard

        preferences.removeObject(forKey: "currentUserEmail")
        preferences.removeObject(forKey: "currentUserFirstName")
        
        
        preferences.removeObject(forKey: "currentUserLastName")
        preferences.removeObject(forKey: "currentUserId")
        
        
        preferences.removeObject(forKey: "currentUserPassword")
        preferences.removeObject(forKey: "currentUserProfilePictureUrl")
        
        preferences.removeObject(forKey: "currentUserToken")

        preferences.removeObject(forKey: "typeAccount")

        preferences.synchronize()
        return preferences.synchronize()
    }
    */
    
    
}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.characters.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

extension CAShapeLayer {
    func drawRoundedRect(rect: CGRect, andColor color: UIColor, filled: Bool) {
        fillColor = filled ? color.cgColor : UIColor.white.cgColor
        strokeColor = color.cgColor
        path = UIBezierPath(roundedRect: rect, cornerRadius: 7).cgPath
    }
}

private var handle: UInt8 = 0;

extension UIBarButtonItem {
    private var badgeLayer: CAShapeLayer? {
        if let b: AnyObject = objc_getAssociatedObject(self, &handle) as AnyObject? {
            return b as? CAShapeLayer
        } else {
            return nil
        }
    }
    
    func setBadge(text: String?, withOffsetFromTopRight offset: CGPoint = CGPoint.zero, andColor color:UIColor = UIColor.red, andFilled filled: Bool = true, andFontSize fontSize: CGFloat = 11)
    {
        badgeLayer?.removeFromSuperlayer()
        
        if (text == nil || text == "") {
            return
        }
        
        addBadge(text: text!, withOffset: offset, andColor: color, andFilled: filled)
    }
    
    private func addBadge(text: String, withOffset offset: CGPoint = CGPoint.zero, andColor color: UIColor = UIColor.red, andFilled filled: Bool = true, andFontSize fontSize: CGFloat = 11)
    {
        guard let view = self.value(forKey: "view") as? UIView else { return }
        
        var font = UIFont.systemFont(ofSize: fontSize)
        
        if #available(iOS 9.0, *) {
            font = UIFont.monospacedDigitSystemFont(ofSize: fontSize, weight: UIFontWeightRegular)
        }
        
        let badgeSize = text.size(attributes: [NSFontAttributeName: font])
        
        // Initialize Badge
        let badge = CAShapeLayer()
        
        let height = badgeSize.height;
        var width = badgeSize.width + 2 /* padding */
        
        //make sure we have at least a circle
        if (width < height) {
            width = height
        }
        
        //x position is offset from right-hand side
        let x = view.frame.width - width + offset.x
        
        let badgeFrame = CGRect(origin: CGPoint(x: x, y: offset.y), size: CGSize(width: width, height: height))
        
        badge.drawRoundedRect(rect: badgeFrame, andColor: color, filled: filled)
        view.layer.addSublayer(badge)
        
        // Initialiaze Badge's label
        let label = CATextLayer()
        label.string = text
        label.alignmentMode = kCAAlignmentCenter
        label.font = font
        label.fontSize = font.pointSize
        
        label.frame = badgeFrame
        label.foregroundColor = filled ? UIColor.white.cgColor : color.cgColor
        label.backgroundColor = UIColor.clear.cgColor
        label.contentsScale = UIScreen.main.scale
        badge.addSublayer(label)
        
        // Save Badge as UIBarButtonItem property
        objc_setAssociatedObject(self, &handle, badge, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    private func removeBadge() {
        badgeLayer?.removeFromSuperlayer()
    }
}
extension String {
    
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound - r.lowerBound)
        return self[Range(start ..< end)]
    }
}
extension UIView {
    
    func addShadowView(width:CGFloat=0.2, height:CGFloat=0.2, Opacidade:Float=0.7, maskToBounds:Bool=false, radius:CGFloat=0.5){
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: width, height: height)
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = Opacidade
        self.layer.masksToBounds = maskToBounds
    }
    
}
extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { () -> Void in
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}
extension String {
    var floatValue: Float {
        return (self as NSString).floatValue
    }
}
extension UIView {
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
extension UITableView {
    
    func isLast(for indexPath: IndexPath) -> Bool {
        
        let indexOfLastSection = numberOfSections > 0 ? numberOfSections - 1 : 0
        let indexOfLastRowInLastSection = numberOfRows(inSection: indexOfLastSection) - 1
        
        return indexPath.section == indexOfLastSection && indexPath.row == indexOfLastRowInLastSection
    }
}


class LocalNotification: NSObject, UNUserNotificationCenterDelegate {
    
    class func registerForLocalNotification(on application:UIApplication) {
        if (UIApplication.instancesRespond(to: #selector(UIApplication.registerUserNotificationSettings(_:)))) {
            let notificationCategory:UIMutableUserNotificationCategory = UIMutableUserNotificationCategory()
            notificationCategory.identifier = "NOTIFICATION_CATEGORY"
            
            //registerting for the notification.
            application.registerUserNotificationSettings(UIUserNotificationSettings(types:[.sound, .alert, .badge], categories: nil))
        }
    }
    
    class func dispatchlocalNotification(with title: String, body: String, userInfo: [AnyHashable: Any]? = nil, at date:Date) {
        
        if #available(iOS 10.0, *) {
            
            let center = UNUserNotificationCenter.current()
            let content = UNMutableNotificationContent()
            content.title = title
            content.body = body
            content.categoryIdentifier = "Fechou"
            
            if let info = userInfo {
                content.userInfo = info
            }
            
            content.sound = UNNotificationSound.default()
            
            let comp = Calendar.current.dateComponents([.hour, .minute , .second], from: date)
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: comp, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            
            center.add(request)
            
        } else {
            
            let notification = UILocalNotification()
            notification.fireDate = date
            notification.alertTitle = title
            notification.alertBody = body
            
            if let info = userInfo {
                notification.userInfo = info
            }
            
            notification.soundName = UILocalNotificationDefaultSoundName
            UIApplication.shared.scheduleLocalNotification(notification)
            
        }
        
        print("WILL DISPATCH LOCAL NOTIFICATION AT ", date)
        
    }
}
extension Date {
    func addedBy(minutes:Int) -> Date {
        return Calendar.current.date(byAdding: .second, value: minutes, to: self)!
    }
}
extension UIView {
    
    
    func fadeIn(duration: TimeInterval = 1.0, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: completion)  }
    
    func fadeOut(duration: TimeInterval = 1.0, delay: TimeInterval = 3.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.alpha = 0.0
        }, completion: completion)
    }
    
}

public extension UIDevice {
    
    var modelName: String {
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            let DEVICE_IS_SIMULATOR = true
        #else
            let DEVICE_IS_SIMULATOR = false
        #endif
        
        var machineString : String = ""
        
        if DEVICE_IS_SIMULATOR == true
        {
            
            if let dir = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] {
                machineString = dir
            }
        }
        else {
            var systemInfo = utsname()
            uname(&systemInfo)
            let machineMirror = Mirror(reflecting: systemInfo.machine)
            machineString = machineMirror.children.reduce("") { identifier, element in
                guard let value = element.value as? Int8, value != 0 else { return identifier }
                return identifier + String(UnicodeScalar(UInt8(value)))
            }
        }
        switch machineString {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,7", "iPad6,8":                      return "iPad Pro"
        case "AppleTV5,3":                              return "Apple TV"
        default:                                        return machineString
        }
    }
}
