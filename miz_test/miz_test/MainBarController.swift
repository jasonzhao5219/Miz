


import UIKit

class MainBarController: UITabBarController{
//    override func viewDidLoad(){
//        super.viewDidLoad()
//        print("i am here")
////        let nav = generateNavController(vc: ExploreViewController(), title:"first",image:#imageLiteral(resourceName: "download.png"))
////        let nav1 = generateNavController(vc: MapViewController(), title:"second",image: #imageLiteral(resourceName: "download.png"))
////        let nav2 = generateNavController(vc: RegisterViewController(), title:"third",image: #imageLiteral(resourceName: "download.png"))
////
////        UINavigationBar.appearance().prefersLargeTitles = true
////
////        viewControllers = [nav, nav1, nav2]
//    }

    fileprivate func generateNavController(vc: UIViewController, title: String,image:UIImage) ->
        UINavigationController{
            vc.navigationItem.title = title
            let navController = UINavigationController(rootViewController: vc)
            navController.title = title
            navController.tabBarItem.image = image
            return navController
    }
}
