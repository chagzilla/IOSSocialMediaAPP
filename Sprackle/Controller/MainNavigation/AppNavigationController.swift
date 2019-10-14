//
//  AppNavigationController.swift
//  Sprackle
//
//  Created by Wilbert Chagula on 1/12/19.
//  Copyright © 2019 Wilbert Chagula. All rights reserved.
//

import UIKit
import FirebaseAuth

class AppNavigationController: UITabBarController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
            
            let ProfileViewController = ProfilePage()
            ProfileViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 0)
            let EventsViewController = EventsPage()
            EventsViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .mostViewed, tag: 0)
            let SearchViewController = SearchPage()
            SearchViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
            let InboxController = InboxViewController()
            InboxController.tabBarItem = UITabBarItem(tabBarSystemItem: .mostRecent, tag: 0)
            
            let viewControllerList = [ ProfileViewController, EventsViewController, SearchViewController, InboxController]
            self.viewControllers = viewControllerList.map { UINavigationController(rootViewController: $0) }
       
         
        
            
        
        
    
        
        
        
        

        
 
        // Do any additional setup after loading the view.
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
