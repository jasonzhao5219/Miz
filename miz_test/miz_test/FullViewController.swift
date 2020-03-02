//
//  FullViewController.swift
//  miz_test
//
//  Created by Jason Zhao on 2/29/20.
//  Copyright © 2020 Jason Zhao. All rights reserved.
//

import UIKit
import Alamofire
class FullViewController: UIViewController,PassValueDelegate {
    func ListToFull(PassFirst: String) {
        
    }
    

    
    @IBAction func BackBtnPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    var FullPageParameters = 10
    var FullPageDowncasted : NSArray?
    var NSArrayInFullPage : NSArray = [String]() as NSArray
    
    private let networkingClientInFullPage = NetworkingClient()
    
  


    
    
    func executeInFullPage(_ url: String,itemId:String ) {
               let parameters: [String: String] = [
                   "item_id": itemId

               ]

               
                AF.request(url,parameters: parameters).validate(statusCode: 200..<600).responseString{ response in
                        debugPrint(response)
        }
               
          }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        print("i have been map")
        //print("the item id I selected is: \(self.FullPageParameters)")
        let url = "http://ios-test-proj.mizo.co/load"
        let finalID = "test_id_\(self.FullPageParameters)"
       // executeInFullPage(url,itemId: finalID)
        print("test in full page One: \(self.NSArrayInFullPage)")
      
        
        //load image
//        AF.download("https://httpbin.org/image/png").responseData { response in
//            if let data = response.value {
//                DispatchQueue.main.async{
//                   // self.BigImage.image = UIImage(data: data)
//                }
//                    
//                }
//                
//            }
        }
        
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
