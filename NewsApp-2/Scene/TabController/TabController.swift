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
        
        homeViewsController.title = "Home"
        saveNewsController.title = "Save"
        
        self.setViewControllers([homeViewsController, saveNewsController], animated: false)
        
        self.tabBarController?.tabBar.backgroundColor = .red
        
        
    }
    
}
