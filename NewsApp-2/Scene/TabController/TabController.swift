//
//  TabController.swift
//  NewsApp-2
//
//  Created by Fatih on 31.01.2024.
//

import Foundation
import UIKit

class TabController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let homeViewsController = UINavigationController(rootViewController: HomeNewsController())
        let saveNewsController = UINavigationController(rootViewController: SaveNewsController())
        homeViewsController.tabBarItem.image = UIImage(systemName: "house.fill")
        saveNewsController.tabBarItem.image = UIImage(systemName: "square.and.arrow.down")
        
        homeViewsController.title = "Home"
        saveNewsController.title = "Save"
        
        self.setViewControllers([homeViewsController, saveNewsController], animated: false)
        
        
        self.tabBar.tintColor = .white
        self.tabBar.barTintColor = UIColor(red: 4/255.0, green: 13/255.0, blue: 18/255.0, alpha: 1.0)
        
        
    }
    
}
