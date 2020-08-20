//
//  CurrentUserStruct.swift
//  FoodZam
//
//  Created by dadDev on 8/20/20.
//  Copyright © 2020 dadDev. All rights reserved.
//

import UIKit
import Firebase

// to get the users profile information
class CurrentUserProfile {
    var currentUersEmail: String?
    var currentProfileImageURL : String?
    var currentUserId  = 0
    
    
    
    static var instanc = CurrentUserProfile()
    
     func getProfilesFB(){
           let firestoreDB = Firestore.firestore()
           
           firestoreDB.collection("Profiles").addSnapshotListener { (snapshot, error) in
               if error != nil {
                   print(error?.localizedDescription)
               } else {
                   if snapshot?.isEmpty != true && snapshot != nil {
                       
                       
                       for docs in snapshot!.documents {
                           if let profileImages = docs.get("imageUrl") as? String {
                            self.currentProfileImageURL = profileImages
                           }
                        
                       }
                      
                   }
               }
           }
       }
    
    func getCurrentUserEmail() -> String {
        return (Auth.auth().currentUser?.email)!
    }
    func getProfileImageURl() -> String {
        
        return self.currentProfileImageURL!
    }
    
     func assigningUserId(){
        if currentUserId <= 0 {
            self.currentUserId += 1
            
        } else {
            self.currentUserId = 0
        }
    }
    
    
}
