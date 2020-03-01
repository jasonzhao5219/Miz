//
//  FirstViewController.swift
//  miz_test
//
//  Created by Jason Zhao on 2/25/20.
//  Copyright © 2020 Jason Zhao. All rights reserved.
//

import UIKit

import Alamofire



class ExploreViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    
    
    

    

    
    
    var NSArrayInExplore : NSArray = [String]() as NSArray
    
    
    private let networkingClient = NetworkingClient()
    
    var Descriptions = [String]()
    var Explore_Name = [String]()
    var FinalName = ""
    var Explore_Score = [String]()
    var Explore_Price = [String]()
    var Explore_Distance = [String]()
    var Explore_Category = [String]()
    var tempSomething : NSDictionary?
    var ScoreLabelColor = [Int]()
   
    @IBOutlet weak var ExploreCollectionView: UICollectionView!
    
    
    override func loadView() {
        super.loadView()
        
        let url = "http://ios-test-proj.mizo.co/preview_load"
        networkingClient.execute(url){ NSArray in
        self.NSArrayInExplore = NSArray
         print ("i got it \(self.NSArrayInExplore)")

         //print ("let me see: \(self.Explore_Name)")
            DispatchQueue.main.async {
                
                for  i in 0..<self.NSArrayInExplore.count{
                    if let tempSpecific = NSArray[i] as? NSDictionary{
                        print ("hi: \(tempSpecific)")
                            
                        if let tempName = tempSpecific["name"]{
                            self.Explore_Name.append(tempName as! String)
                        }
                        
                        if let tempDes = tempSpecific["description"] as? String   {
                            self.Descriptions.append(tempDes)
                        }else{
                            print("des null happened!")
                            self.Descriptions.append("   nothing here,The Emperor's New Clothes   ")
                        }
                       
                        if let tempCateg = tempSpecific["category"] as? String   {
                            self.Explore_Category.append(tempCateg)
                        }else{
                            print("category null happened!")
                            self.Explore_Category.append("none")
                        }
                        
                        if let tempPrice = tempSpecific["price"] as? Double   {
                            self.Explore_Price.append("$ \(String(tempPrice))")
                        }else{
                            print("PRICE null happened!")
                            self.Explore_Price.append("unkonw")
                        }
                        
                       
                        self.tempSomething = tempSpecific["score"] as? NSDictionary

                        if let deepTempScore = self.tempSomething?["value"] as? Double{
                            self.ScoreLabelColor.append(1)
                                self.Explore_Score.append("\(String(deepTempScore))% Match")
                        }else{
                                print("score null happened!")
                            self.Explore_Score.append(String(0))
                            self.ScoreLabelColor.append(0)
                            }
                           // self.Explore_Score.append(tempScore)
                        
                        self.tempSomething = tempSpecific["place"] as? NSDictionary
                        
                        if let deepTempDistance = self.tempSomething?["distance_miles"] as? Double{
                            self.Explore_Distance.append("\(String(deepTempDistance)) Miles")
                        }else{
                            self.Explore_Distance.append("unkown")
                        }
                        
                                                                   }
                   

                }
                print("final downcast test: \(self.Explore_Score) ")
                self.ExploreCollectionView.reloadData()
                }
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ExploreCollectionView.dataSource = self
        ExploreCollectionView.delegate = self
       // ExploreCollectionView.prefetchDataSource = self
        }
        

        
    override func viewWillAppear(_ animated: Bool) {
       // print("globa variable test: \(self.Explore_Name)")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //self.ExploreCollectionView.reloadData()
        print("hi hi hi \(self.Explore_Name.count)")
        
        return self.Explore_Name.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = ExploreCollectionView.dequeueReusableCell(withReuseIdentifier: "ExploreCell", for: indexPath) as! CollectionViewCell
        
        cell.food_name_label.text = self.Explore_Name[indexPath.row]
        cell.Description.text = self.Descriptions[indexPath.row]
        cell.CategoryLabel.text = self.Explore_Category[indexPath.row]
        cell.PriceLabel.text = String(self.Explore_Price[indexPath.row])
        cell.ScoreLabel.text = self.Explore_Score[indexPath.row]
        cell.DistanceLabel.text = self.Explore_Distance[indexPath.row]
        if self.ScoreLabelColor[indexPath.row] == 1 {
            cell.ScoreLabel.backgroundColor = UIColor.green
        }
       
        
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

//extension ExploreViewController: UICollectionViewDataSourcePrefetching {
//  func collectionView(_ collectionView: UICollectionView,
//      prefetchItemsAt indexPaths: [IndexPath]) {
//    print("Prefetch: !!!!!!!!!!")
//  }
//}
