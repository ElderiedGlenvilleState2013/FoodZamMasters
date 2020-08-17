//
//  ProfileVCViewController.swift
//  FoodZam
//
//  Created by dadDev on 7/26/20.
//  Copyright © 2020 dadDev. All rights reserved.
//

import UIKit
import Firebase

class ProfileVCViewController: UIViewController {

    @IBOutlet weak var priceLbl: UILabel!
    
    
    
    
    
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
        
        fireStoreDB.collection("Budgets").whereField("budgetSetBy", isEqualTo: Auth.auth().currentUser?.email! as Any).addSnapshotListener { (snapshot, error) in
            if error != nil {
                print(error?.localizedDescription ?? "cannot find budget")
            } else {
                
                for document in snapshot!.documents {
                    
                    if let setBudget = document.get("setBudgetAmount") as? String {
                        self.priceLbl.text = setBudget
                        
                        
                        
                       // self.budgetPrice = (nn != nil ? nn : 0.0)!
                       // self.budgetArray.append(setBudget)
                       // self.budgetPrice = Double(self.navigationItem.title!)!
                        
                        
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
