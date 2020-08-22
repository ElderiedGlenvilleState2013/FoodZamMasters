//
//  MainVC.swift
//  FoodZam
//
//  Created by dadDev on 6/28/20.
//  Copyright © 2020 dadDev. All rights reserved.
//

import UIKit
import CoreML
import AVFoundation
import Vision
import Firebase

class MainVC: UIViewController, UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    
    @IBOutlet weak var FoodImgView: UIImageView!
    @IBOutlet weak var foodNameLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var storeName: UILabel!
    var budgetPrice = 0.00
    let imagePicker = UIImagePickerController()
    var speechSynthesizer = AVSpeechSynthesizer()
    var quoteListener: ListenerRegistration!

    var identfierName : String = ""
    var bp = 0.00
    
    
    var setB = Double(SetbudgetVC.saveBudgetText)
    
    
   
    

    func addingSheet(){
           let actionSheet = UIAlertController(title: "Photo Source", message: "choose your source", preferredStyle: .actionSheet)
           
           actionSheet.addAction(UIAlertAction(title: "Photo Album", style: .default, handler: { (UIAlertAction) in
               self.imagePicker.sourceType = .savedPhotosAlbum
               self.present(self.imagePicker, animated: true, completion: nil)
           }))
           
           actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (UIAlertAction) in
               self.imagePicker.sourceType = .camera
               self.present(self.imagePicker, animated: true, completion: nil)
           }))
           
          
           
           
           actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
           self.present(actionSheet, animated: true, completion: nil)
        
       }
    
    
    
      
      func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
          if let userPickimage = info[UIImagePickerController.InfoKey.originalImage] {
              
              
              FoodImgView.image = userPickimage as? UIImage
              guard let ciimage = CIImage(image: userPickimage as! UIImage) else {
                  fatalError("could not convert uiimage to ciimage ")
              }
              
              detect(image: ciimage)
              addingItemToBudget()
          }
          
          imagePicker.dismiss(animated: true, completion: nil)
          
          
      }
    

    
    func detect(image: CIImage){
        
        
        
        guard let model = try? VNCoreMLModel(for: NewFoodImageClassifier().model) else {
            fatalError("loading CoreML Model failed")
        }
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("model failed to process image")
            }
            print(results)
            
            if let grapeResult = results.first {
                if grapeResult.identifier.contains("Grapes") {
                        self.identfierName = grapeResult.identifier
                                                  //self.budgetPrice -= self.bp

                                                //  self.addingItemToBudget()
                        self.foodNameLbl.text = "Grapes"
                        self.navigationController?.navigationBar.barTintColor = UIColor.green
                        self.synthesizeSpeech(fromString: " I believe this is a \(grapeResult.identifier)")

                } else {
                    
                    if let dogAResults = results.first {
                        if dogAResults.identifier.contains("(1) Great Value Premium Fully Cooked Chunk Chicken, 12.5 oz") {
                            self.identfierName = dogAResults.identifier
                                                      //self.budgetPrice -= self.bp

                                                    //  self.addingItemToBudget()
                            self.foodNameLbl.text = "(1) Great Value Premium Fully Cooked Chunk Chicken, 12.5 oz"
                            self.navigationController?.navigationBar.barTintColor = UIColor.green
                            self.synthesizeSpeech(fromString: " I believe this is a \(dogAResults.identifier)")
                        } else {
                            
                            if let firstResults = results.first {
                                if firstResults.identifier.contains("Newtons Soft & fruit Chewy Fig Cookies, 10 oz Pack") {
                                   self.identfierName = firstResults.identifier
                                                             //self.budgetPrice -= self.bp

                                                           //  self.addingItemToBudget()
                                   self.foodNameLbl.text = "Newtons Soft & fruit Chewy Fig Cookies, 10 oz Pack"
                                   self.navigationController?.navigationBar.barTintColor = UIColor.green
                                   self.synthesizeSpeech(fromString: " I believe this is a \(firstResults.identifier)")
                                    
                                } else {
                                    if let secondResults = results.first {
                                        if secondResults.identifier.contains("Apples") {
                                          self.identfierName = secondResults.identifier
                                                                    //self.budgetPrice -= self.bp

                                                                  //  self.addingItemToBudget()
                                          self.foodNameLbl.text = "Apples"
                                          self.navigationController?.navigationBar.barTintColor = UIColor.green
                                          self.synthesizeSpeech(fromString: " I believe this is a \(secondResults.identifier)")
                                            
                                        } else {
                                            if let thirdResults = results.first {
                                                if thirdResults.identifier.contains("Banana") {
                                                   self.identfierName = grapeResult.identifier
                                                                             //self.budgetPrice -= self.bp

                                                                           //  self.addingItemToBudget()
                                                   self.foodNameLbl.text = "Banana"
                                                   self.navigationController?.navigationBar.barTintColor = UIColor.green
                                                    self.synthesizeSpeech(fromString: "I believe this is a \(thirdResults.identifier)")
                                                } else {
                                                    if let fourthResults = results.first {
                                                        if fourthResults.identifier.contains("Beech-Nut Pouches, In-Store Purchase Only") {
                                                         self.identfierName = fourthResults.identifier
                                                                                   //self.budgetPrice -= self.bp

                                                                                 //  self.addingItemToBudget()
                                                         self.foodNameLbl.text = "Beech-Nut Pouches, In-Store Purchase Only"
                                                         self.navigationController?.navigationBar.barTintColor = UIColor.green
                                                            self.synthesizeSpeech(fromString: " I believe this is a \(fourthResults.identifier)")
                                                            
                                                        } else {
                                                            if let fifthResults = results.first {
                                                                if fifthResults.identifier.contains("Oreo") {
                                                             self.identfierName = grapeResult.identifier
                                                                                                                                   //self.budgetPrice -= self.bp

                                                                                                                                 //  self.addingItemToBudget()
                                                                                                         self.foodNameLbl.text = "Oreo"
                                                                                                         self.navigationController?.navigationBar.barTintColor = UIColor.green
                                                                                                          
                                                                    self.synthesizeSpeech(fromString: " I believe this is a \(fifthResults.identifier)")
                                                                    
                                                                } else {
                                                                    if let sixthResults = results.first {
                                                                        if sixthResults.identifier.contains("Lay's Barbecue Flavored Potato Chips, Party Size, 12.5 oz Bag") {
                                                                            
                                                                            self.identfierName = sixthResults.identifier
                                                                                                      //self.budgetPrice -= self.bp

                                                                                                    //  self.addingItemToBudget()
                                                                            self.foodNameLbl.text = "Lay's Barbecue Flavored Potato Chips, Party Size, 12.5 oz Bag"
                                                                            self.navigationController?.navigationBar.barTintColor = UIColor.green
                                                                           
                                                                            self.synthesizeSpeech(fromString: " I believe this is a \(sixthResults.identifier)")
                                                                            
                                                                        } else {
                                                                            if let seventhResults = results.first {
                                                                                if seventhResults.identifier.contains("belVita Cinnamon Brown Sugar Breakfast Biscuits, 5 Packs (4 Biscuits Per Pack)") {
                                                                                    
                                                                                    self.identfierName = seventhResults.identifier
                                                                                                                                                                                        //self.budgetPrice -= self.bp

                                                                                                                                                                                      //  self.addingItemToBudget()
                                                                                                                                                              self.foodNameLbl.text = "belVita Cinnamon Brown Sugar Breakfast Biscuits, 5 Packs (4 Biscuits Per Pack)"
                                                                                    
                                                                                    self.navigationController?.navigationBar.barTintColor = UIColor.green
                                                                                 


                                                                                    self.navigationController?.navigationBar.isTranslucent = false
                                                                                    self.synthesizeSpeech(fromString: " I believe this is a \(seventhResults.identifier)")
                                                                                    
                                                                                } else {
                                                                                    if let eightResults = results.first {
                                                                                        
                                                                                        if eightResults.identifier.contains("Cool Ranch Doritos") {
                                                                                            
                                                                                           
                                                                                            
                                                                                            self.identfierName = eightResults.identifier
                                                                                                                                                                                                 //self.budgetPrice -= self.bp

                                                                                                                                                                                               //  self.addingItemToBudget()
                                                                                                                                                                       self.foodNameLbl.text = "Cool Ranch Doritos"
                                                                                            
                                                                                            self.synthesizeSpeech(fromString: " I believe this is a \(eightResults.identifier)")
                                                                                            
                                                                                        } else {
                                                                                            if let ninethResults = results.first {
                                                                                                if ninethResults.identifier.contains("Garden Veggie Straws, Sea Salt, 14 oz") {
                                                                                                    
                                                                                                   
                                                                                                    self.identfierName = ninethResults.identifier
                                                                                                                              //self.budgetPrice -= self.bp

                                                                                                                            //  self.addingItemToBudget()
                                                                                                    self.foodNameLbl.text = "Garden Veggie Straws, Sea Salt, 14 oz"
                                                                                                    
                                                                                                    self.navigationController?.navigationBar.barTintColor = UIColor.green
                                                                                                    self.navigationController?.navigationBar.isTranslucent = false
                                                                                                    self.synthesizeSpeech(fromString: " I believe this is a \(ninethResults.identifier)")
                                                                                                    
                                                                                                } else {
                                                                                                    if let tenResults = results.first {
                                                                                                        if tenResults.identifier.contains("Lay's Dill Pickle Flavored Potato Chips, Party Size, 12.5 oz Bag") {
                                                                                                          
                                                                                                            self.identfierName = tenResults.identifier
                                                                                                                                                                                                                                         //self.budgetPrice -= self.bp

                                                                                                                                                                                                                                       //  self.addingItemToBudget()
                                                                                                                                                                                                               self.foodNameLbl.text = "Lay's Dill Pickle Flavored Potato Chips, Party Size, 12.5 oz Bag"
                                                                                                          
                                                                                                            self.navigationController?.navigationBar.barTintColor = UIColor.green
                                                                                                            self.navigationController?.navigationBar.isTranslucent = false
                                                                                                            self.synthesizeSpeech(fromString: " I believe this is a \(tenResults.identifier)")
                                                                                                            
                                                                                                        } else {
                                                                                                            if let huskyResults = results.first {
                                                                                                                if huskyResults.identifier.contains("Bob’S Red Mill Flaxseed Meal, 16 Oz") {
                                                                                                                    
                                                                                                                  self.identfierName = huskyResults.identifier
                                                                                                                                                                                                                                                                                                                                                          //self.budgetPrice -= self.bp

                                                                                                                                                                                                                                                                                                                                                        //  self.addingItemToBudget()
                                                                                                                                                                                                                                                                                                                                self.foodNameLbl.text = "Bob’S Red Mill Flaxseed Meal, 16 Oz"
                                                                                                                
                                                                                                                    self.navigationController?.navigationBar.barTintColor = UIColor.green
                                                                                                                    self.navigationController?.navigationBar.isTranslucent = false
                                                                                                                    self.synthesizeSpeech(fromString: " I believe this is a \(huskyResults.identifier)")
                                                                                                                    
                                                                                                                } else {
                                                                                                                    self.navigationItem.title = "Sorry try again!"
                                                                                                                    self.navigationController?.navigationBar.barTintColor = UIColor.red
                                                                                                                    self.navigationController?.navigationBar.isTranslucent = false
                                                                                                                    self.synthesizeSpeech(fromString: "I'm sorry, I couldn't find that item. Please try again!")
                                                                                                                    
                                                                                                                }
                                                                                                                
                                                                                                            }
                                                                                                        }
                                                                                                    }
                                                                                                    
                                                                                                }
                                                                                                
                                                                                                
                                                                                            }
                                                                                            
                                                                                        }
                                                                                        
                                                                                        
                                                                                    }
                                                                                    
                                                                                }
                                                                                
                                                                                
                                                                            }
                                                                            
                                                                        }
                                                                        
                                                                        
                                                                    }
                                                                    
                                                                }
                                                                
                                                                
                                                            }
                                                        }
                                                        
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            
                        }
                    }
                    
                }
                
            }
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        do {
            try! handler.perform([request])
        }
        catch {
            print(error)
        }
    }
    
   
   
    
    func getStoreDataDB() {
        let fireStoreDB = Firestore.firestore()
              
              fireStoreDB.collection("Food").whereField("foodName", isEqualTo: identfierName).addSnapshotListener { (snapshot, error) in
                  if error != nil {
                      print(error?.localizedDescription)
                  } else {
                      
                      for document in snapshot!.documents {
                          
                          
                          if let price = document.get("foodPrice") as? String {
                            
                              self.priceLbl.text = price
                            self.bp = Double(price)!
                            
                            
                          }
                          
                          if let nameOfStore = document.get("storeName") as? String {
                              self.storeName.text = nameOfStore
                           
                          }
                          
                        
                      }
                  }
              }
    }
    
    func synthesizeSpeech(fromString string: String) {
           let speechUtterence = AVSpeechUtterance(string: string)
           speechSynthesizer.speak(speechUtterence)
           
       }
    
    func addingItemToBudget() {
        if budgetPrice > 0.0 {
            budgetPrice -= bp
            navigationItem.title = "$\(budgetPrice)"
        } else {
            budgetPrice = 0.0
            self.navigationController?.navigationBar.barTintColor = UIColor.red
            
        }
        
    }
    
    @IBAction func cameraButtonPressed(_ sender: Any) {
        // adding sheet provide the camera data
           addingSheet()
        //addingItemToBudget()
        getStoreDataDB() // get storeDataDB get the food items from the database
        //addingItemToBudget()
        
    }
       
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imagePicker.delegate = self
              imagePicker.sourceType = .savedPhotosAlbum
              imagePicker.sourceType = .photoLibrary
              imagePicker.allowsEditing = false
              speechSynthesizer.delegate = self
       
        
        
        getStoreDataDB()
       // getBudgetDataDB()
        
        navigationItem.title = "$ \(budgetPrice)"
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
       getStoreDataDB()
       // navigationItem.title = "$ \(budgetPrice)"
        
    }
    
    
    @IBAction func setButtonPressed(_ sender: Any) {
       
        //getBudgetDataDB()
        performSegue(withIdentifier: "SetBudget", sender: self)
        
         
    }
    


   

}


extension MainVC: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        //finish utter
    }
    
}


