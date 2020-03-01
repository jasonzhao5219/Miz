//
//  NetworkingClient.swift
//  miz_test
//
//  Created by Jason Zhao on 2/27/20.
//  Copyright © 2020 Jason Zhao. All rights reserved.
//

import Foundation
import Alamofire

class NetworkingClient {
    var resultCategory = ""
    var DownCastedValue : NSArray = ["aa",42]
    typealias WebServiceResponse = (NSArray) -> Void

    func execute(_ url: String ,completion: @escaping WebServiceResponse) {
        
        AF.request(url,encoding:
        JSONEncoding.default).validate().responseJSON{ response in
            print("may i here")
           //print("test: \(response.result)")
            switch response.result {
            case .success(let value):
                // print("the value is : \(value)")
                 let tempone = value as! NSArray
              //   print("what is tempone: \(tempone[0])")
                 self.DownCastedValue = tempone
             
                 
                break
            //success, do anything
            case .failure(let error):
               print("erro happen during connect to API :  \(error)")
                break
            //failure
            }
         
            if let jsonArray = self.DownCastedValue as? NSArray{
                completion(jsonArray)
            }
           //  print("what is self Downcastvalue :  \(self.DownCastedValue[0])")
//                 if let resultSpecific = self.DownCastedValue[0] as? NSDictionary{
//                     self.resultCategory = resultSpecific["category"] as! String
//
//                 }
//            print ("give me category?: \(self.resultCategory   )")
            
 
        }
        print("give me downcast value: \(self.DownCastedValue[0])")
       
  }
}
