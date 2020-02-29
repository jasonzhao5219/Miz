//
//  FirstViewController.swift
//  miz_test
//
//  Created by Jason Zhao on 2/25/20.
//  Copyright © 2020 Jason Zhao. All rights reserved.
//

import UIKit

import Alamofire



class ExploreViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("hi hi hi \(self.Explore_Name.count)")
        return 3
    }
    

    
    
    var NSArrayInExplore : NSArray = ["bb"]
    
    let url = "http://ios-test-proj.mizo.co/preview_load"
    private let networkingClient = NetworkingClient()
    
    var Descriptions = ["aa"]
    var Explore_Name = ["1stfood"]
    
   
    @IBOutlet weak var ExploreCollectionView: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkingClient.execute(url){ NSArray in
           self.NSArrayInExplore = NSArray
           // print ("i got it \(self.NSArrayInExplore[0])")
            for  i in 0..<self.NSArrayInExplore.count{
                if let tempSpecific = NSArray[i] as? NSDictionary{
                  //  print ("hi: \(tempSpecific)")
                                     let tempName = tempSpecific["name"] as! String
                                    self.Explore_Name.append(tempName)
                 //    print ("hi: \(self.Explore_Name)")
                    
                                                               }
               

            }
            print ("let me see: \(self.Explore_Name)")
        }
        
        ExploreCollectionView.delegate = self
        ExploreCollectionView.dataSource = self
        
     
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = ExploreCollectionView.dequeueReusableCell(withReuseIdentifier: "ExploreCell", for: indexPath) as! CollectionViewCell
        
        //cell.food_name_label.text = "aaa"
        
        return cell
    }

    //view cell size
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: 375, height: 160)
        return size

    }
}
