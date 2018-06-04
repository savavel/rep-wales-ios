//
//  AppDelegate.swift
//  rep
//
//  Created by MacBook Pro on 29/08/2017.
//  Copyright © 2017 wales. All rights reserved.
//

import UIKit
import CoreData
import IQKeyboardManagerSwift
import MapKit
import Firebase
import UserNotifications
import Firebase
import FirebaseInstanceID
import FirebaseMessaging
import UserNotifications
import KeychainSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate ,  CLLocationManagerDelegate,MessagingDelegate ,UNUserNotificationCenterDelegate{
    
    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        debugPrint("--->messaging:\(messaging)")
        debugPrint("--->didRefreshRegistrationToken:\(fcmToken)")
        
        self.keychain.set(fcmToken, forKey: "Token")
    }
    
    static var tabFeedCategoryDrink : [Feed] =  []
    static var tabFeedSearchCategoryDrink : [Feed] =  []
    
    static var tabFeedCategoryTicket : [Feed] =  []
    static var tabFeedSearchCategoryTicket : [Feed] =  []

    static var tabFeedCategoryFood : [Feed] =  []
    static var tabFeedSearchCategoryFood  : [Feed] =  []

    static var tabFeedCategoryPromotion : [Feed] =  []
    static var tabFeedSearchCategoryPromotion  : [Feed] =  []



    var window: UIWindow?
    var locationManager = CLLocationManager()
    let gcmMessageIDKey = "gcm.message_id"


   static  var  clients : [Client] = []
   static var currentUser : User? = nil
   static var currentLocaitonLatitude : Double  = 0
   static var currentLocaitonLongitude : Double  = 0
   let keychain = KeychainSwift()


    
    static func  getAllClients(){
        //CLIENTS_LIST
        print("************************** CLIENTS_LIST")
        self.clients = []
        
        print("Urls.CLIENTS_LIST = \(Urls.CLIENTS_LIST)")
        AFWrapper.requestGETURL(Urls.CLIENTS_LIST, success: { (JSON) in
            print("******************************* SUCCESS")
            
            
            
            for i in JSON.array! {
                
                let client  : Client = Client()
                
                client.name = i["name"].string!
                client.address = i["address"].string!
                client.latitude = i["latitude"].string!
                client.longitude = i["longitude"].string!
               // client.mnemonic = i["mnemonic"].string!
                client.lastname = i["lastname"].string!

                client.facebook = i["facebook"].string!
                client.image = i["image"].string!
                client.instagram = i["instagram"].string!
                client.phone = i["phone"].string!
                client.info = i["description"].string!
                client.physical_address = i["physical_address"].string!
                
                client.times = i["times"].string!
                client.twitter = i["twitter"].string!
                client.website = i["website"].string!
                client.purchases = i["purchases"].string!
                client.categorys = i["categories"].string!
                
                
                
                
                self.clients.append(client)
                
            }
            
        }) { (Error) in
            print("******************************* ERROR")
            print(Error)
            
        }
    }
    


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.sharedManager().enable = true
        UIApplication.shared.statusBarStyle = .lightContent
        
        
        // Firebase base configuration //


        /*************** Current Location **************/
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        /***********************************************/
        
        
        
        // firebase messaging configuration //
        

        Messaging.messaging().delegate = self
        Messaging.messaging().shouldEstablishDirectChannel = true
        debugPrint("###> 1 AppDelegate DidFinishLaunchingWithOptions")
        self.initializeFCM(application)
        let token = InstanceID.instanceID().token()
        debugPrint("GCM TOKEN = \(String(describing: token))")
        
        
        if token != nil {
            
            self.keychain.set(token!, forKey: "Token")

        }
        
        
        
        
        
     
        
        return true
    }
    
    
    
    func initializeFCM(_ application: UIApplication)
    {
        print("initializeFCM")
        //-------------------------------------------------------------------------//
        if #available(iOS 10.0, *) // enable new way for notifications on iOS 10
        {
            let center = UNUserNotificationCenter.current()
            center.delegate = self
            center.requestAuthorization(options: [.badge, .alert , .sound]) { (accepted, error) in
                if !accepted
                {
                    print("Notification access denied.")
                }
                else
                {
                    print("Notification access accepted.")
                    
                    
                    
                

                    
                    DispatchQueue.main.async(execute: {
                        UIApplication.shared.registerForRemoteNotifications()
                    })
                }
            }
        }
        else
        {
            let type: UIUserNotificationType = [UIUserNotificationType.badge, UIUserNotificationType.alert, UIUserNotificationType.sound];
            let setting = UIUserNotificationSettings(types: type, categories: nil);
            UIApplication.shared.registerUserNotificationSettings(setting);
            UIApplication.shared.registerForRemoteNotifications();
        }
        
        FirebaseApp.configure()
        
        Messaging.messaging().shouldEstablishDirectChannel = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.tokenRefreshNotificaiton),
                                               name: NSNotification.Name.InstanceIDTokenRefresh, object: nil)
    }
    
    
    func tokenRefreshNotificaiton(_ notification: Foundation.Notification)
    {
        if let refreshedToken = InstanceID.instanceID().token()
        {
            debugPrint("InstanceID token: \(refreshedToken)")
        }
        connectToFcm()
    }
    func connectToFcm()
    {
        // Won't connect since there is no token
        guard InstanceID.instanceID().token() != nil else
        {
            return;
        }
        // Disconnect previous FCM connection if it exists.
        Messaging.messaging().disconnect()
        Messaging.messaging().connect { (error) in
            if (error != nil) {
                debugPrint("Unable to connect with FCM. \(String(describing: error))")
            } else {
                debugPrint("Connected to FCM.")
            }
        }
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
    }
    
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
        
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    
    @available(iOS 10.0, *)
    public func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage)
    {
        debugPrint("--->messaging:\(messaging)")
        debugPrint("--->didReceive Remote Message:\(remoteMessage.appData)")
        guard let data =
            try? JSONSerialization.data(withJSONObject: remoteMessage.appData, options: .prettyPrinted),
            let prettyPrinted = String(data: data, encoding: .utf8) else { return }
        print("Received direct channel message:\n\(prettyPrinted)")
        let notif :  [String:String] = remoteMessage.appData["notification"] as! [String:String]
        
        LocalNotification.dispatchlocalNotification(with: "Rep-wales", body: notif["body"]! , at: Date().addedBy(minutes: 1))
        
    }
    
    
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
    {
        //Handle the notification ON APP
       
        //  LocalNotification.dispatchlocalNotification(with: “Notification Title for iOS10+“, body: “willPresent notification: UNNotification, withCompletionHandler”, at: Date().addedBy(minutes: 1))
        completionHandler([UNNotificationPresentationOptions.alert,UNNotificationPresentationOptions.sound,UNNotificationPresentationOptions.badge])
        
        
    }
    
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void)
    {
        //Handle the notification ON BACKGROUND
            debugPrint("*** didReceive response Notification “")
            debugPrint("*** response: \(response)“")
        completionHandler()
    }
  
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error)->Void in
            
            if (error != nil) {
                print("Reverse geocoder failed with error" + (error?.localizedDescription)!)
                return
            }
            
            if (placemarks?.count)! > 0 {
                let pm = placemarks?[0]
                self.displayLocationInfo(pm)
            } else {
                print("Problem with the data received from geocoder")
            }
        })
    }
    func displayLocationInfo(_ placemark: CLPlacemark?) {
        if let containsPlacemark = placemark {
            //stop updating location to save battery life
            locationManager.stopUpdatingLocation()
           /* let locality = (containsPlacemark.locality != nil) ? containsPlacemark.locality : ""
            let postalCode = (containsPlacemark.postalCode != nil) ? containsPlacemark.postalCode : ""
            let administrativeArea = (containsPlacemark.administrativeArea != nil) ? containsPlacemark.administrativeArea : ""
            let country = (containsPlacemark.country != nil) ? containsPlacemark.country : ""
            */
            print(containsPlacemark.location?.coordinate.latitude)
            print(containsPlacemark.location?.coordinate.longitude)
            AppDelegate.currentLocaitonLatitude =  containsPlacemark.location!.coordinate.latitude // 51.15
            AppDelegate.currentLocaitonLongitude =  containsPlacemark.location!.coordinate.longitude //-3.15
            
            locationManager.stopUpdatingLocation()


        }
        
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "rep")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    
    

}








