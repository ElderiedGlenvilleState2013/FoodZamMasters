//
//  RecipeViewController.swift
//  FoodZam
//
//  Created by dadDev on 7/30/20.
//  Copyright © 2020 dadDev. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class RecipeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    var emailArray = [String]()
    var imagePostArray = [String]()
    var nameArray = [String]()
    var foodDescriptionArray = [String]()
    var typeOfFoodArray = [String]()
    var likesArray = [Int]()
    var documentsIdArray = [String]()
    var profileImageUrlArray = [String]()
    
    @IBOutlet weak var recipeTableView: UITableView!
    
    
    override func viewDidLoad() {
          super.viewDidLoad()

          recipeTableView.delegate = self
          recipeTableView.dataSource = self
          
        CurrentUserProfile.instanc.getProfilesFB()
        
          getFBPost()
        
      }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       // getFBProfile()
    }
      
    @IBAction func postButtonPressed(_ sender: Any) {
        CurrentUserProfile.instanc.getProfilesFB()
        print("Gohan \(CurrentUserProfile.instanc.currentProfileImageURL)")
        performSegue(withIdentifier: "PostVC", sender: nil)
    }
    
    
      
      func getFBPost() {
          let firestoreDatabase = Firestore.firestore()
                
                firestoreDatabase.collection("Posts").order(by: "date", descending: true).addSnapshotListener { (snapshot, error) in
                    if error != nil {
                        print(error?.localizedDescription)
                        
                    } else {
                        if snapshot?.isEmpty != true && snapshot != nil {
                            self.emailArray.removeAll(keepingCapacity: true)
                            self.profileImageUrlArray.removeAll(keepingCapacity: true)
                            self.foodDescriptionArray.removeAll(keepingCapacity: true)
                            self.typeOfFoodArray.removeAll(keepingCapacity: true)
                            self.documentsIdArray.removeAll(keepingCapacity: true)
                            self.imagePostArray.removeAll(keepingCapacity: true)
                            for document in snapshot!.documents {
                                let documentID = document.documentID
                                self.documentsIdArray.append(documentID)
                                print(documentID)
                                
                                if let postedBy = document.get("postedBy")  as? String {
                                    print(postedBy)
                                    self.emailArray.append(postedBy)
                                   // self.r.nameOfUser = postedBy
                                    
                                }
                                
                                if let postComment = document.get("foodType") as? String {
                                    self.typeOfFoodArray.append(postComment)
                                   // self.r.typeOfFood = postComment
                                }
                                if let foodPost = document.get("foodDescription") as? String {
                                    self.foodDescriptionArray.append(foodPost)
                                    //self.r.foodDesc = foodPost
                                    
                                }
                                if let names = document.get("foodName") as? String{
                                    self.nameArray.append(names)
                                    //self.r.nameOfFood = names
                                    
                                }
                                
                                if let imageUrl = document.get("imageUrl") as? String {
                                    self.imagePostArray.append(imageUrl)
                                   // self.r.urlPostImage = imageUrl
                                    
                                }
                                if let profileImages = document.get("profileImageUrl") as? String {
                                    self.profileImageUrlArray.append(profileImages)
                                    
                                }
                                
                            }
                            //self.recipePostingArray.append(self.r)
                           
                            self.recipeTableView.reloadData()
                        }
                    }
                }
      }
      
      
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  emailArray.count
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = recipeTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RecipeCell
        cell.foodDescriptionLabel.text = foodDescriptionArray[indexPath.row]
        cell.foodNameLabel.text = nameArray[indexPath.row]
        cell.foodTypeLabel.text = typeOfFoodArray[indexPath.row]
        cell.userNameLabel.text = emailArray[indexPath.row]
        cell.foodImage.sd_setImage(with: URL(string: self.imagePostArray[indexPath.row]))
        cell.profileImageView.sd_setImage(with: URL(string: self.profileImageUrlArray[indexPath.row]))
        
          return cell
      }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 650
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

struct RecipePosting {
    var urlProfile : String
    var urlPostImage: String
    var typeOfFood: String
    var nameOfFood: String
    var foodDesc: String
    var nameOfUser: String
}
