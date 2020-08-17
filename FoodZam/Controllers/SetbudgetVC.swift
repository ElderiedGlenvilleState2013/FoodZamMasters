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
    var budgetPrice = 0.00
    
  
    
    @IBAction func sendbtnPressed(_ sender: UIButton) {
        
        
        var st = Double(setbudetTextField.text!)
        budgetPrice = st!
        
        performSegue(withIdentifier: "mainVC", sender: self)
       
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mainVC" {
           let barViewControllers = segue.destination as! UITabBarController
           let nav = barViewControllers.viewControllers![0] as! UINavigationController
           let destinationViewController = nav.viewControllers[0] as! MainVC
            destinationViewController.budgetPrice = self.budgetPrice
        }
    }

    

}
