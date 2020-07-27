//
//  AppDelegate.swift
//  FoodZam
//
//  Created by dadDev on 6/28/20.
//  Copyright © 2020 dadDev. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        FirebaseApp.configure()
        
        let currentUsers = Auth.auth().currentUser
        
        if currentUsers != nil {
            let board = UIStoryboard(name: "Main", bundle: nil)
           let tabbar = board.instantiateViewController(withIdentifier: "tabbarStoryboard")  as? UITabBarController
            window?.makeKeyAndVisible()
            window?.rootViewController = tabbar
            
        }
        
        
//        let firestoreDatabase = Firestore.firestore()
//        var firestoreReference : DocumentReference? = nil
//
//        firestoreDatabase.collection("Drinks").document().setData(["storeName" : "Walmart", "foodPrice" : "1.88", "foodName" : "Coca-Cola Bottle"])
//       firestoreDatabase.collection("Drinks").document().setData(["storeName" : "Walmart", "foodPrice" : "1.74", "foodName" : "Diet Coke bottle"])
//       firestoreDatabase.collection("Drinks").document().setData(["storeName" : "Walmart", "foodPrice" : "3.88", "foodName" : "Diet Coke Soda Can"])
//         firestoreDatabase.collection("Drinks").document().setData(["storeName" : "Walmart", "foodPrice" : "6.96", "foodName" : "Folgers Classic Roast"])
//         firestoreDatabase.collection("Drinks").document().setData(["storeName" : "Walmart", "foodPrice" : "5.75", "foodName" : "Coffee Mate 35oz"])
        
      
                                     
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

