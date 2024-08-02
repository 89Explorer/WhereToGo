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
        
        configureTabBar()
    }
    
    
    // MARK: Functions
    private func configureTabBar() {
        
        let homeVC = UINavigationController(rootViewController: HomeViewController())
        let searchVC = UINavigationController(rootViewController: SearchViewController())
        let favoriteVC = UINavigationController(rootViewController: FavoriteViewController())
        let planVC = UINavigationController(rootViewController: PlanViewController())
        let profileVC = UINavigationController(rootViewController: ProfileViewController())
        
        homeVC.tabBarItem.image = UIImage(systemName: "house")
        searchVC.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        favoriteVC.tabBarItem.image = UIImage(systemName: "bookmark")
        planVC.tabBarItem.image = UIImage(systemName: "calendar")
        profileVC.tabBarItem.image = UIImage(systemName: "person")
        
        homeVC.title = "Home"
        searchVC.title = "Search"
        favoriteVC.title = "Bookmark"
        planVC.title = "Plan"
        profileVC.title = "Profile"
        
        tabBar.tintColor = .label
        // tabBar.backgroundColor = .systemBackground
        
        setViewControllers([homeVC, searchVC, planVC, favoriteVC, profileVC], animated: true)
    }
}
