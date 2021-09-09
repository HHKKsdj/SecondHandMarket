//
//  TabBarViewController.swift
//  Demo
//
//  Created by HK on 2021/4/15.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalPresentationStyle = .fullScreen
        // Do any additional setup after loading the view.
        self.modalPresentationStyle = .fullScreen
        self.view.backgroundColor = UIColor.white
        tabBar.tintColor = UIColor.black
        tabBar.barTintColor = UIColor.white
        self.addChildVC(childVC: HomeViewController(), title: "首页",imageName: "Home1",selectedImageName: "Home2")
        self.addChildVC(childVC: MessageViewController(), title: "消息",imageName: "Message1",selectedImageName: "Message2")
//        self.addChildVC(childVC: AddViewController(), title: "发布")
        self.addChildVC(childVC: ShoppingCartViewController(), title: "购物车",imageName: "ShoppingCart1",selectedImageName: "ShoppingCart2")
        self.addChildVC(childVC: MineViewController(), title: "我的",imageName: "Mine1",selectedImageName: "Mine2")
    }
    
    func addChildVC(childVC:UIViewController, title:String, imageName:String, selectedImageName:String) {
        let navigationVC = UINavigationController(rootViewController: childVC)
        navigationVC.navigationBar.tintColor = UIColor.black
        navigationVC.navigationBar.barTintColor = UIColor.white
        
//        let cancel : UIBarButtonItem!
        
//        navigationVC.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(back))
        
        childVC.title = title
        childVC.tabBarItem.tag = 1
        childVC.tabBarItem.image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
        childVC.tabBarItem.selectedImage = UIImage(named: selectedImageName)?.withRenderingMode(.alwaysOriginal)
        childVC.tabBarItem.imageInsets = UIEdgeInsets(top: 5,left: 0,bottom: -5,right: 0)
        
        
//        self.addChild(childVC)
        self.addChild(navigationVC)
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
