//
//  SetbudgetVC.swift
//  FoodZam
//
//  Created by dadDev on 6/28/20.
//  Copyright © 2020 dadDev. All rights reserved.
//

import UIKit
import Firebase

class SetbudgetVC: UIViewController , UINavigationControllerDelegate{
    
    @IBOutlet weak var setbudetTextField: UITextField!
    
    var budgetArray = [String]()
    static var saveBudgetText = ""
    
    func makeAlert(titleInput: String, messageInput: String ) {
                let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
                    
                          let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                          
                          alert.addAction(okButton)
                          present(alert, animated: true, completion: nil)
                
            }
    
    func sendToDB() {
       
            
             
             let firestoreDatabase = Firestore.firestore()
             var firestoreReference : DocumentReference? = nil
             
             let firestorePost = ["budgetSetBy" :  Auth.auth().currentUser?.email!, "setBudgetAmount" : self.setbudetTextField.text!, "date" : FieldValue.serverTimestamp(),]  as [String : Any]
             
             firestoreReference = firestoreDatabase.collection("Budgets").addDocument(data: firestorePost, completion: { (error) in
                                            
                                            if error != nil {
                                                self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                                            } else {
                                                self.makeAlert(titleInput: "Good", messageInput: "sent success")
                                                self.setbudetTextField.text = ""
                                                self.tabBarController?.selectedIndex = 0
                                                self.makeAlert(titleInput: "Post", messageInput: "your comment was uploaded successfully")
                                            }
                                        })
    }
    
    @IBAction func sendbtnPressed(_ sender: Any) {
        
        sendToDB()
        dismiss(animated: true, completion: nil)
        //performSegue(withIdentifier: "mainVC", sender: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    

}
