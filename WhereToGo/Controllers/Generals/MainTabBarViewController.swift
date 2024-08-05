//
//  ViewController.swift
//  WhereToGo
//
//  Created by 권정근 on 8/1/24.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureTabBar()
    }
    
    
    // MARK: Functions
    private func configureTabBar() {
        
        let homeVC = UINavigationController(rootViewController: HomeViewController())
        let searchVC = UINavigationController(rootViewController: SearchViewController())
        let chatVC = UINavigationController(rootViewController: ChatViewController())
        let planVC = UINavigationController(rootViewController: PlanViewController())
        let profileVC = UINavigationController(rootViewController: ProfileViewController())
        
        homeVC.tabBarItem.image = UIImage(systemName: "house")
        searchVC.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        chatVC.tabBarItem.image = UIImage(systemName: "paperplane")
        planVC.tabBarItem.image = UIImage(systemName: "calendar")
        profileVC.tabBarItem.image = UIImage(systemName: "person")
        
        homeVC.title = "Home"
        searchVC.title = "Search"
        chatVC.title = "Chat"
        planVC.title = "Plan"
        profileVC.title = "Profile"
        
        tabBar.tintColor = .label
        // tabBar.backgroundColor = .systemBackground
        
        setViewControllers([homeVC, searchVC, planVC, chatVC, profileVC], animated: true)
    }
}
