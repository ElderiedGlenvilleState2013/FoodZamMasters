//
//  RecipePostViewController.swift
//  FoodZam
//
//  Created by dadDev on 7/30/20.
//  Copyright © 2020 dadDev. All rights reserved.
//

import UIKit
import Firebase

class RecipePostViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var foodImage: UIImageView!
    
    @IBOutlet weak var foodDescLabel: UITextField!
    @IBOutlet weak var foodTypeTextField: UITextField!
    @IBOutlet weak var foodNameTextField: UITextField!
    
    var currentUserStruct = CurrentUserProfile()
    var s = ""
    
    
    
    deinit {
           NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
           NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
           NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
           
       }
    
    @objc func keyboardWillChange(notification: Notification) {
        
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        if  notification.name == UIResponder.keyboardWillShowNotification || notification.name == UIResponder.keyboardWillChangeFrameNotification {
            
            view.frame.origin.y = -keyboardRect.height / 3.5
        } else {
            view.frame.origin.y = 0
        }
        
        
        
    } // end of function
    
    
    
    func hideKeyboard(){
        //to help the keyboard to dismiss when user
        //swipes screen
           foodDescLabel.resignFirstResponder()
           foodTypeTextField.resignFirstResponder()
           foodNameTextField.resignFirstResponder()
           
       }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //to help the keyboard to dismiss when user
        //swipes screen
        hideKeyboard()
        
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        foodDescLabel.delegate = self
       foodTypeTextField.delegate = self
        foodNameTextField.delegate = self
    
        currentUserStruct.getProfilesFB()
        getProfilesFB()
        print("GOKU: \(s)")

        foodImage.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        foodImage.addGestureRecognizer(gestureRecognizer)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func chooseImage(){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        foodImage.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }

    func makeAlert(titleInput: String, messageInput: String ) {
           let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
               
                     let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                     
                     alert.addAction(okButton)
                     present(alert, animated: true, completion: nil)
           
       }
    
    func getProfilesFB(){
             let firestoreDB = Firestore.firestore()
             
        firestoreDB.collection("Profiles").whereField("currentUserEmail", isEqualTo: Auth.auth().currentUser?.email).addSnapshotListener { (snapshot, error) in
                 if error != nil {
                     print(error?.localizedDescription)
                 } else {
                     if snapshot?.isEmpty != true && snapshot != nil {
                         
                         
                         for docs in snapshot!.documents {
                             if let profileImages = docs.get("imageUrl") as? String {
                              
                                self.s = profileImages
                             }
                          
                         }
                        
                     }
                 }
             }
         }
    
    func uploadPostToFirease() {
        let storage = Storage.storage()
        let storageReference = storage.reference()
        
        let mediaFolder = storageReference.child("media")
        
        if let data = foodImage.image?.jpegData(compressionQuality: 0.5) {
            
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
                            
                            let firestorePost = [
                                "imageUrl" : imageUrl,
                                "profileImageUrl" : CurrentUserProfile.instanc.currentProfileImageURL,
                                "postedBy" :  Auth.auth().currentUser?.email!,
                                "foodType": self.foodTypeTextField.text!,
                                "foodDescription": self.foodDescLabel.text!,
                                "foodName" : self.foodNameTextField.text!, "date" : FieldValue.serverTimestamp(),
                                "likes" :  0]  as [String : Any]
                            firestoreReference = firestoreDatabase.collection("Posts").addDocument(data: firestorePost, completion: { (error) in
                                
                                if error != nil {
                                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                                } else {
                                    
                                    self.foodImage.image = UIImage(named: "select.png")
                                    self.foodNameTextField.text = ""
                                    self.tabBarController?.selectedIndex = 3
                                    self.makeAlert(titleInput: "Upload", messageInput: "your images was uploaded successfully")
                                }
                            })
                        }
                    }
                }
            }
        }
    } // end of upload function
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        
        uploadPostToFirease()
        dismiss(animated: true, completion: nil)
    } // end of save button
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
