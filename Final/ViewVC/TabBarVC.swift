//
//  ViewController.swift
//  Final
//
//  Created by Huseyn Hasanov on 02.04.22.
//

import UIKit

class TabBarVC: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
                if let tabBarItem1 = self.tabBarController?.tabBar.items?[0] {
                    tabBarItem1.image = UIImage(systemName: "house")
                    tabBarItem1.selectedImage = UIImage(systemName: "house.fill")
                }
        if let tabBarItem1 = self.tabBarController?.tabBar.items?[1] {
            tabBarItem1.image = UIImage(systemName: "bookmark")
            tabBarItem1.selectedImage = UIImage(systemName: "bookmark.fill")
        }
    }
}
