//
//  CreateProfileVC.swift
//  FoodZam
//
//  Created by dadDev on 7/4/20.
//  Copyright © 2020 dadDev. All rights reserved.
//

import UIKit
import Firebase

class CreateProfileVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    @IBOutlet weak var profileimageView: UIImageView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var bioTextField: UITextField!
    @IBOutlet weak var foodCat1TextField: UITextField!
    @IBOutlet weak var foodCat2TextField: UITextField!
    @IBOutlet weak var foodCat3TextField: UITextField!
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        profileimageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        profileimageView.addGestureRecognizer(gestureRecognizer)
        
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        bioTextField.delegate = self
        foodCat1TextField.delegate = self
        foodCat2TextField.delegate = self
        foodCat3TextField.delegate = self
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
    } // end of view did load
    
    deinit {
          NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
          NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
          NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
          
      }
      
      
      
      func hideKeyboard(){
          firstNameTextField.resignFirstResponder()
          lastNameTextField.resignFirstResponder()
        bioTextField.resignFirstResponder()
        foodCat1TextField.resignFirstResponder()
        foodCat2TextField.resignFirstResponder()
        foodCat3TextField.resignFirstResponder()
          
      }
      
      @objc func keyboardWillChange(notification: Notification) {
          
          guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
              return
          }
          
          if  notification.name == UIResponder.keyboardWillShowNotification || notification.name == UIResponder.keyboardWillChangeFrameNotification {
              
              view.frame.origin.y = -keyboardRect.height
          } else {
              view.frame.origin.y = 0
          }
          
          
          
      }
    

    @objc func chooseImage() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        profileimageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        
    } // end of ImagePicker
    
    
    func makeAlert(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
        
    } // end of makeAlert
    
    func sendToDB() {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        let mediaFolder = storageRef.child("media")
        
        if let data = profileimageView.image?.jpegData(compressionQuality: 0.5) {
            let uuid = UUID().uuidString
            
            let imageRef = mediaFolder.child("\(uuid).jpg")
            imageRef.putData(data, metadata: nil) { (metaData, error) in
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                    
                } else {
                    imageRef.downloadURL { (url, error) in
                        if error == nil {
                            let imageUrl = url?.absoluteString
                            
                            let fireStoreDB = Firestore.firestore()
                            var fireStoreRef : DocumentReference? = nil
                            
                            let firestoreProfileData = [
                                "currentUserEmail": Auth.auth().currentUser?.email,
                                "firstName" : self.firstNameTextField.text,
                                "lastName" : self.lastNameTextField.text,
                                "imageUrl" : imageUrl,
                                "foodCategory1" : self.foodCat1TextField.text,
                                "foodCategory2" : self.foodCat2TextField.text,
                                "foodCategory3" : self.foodCat3TextField.text,
                                "bio" : self.bioTextField.text,
                                
                            ] // end of dictionary
                            fireStoreRef = fireStoreDB.collection("Profiles").addDocument(data: firestoreProfileData, completion: { (error) in
                                if error != nil {
                                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                                } else {
                                    self.profileimageView.image = UIImage(named: "select.png")
                                    self.makeAlert(titleInput: "Profile Created", messageInput: "Profile was created Successfully")
                                }
                            })
                            
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        sendToDB()
        performSegue(withIdentifier: "toSetBudgetVC", sender: nil)
    }
    
    

} // end of Create Profile VC class
