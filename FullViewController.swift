//
//  FullViewController.swift
//  miz_test
//
//  Created by Jason Zhao on 2/29/20.
//  Copyright © 2020 Jason Zhao. All rights reserved.
//

import UIKit
import Alamofire

var imageCache = [String:UIImage]()
var UrlCache = ""
public var FeeCache = ""
var DeliverWayCache = ""
var OrderMinimumCache = ""
var DeliverMaxTimeCache = ""
var DeliverMinTimeCache = ""
//let cacher = Cacher(behavior:.cache)
var timer = Timer()



class FullViewController: UIViewController,PassValueDelegate {
    func ListToFull(PassFirst: String) {
        
    }
    
   // var imageUrl = ""
    var duration = 0
    
    var NSDictInFull : NSDictionary = [String:String]() as NSDictionary
    var DownCastedInFull : NSDictionary = ["aa":"something"]
    
    @IBAction func BackBtnPressed(_ sender: UIButton) {

        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var BigImage: UIImageView!
    
    var FullPageParameters = 10
    var FullPageDowncasted : NSArray?
    var NSArrayInFullPage : NSArray = [String]() as NSArray
    
    private let networkingClientInFullPage = NetworkingClient()
    
  
//    func toggleTimer(){
//        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { [weak self](_) in
//            guard let strongSelf = self else {return}
//            strongSelf.duration += 1
//
//        })
//    }
    func counter(){
        print("counter running")
        duration += 1
    }
    
    func DowncastLabelData(){
        //fee
        guard let tempOverService = self.DownCastedInFull as? NSDictionary else{
            return
        }
       // print("test one: \(tempOverService)")
        guard let tempService = tempOverService["delivery_services"] else{
            return
        }

        guard let tempFee = tempService as? NSArray else{
            return
        }
        let tempTwoFee = tempFee[0]
        guard let tempThreeFee = tempTwoFee as? NSDictionary else{
            return
        }
        guard let tempFourFee = tempThreeFee["fee"] else{
            return
        }
        print ("test 2: \(tempFourFee)")
//        guard let finalFee = tempFourFee as? String else{
//            return
//        }
        if let finalFee = tempFourFee as? String {
            //print("hi \(finalFee)")
            FeeCache = finalFee
            print("suceess? \(finalFee)")
        }
    
 
        
        //miniue
//        guard let tempMinit = tempThreeFee["minimum_order"] else{
//            return
//        }
//        guard let finalMinit = tempMinit as? String else{
//            return
//        }
//        OrderMinimumCache = finalMinit
        
        //deliver way
//        guard let tempWay = tempThreeFee["name"] else{
//            return
//        }
//        guard let finalway = tempWay as? String else{
//            return
//        }
//        DeliverWayCache = finalway
        
        //MaxTime
        
//        guard let tempTimeMaxAdd = tempTwoFee as? NSDictionary else{
//            return
//        }
//        guard let tempMaxT = tempTimeMaxAdd["eta"] else{
//            return
//        }
//        guard let tempMaxTwo = tempMaxT as? NSDictionary else{
//            return
//        }
//        guard let tempMaxThree = tempMaxTwo["max"] else{
//            return
//        }
//        guard let finalMaxTime = tempMaxThree as? String else{
//            return
//
//        }

     
    }
    
    typealias WebServiceResponse = (NSDictionary) -> Void
    func executeInFullPage(_ url: String,itemId:String,completion: @escaping WebServiceResponse ) {
               let parameters: [String: String] = [
                   "item_id": itemId

               ]
        let cache = ResponseCacher(behavior: .cache)

        AF.request(url,parameters: parameters).validate(statusCode: 200..<600).cacheResponse(using: cache).responseJSON{ response in
                        print("may i here")
//            self.isTimerOn.toggle()
//            self.toggleTimer(on: self.isTimerOn)
                          //print("test: \(response.result)")
                           switch response.result {
                           case .success(let value):
                               // print("the value is : \(value)")
                                let tempone = value as! NSDictionary
                             //   print("what is tempone: \(tempone[0])")
                                self.DownCastedInFull = tempone


                               break
                           //success, do anything
                           case .failure(let error):
                              print("erro happen during connect to API :  \(error)")
                               break
                           //failure
                           }

                           if let jsonArray = self.DownCastedInFull as? NSDictionary{
                               completion(jsonArray)
                           }

        }
               
          }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        Timer.scheduledTimer(withTimeInterval: 7200, repeats: false, block: { [weak self](_) in
                    guard let strongSelf = self else {return}
                    strongSelf.counter()
        
                })
        
        print("i have been map")
        //print("the item id I selected is: \(self.FullPageParameters)")
        let url = "http://ios-test-proj.mizo.co/load"
        let finalID = "test_id_\(self.FullPageParameters)"
        
        
        
        executeInFullPage(url,itemId: finalID){NSDictionary in
            self.NSDictInFull = NSDictionary
           // print("parameter: \(self.FullPageParameters)")
          print("full one:  \(self.NSDictInFull)")
       

    
           
                if let tempOver = self.NSDictInFull as? NSDictionary{
              //Downcast image url
                    if   let temptwoUrl = tempOver["images"] {
                      //   print("test here \(temptwoUrl)")
                        if  let tempThreeUrl = temptwoUrl as? NSArray{
                           // print("test thempthree: \(tempThreeUrl[0])")
                             let tempFourUrl = tempThreeUrl[0]
                             if let tempFiveUrl = tempFourUrl as? NSDictionary{
                               // print("test tempFive: \(tempFiveUrl)")
                                if   let tempSixUrl = tempFiveUrl["url"] {
                                   // print("test final : \(tempSixUrl)")
                                    if let tempSevUrl = tempSixUrl as? String{
                                     //   print("test final II: \(tempSevUrl)")
                                        UrlCache = tempSevUrl
                                 //       print("?? \(self.imageUrl)")
                                    }
                                }
                            }
                        }
                }
            }

        

        //load image
           
                    AF.download(UrlCache).responseData { response in
                      if let data = response.value {
                          
                              // self.BigImage.image = UIImage(data: data)
                        let image = UIImage(data:data)
                        imageCache[String(self.FullPageParameters)] = image
                        
                        self.BigImage.image = imageCache[String(self.FullPageParameters)]
            
                
                        }
              
           }
        //run downcast
        self.DowncastLabelData()
            
        }

    }
    override func viewDidAppear(_ animated: Bool) {
       // print("may i be view did appear? \(self.duration)")
        //counter()
      //  print("again duration: \(self.duration)")

        
       
        
        if self.duration == 1 {
            print ("!!Timer works!!!")
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
