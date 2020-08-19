//
//  UploadFB.swift
//  FoodZam
//
//  Created by dadDev on 8/19/20.
//  Copyright © 2020 dadDev. All rights reserved.
//

import UIKit
import Firebase


struct UploadFirebase {
    
    
    mutating func uploadPostToFirease(nameOfFood: String, typeOfFood: String, imageUrl: Any) {
        let storage = Storage.storage()
        let storageReference = storage.reference()
        
        let mediaFolder = storageReference.child("media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5) {
            
            let uuid = UUID().uuidString
            
            
            let imagereference = mediaFolder.child("\(uuid).jpg")
            imagereference.putData(data, metadata: nil) { (metaData, error) in
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                } else {
                    imagereference.downloadURL { (url, error) in
                        
                        if error == nil {
                            let imageUrl = url?.absoluteString
                            
                            //database
                            let firestoreDatabase = Firestore.firestore()
                            var firestoreReference : DocumentReference? = nil
                            
                            let firestorePost = ["imageUrl" : imageUrl, "postedBy" :  Auth.auth().currentUser?.email!, "postComment" : self.commentText.text!, "date" : FieldValue.serverTimestamp(), "likes" :  0]  as [String : Any]
                            firestoreReference = firestoreDatabase.collection("Posts").addDocument(data: firestorePost, completion: { (error) in
                                
                                if error != nil {
                                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                                } else {
                                    
                                    self.imageView.image = UIImage(named: "select.png")
                                    self.commentText.text = ""
                                    self.tabBarController?.selectedIndex = 0
                                    self.makeAlert(titleInput: "Upload", messageInput: "your images was uploaded successfully")
                                }
                            })
                        }
                    }
                }
            }
        }
    }
    
  
}
