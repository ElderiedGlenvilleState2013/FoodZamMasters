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
    var priceArray = [String]()
    var budgetArray = [String]()

    var identfierName : String = ""
    var bp = 0.00
    
    
    var setBudget = Double(SetbudgetVC.saveBudgetText)
    
    
   
    

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
              
          }
          
          imagePicker.dismiss(animated: true, completion: nil)
          
          
      }
    func detect(image: CIImage){
        
        
        
        guard let model = try? VNCoreMLModel(for: TestFoodClassifier().model) else {
            fatalError("loading CoreML Model failed")
        }
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("model failed to process image")
            }
            print(results)
            
//            self.identfierName = results.first?.identifier as! String
            
            if let oreoResults = results.first {
                if oreoResults.identifier.contains("Oreo") {
                    self.identfierName = oreoResults.identifier
                    self.budgetPrice -= self.bp
                 //   self.budgetPrice -= 3.45
                    self.navigationItem.title = "$\(self.budgetPrice)"
                    self.foodNameLbl.text = oreoResults.identifier;
                    self.navigationController?.navigationBar.barTintColor = UIColor.green
                    self.navigationController?.navigationBar.isTranslucent = false
                    self.synthesizeSpeech(fromString: " I believe this is a \(oreoResults.identifier)")
                    
                } else if let appleResults = results.first {
                    if appleResults.identifier.contains("Apples") {
                        self.identfierName = appleResults.identifier
                        self.budgetPrice = 3.99
                        self.navigationItem.title = "$\(self.budgetPrice)"
                        self.foodNameLbl.text = "Apples"
                        self.navigationController?.navigationBar.barTintColor = UIColor.green
                    } else {
                        if let grapeResult = results.first {
                            if grapeResult.identifier.contains("Grapes") {
                                self.identfierName = grapeResult.identifier
                                //self.budgetPrice -= self.bp
                                self.budgetPrice = 3.00
                                self.navigationItem.title = "$\(self.budgetPrice)"
                                self.foodNameLbl.text = "Grapes"
                                self.navigationController?.navigationBar.barTintColor = UIColor.green
                                
                            }
                        } else {
                            if let iceCreamResult = results.first {
                                if iceCreamResult.identifier.contains("Great Value Vanilla Ice Cream") {
                                    self.identfierName = iceCreamResult.identifier
                                    self.budgetPrice -= 1.99
                                    self.navigationItem.title = "$\(self.budgetPrice)"
                                    self.navigationController?.navigationBar.barTintColor = UIColor.green
                                    self.foodNameLbl.text = iceCreamResult.identifier
                                }
                            } else {
                                if let bananaResult = results.first {
                                    if bananaResult.identifier.contains("Banana") {
                                        self.identfierName = bananaResult.identifier
                                        self.budgetPrice -= 1.50
                                        self.navigationItem.title = "$\(self.budgetPrice)"
                                        self.navigationController?.navigationBar.barTintColor = UIColor.green
                                        self.foodNameLbl.text = "Banana"
                                    }
                                } else {
                                    self.navigationItem.title = "$\(self.budgetPrice)"
                                    self.foodNameLbl.text = "N/A"
                                    self.priceLbl.text = "0.0"
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
    
    
    func getBudgetDataDB() {
        let fireStoreDB = Firestore.firestore()
        
        fireStoreDB.collection("Budgets").whereField("budgetSetBy", isEqualTo: Auth.auth().currentUser?.email).addSnapshotListener { (snapshot, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                
                for document in snapshot!.documents {
                    
                    if let setBudget = document.get("setBudgetAmount") as? String {
                        self.navigationItem.title = setBudget
                        
                        var nn = Double(self.navigationItem.title!)
                       // self.budgetPrice = (nn != nil ? nn : 0.0)!
                        self.budgetArray.append(setBudget)
                        self.budgetPrice = Double(self.budgetArray[0])!
                        
                        
                    }
                  
                    
                }
            }
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
                            self.priceArray.append(price)
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
    
    @IBAction func cameraButtonPressed(_ sender: Any) {
           addingSheet()
       // getBudgetDataDB()
        
        
        getStoreDataDB()
        


        
    }
       
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imagePicker.delegate = self
              imagePicker.sourceType = .savedPhotosAlbum
              imagePicker.sourceType = .photoLibrary
              imagePicker.allowsEditing = false
              speechSynthesizer.delegate = self
       
        
        getBudgetDataDB()
       // getStoreDataDB()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       //// getBudgetDataDB()
       getStoreDataDB()
        
    }
    

   

}


extension MainVC: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        //finish utter
    }
    
}
