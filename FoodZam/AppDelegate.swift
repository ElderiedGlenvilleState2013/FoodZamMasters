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
//        //nuts
//        firestoreDatabase.collection("Food").document().setData(["storeName" : "Walmart",
//                                                                 "foodPrice" : "4.98",
//                                                                 "foodName" : "Great Value Indulgent Trail Mix, 26 Oz."
//        ])
//       firestoreDatabase.collection("Food").document().setData(["storeName" : "Walmart",
//                                                                "foodPrice" : "4.98",
//                                                                "foodName" : "Great Value Mountain Trail Mix, 26 Oz."
//       ])
//       firestoreDatabase.collection("Food").document().setData(["storeName" : "Walmart",
//                                                                "foodPrice" : "11.72",
//                                                                "foodName" : "Wonderful Roasted & Salted Pistachios, 24 Oz"
//       ])
//         firestoreDatabase.collection("Food").document().setData(["storeName" : "Walmart",
//                                                                  "foodPrice" : "13.38",
//                                                                  "foodName" : "Great Value Deluxe Cashews, 30 oz"
//         ])
//         firestoreDatabase.collection("Food").document().setData(["storeName" : "Walmart",
//                                                                  "foodPrice" : "4.98",
//                                                                  "foodName" : "Great Value Whole Natural Almonds, 14 oz"
//         ])
//        firestoreDatabase.collection("Food").document().setData(["storeName" : "Walmart",
//                                                                 "foodPrice" : "6.22",
//                                                                 "foodName" : "Great Value Walnuts Halves & Pieces, 16 oz"
//        ])
//        firestoreDatabase.collection("Food").document().setData(["storeName" : "Walmart",
//                                                                 "foodPrice" : "6.98",
//                                                                 "foodName" : "Great Value Omega3 Trail Mix, 22 Oz"
//        ])
//        firestoreDatabase.collection("Food").document().setData(["storeName" : "Walmart",
//                                                                 "foodPrice" : "9.94",
//                                                                 "foodName" : "Wonderful No Shell Pistachios, Roasted & Salted, 12 Oz"
//        ])
//        firestoreDatabase.collection("Food").document().setData(["storeName" : "Walmart",
//                                                                 "foodPrice" : "6.98",
//                                                                 "foodName" : "Great Value Sliced Almonds, 16 oz"
//        ])
//        firestoreDatabase.collection("Food").document().setData(["storeName" : "Walmart",
//                                                                 "foodPrice" : "5.34",
//                                                                 "foodName" : "Planters Salted Cocktail Peanuts, 35.0 oz Jar"
//        ])
//        //chips
//        firestoreDatabase.collection("Food").document().setData(["storeName" : "Walmart",
//                                                                 "foodPrice" : "6.28",
//                                                                 "foodName" : "Pepperidge Farm Goldfish Cheddar Crackers, 30 oz. Carton"
//        ])
//        firestoreDatabase.collection("Food").document().setData(["storeName" : "Walmart",
//                                                                 "foodPrice" : "8.62",
//                                                                 "foodName" : "Slim Jim Snack-Sized Smoked Meat Stick Original Flavor Keto Friendly Snack Stick 0.28 Oz 46 Count"
//        ])
//        firestoreDatabase.collection("Food").document().setData(["storeName" : "Walmart",
//                                                                 "foodPrice" : "4.72",
//                                                                 "foodName" : "Keebler PAW Patrol, Graham Snacks, Cinnamon, 12 Ct, 12.7 Oz"
//        ])
//        firestoreDatabase.collection("Food").document().setData(["storeName" : "Walmart",
//                                                                 "foodPrice" : "1.98",
//                                                                 "foodName" : "Pace Chunky Salsa Medium, 16 oz."
//        ])
//        firestoreDatabase.collection("Food").document().setData(["storeName" : "Walmart",
//                                                                 "foodPrice" : "0.96",
//                                                                 "foodName" : "Beech-Nut Pouches, In-Store Purchase Only"
//        ])
//        firestoreDatabase.collection("Food").document().setData(["storeName" : "Walmart",
//                                                                 "foodPrice" : "6.24",
//                                                                 "foodName" : "(3 Pack) Great Value Premium Fully Cooked Chunk Chicken, 12.5 oz"
//        ])
//        firestoreDatabase.collection("Food").document().setData(["storeName" : "Walmart",
//                                                                 "foodPrice" : "5.87",
//                                                                 "foodName" : "Knorr Rice Sides Chicken 5.6 oz"
//        ])
//        firestoreDatabase.collection("Food").document().setData(["storeName" : "Walmart",
//                                                                 "foodPrice" : "2.98",
//                                                                 "foodName" : "Kashi, Chewy Granola Bars, Chocolate Almond Sea Salt, 6 Ct, 7.4 Oz"
//        ])
//        firestoreDatabase.collection("Food").document().setData(["storeName" : "Walmart",
//                                                                 "foodPrice" : "2.98",
//                                                                 "foodName" : "Kashi, Soft Baked Breakfast Bars, Ripe Strawberry, 6 Ct, 7.2 Oz"
//        ])
//        firestoreDatabase.collection("Food").document().setData(["storeName" : "Walmart",
//                                                                 "foodPrice" : "4.29",
//                                                                 "foodName" : "Vegan Rob's Cauliflower Crisps, 5 Oz."
//        ])
//        firestoreDatabase.collection("Food").document().setData(["storeName" : "Walmart",
//                                                                 "foodPrice" : "3.98",
//                                                                 "foodName" : "(2 Cans) Great Value Chunk Chicken Breast in Water, 12.5 oz"
//        ])
//        firestoreDatabase.collection("Food").document().setData(["storeName" : "Walmart",
//                                                                 "foodPrice" : "6.32",
//                                                                 "foodName" : "(4 pack) Progresso Soup Traditional Chicken Noodle Soup 19 oz Can"
//        ])
//        firestoreDatabase.collection("Food").document().setData(["storeName" : "Walmart",
//                                                                 "foodPrice" : "1.48",
//                                                                 "foodName" : ""
//        ])
//        firestoreDatabase.collection("Food").document().setData(["storeName" : "Walmart",
//                                                                 "foodPrice" : "4.97",
//                                                                 "foodName" : "Nutiva Organic, non-GMO, Vegan Hazelnut Spread , Classic Chocolate, 13-ounce"
//        ])
//        firestoreDatabase.collection("Food").document().setData(["storeName" : "Walmart",
//                                                                 "foodPrice" : "3.89",
//                                                                 "foodName" : "Native Forest Organic Young Jackfruit in Water, 14 oz"
//        ])
//        firestoreDatabase.collection("Food").document().setData(["storeName" : "Walmart",
//                                                                 "foodPrice" : "7.96",
//                                                                 "foodName" : "Primal Kitchen Original Mayo, made with Avocado Oil, 12 oz"
//        ])
//        firestoreDatabase.collection("Food").document().setData(["storeName" : "Walmart",
//                                                                 "foodPrice" : "5.44",
//                                                                 "foodName" : "Primal Kitchen Ranch Dressing, With Avocado Oil, 8 Oz"
//        ])
//        firestoreDatabase.collection("Food").document().setData(["storeName" : "Walmart",
//                                                                 "foodPrice" : "6.97",
//                                                                 "foodName" : "Justin's Classic Almond Butter, 12 oz"
//        ])
//        firestoreDatabase.collection("Food").document().setData(["storeName" : "Walmart",
//                                                                 "foodPrice" : "6.98",
//                                                                 "foodName" : "MaraNatha No Sugar or Salt Added Creamy Almond Butter, 12 Ounce Jar"
//        ])
//        firestoreDatabase.collection("Food").document().setData(["storeName" : "Walmart",
//                                                                 "foodPrice" : "4.42",
//                                                                 "foodName" : "Great Value Peanut Butter Filled Pretzel Nuggets 18 Oz. Canister"
//        ])
//        firestoreDatabase.collection("Food").document().setData(["storeName" : "Walmart",
//                                                                 "foodPrice" : "3.88",
//                                                                 "foodName" : "Quaker Oats, Old Fashioned Oatmeal, 42 oz Canister"
//        ])
//        firestoreDatabase.collection("Food").document().setData(["storeName" : "Walmart",
//                                                                 "foodPrice" : "4.46",
//                                                                 "foodName" : "Nature's Bakery Whole Wheat Chocolate Brownie Bars, 10 Twin Packs, 2 Oz each"
//        ])
//        firestoreDatabase.collection("Food").document().setData(["storeName" : "Walmart",
//                                                                 "foodPrice" : "3.65",
//                                                                 "foodName" : "Nature's Path Organic Pumpkin Seed and Flax Granola, 11.5 Oz Box"
//        ])
//        firestoreDatabase.collection("Food").document().setData(["storeName" : "Walmart",
//                                                                 "foodPrice" : "3.99",
//                                                                 "foodName" : "Pacific Foods Organic Creamy Roasted Red Pepper and Tomato Soup, 32 fl oz"
//        ])
//        firestoreDatabase.collection("Food").document().setData(["storeName" : "Walmart",
//                                                                 "foodPrice" : "5.44",
//                                                                 "foodName" : "Primal Kitchen Dressing & Marinade Caesar Dressing , 8 Fz"
//        ])
//        firestoreDatabase.collection("Food").document().setData(["storeName" : "Walmart",
//                                                                 "foodPrice" : "4.88",
//                                                                 "foodName" : "Orville Redenbacher's Movie Theater Butter Microwave Popcorn, 12 Ct (3.29 Oz. Bags)"
//        ])
//        firestoreDatabase.collection("Food").document().setData(["storeName" : "Walmart",
//                                                                 "foodPrice" : "3.98",
//                                                                 "foodName" : "Utz Potato Stix, Original, 15 oz. Canister"
//        ])
//        firestoreDatabase.collection("Food").document().setData(["storeName" : "Walmart",
//                                                                 "foodPrice" : "21.36",
//                                                                 "foodName" : "Bob’S Red Mill Flaxseed Meal, 16 Oz"
//        ])
//        firestoreDatabase.collection("Food").document().setData(["storeName" : "Walmart",
//                                                                 "foodPrice" : "16.83",
//                                                                 "foodName" : "Primal Kitchen Chipotle Lime Mayo, made with Avocado Oil, 12 oz"
//        ])
//        firestoreDatabase.collection("Food").document().setData(["storeName" : "Walmart",
//                                                                 "foodPrice" : "13.99",
//                                                                 "foodName" : "thinkThin Protein & Fiber Bar, S'mores, 10g Protein, 5 Ct"
//        ])
//        firestoreDatabase.collection("Food").document().setData(["storeName" : "Walmart",
//                                                                 "foodPrice" : "3.48",
//                                                                 "foodName" : "Pacific Foods Hazelnut Milk Unsweetened Original Plant-Based Milk, 32 fl oz Keto Friendly"
//        ])
        
        
      
                                     
        
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

