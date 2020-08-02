//
//  RecipeViewController.swift
//  FoodZam
//
//  Created by dadDev on 7/30/20.
//  Copyright © 2020 dadDev. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var userNameArray = [String]()
    var profileImageArray = [String]()
    var foodDescArray = [String]()
    var foodTypeArray = [String]()
    var likeArray = [Int]()
    var documentIdArray = [String]()
    
    
    
    func getFBProfile() {
        
    }
    
    func getFBPost() {
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileImageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recipeTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RecipeCell
        
        return cell
    }
    
    
    
    
    @IBOutlet weak var recipeTableView: UITableView!
    
    
    @IBAction func postButtonPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "PostVC", sender: nil)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        recipeTableView.delegate = self
        recipeTableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
