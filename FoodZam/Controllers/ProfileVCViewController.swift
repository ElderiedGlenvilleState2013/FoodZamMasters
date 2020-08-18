//
//  ProfileVCViewController.swift
//  FoodZam
//
//  Created by dadDev on 7/26/20.
//  Copyright © 2020 dadDev. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage
class ProfileVCViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var bioLabel: UILabel!
    
    @IBAction func signOut(_ sender: UIButton) {
        
        do {
                         try Auth.auth().signOut()
                         performSegue(withIdentifier: "toLoginVC", sender: nil)
                     } catch {
                         print(error)
                         self.makeAlert(titleInput: "Error", messageInput: error.localizedDescription ?? "Error")
                         
                         
                     }
    }
    
    
    func makeAlert(titleInput: String, messageInput: String ) {
          let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
              
                    let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                    
                    alert.addAction(okButton)
                    present(alert, animated: true, completion: nil)
          
      }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getBudgetDataDB()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getBudgetDataDB()
    }
    
    
    
    func getBudgetDataDB() {
        let fireStoreDB = Firestore.firestore()
        
        fireStoreDB.collection("Profiles").whereField("currentUserEmail", isEqualTo: Auth.auth().currentUser?.email! as Any).addSnapshotListener { (snapshot, error) in
            if error != nil {
                print(error?.localizedDescription ?? "cannot find budget")
            } else {
                
                for document in snapshot!.documents {
                    
                    if let setBudget = document.get("firstName") as? String {
                        self.nameLabel.text = setBudget
                        
                        
                        
                    }
                    if let emailText = document.get("currentUserEmail") as? String {
                        self.emailLabel.text = emailText
                    }
                    
                    if let bioText = document.get("bio") as? String {
                        
                        self.bioLabel.text = bioText
                        
                    }
                    
                    if let imgeUrl = document.get("imageUrl") as? String {
                        self.profileImage.sd_setImage(with: URL(string: imgeUrl))
                    }
                  
                    
                }
            }
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "ResultVC" {
//        let desVC = segue.destination as! ResultViewController
//        desVC.bmiValue = calculateBrain.getBmiValue()
//        desVC.advice = calculateBrain.getAdvice()
//        desVC.color = calculateBrain.getColor()
//        
//        }
//    }
    

}
