//
//  MainViewController.swift
//  magnetX
//
//  Created by hsuyelin on 2018/5/24.
//  Copyright © 2018年 hsuyelin. All rights reserved.
//

import UIKit
import SnapKit

class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCustomChildVC()
    }
    
    private func setupCustomChildVC() {
        /// 推荐
        let recommendNav = UINavigationController(rootViewController: RecommendViewController())
        recommendNav.navigation.configuration.isEnabled = true
        recommendNav.navigationBar.barStyle = .black
        recommendNav.tabBarItem = UITabBarItem(title: "推荐", image: #imageLiteral(resourceName: "tabbar_rec_normal").originalImage, selectedImage: #imageLiteral(resourceName: "tabbar_rec_selected").originalImage)
        
        /// 搜索
        let searchNav = UINavigationController(rootViewController: SearchViewController())
        searchNav.navigation.configuration.isEnabled = true
        searchNav.navigationBar.barStyle = .black
        searchNav.tabBarItem = UITabBarItem(title: "找片", image: #imageLiteral(resourceName: "tabbar_search_normal").originalImage, selectedImage: #imageLiteral(resourceName: "tabbar_search_selected").originalImage)
        
        /// 我
        let personalNav = UINavigationController(rootViewController: PersonalViewController())
        personalNav.navigation.configuration.isEnabled = true
        personalNav.navigationBar.barStyle = .black
        personalNav.tabBarItem = UITabBarItem(title: "我", image: #imageLiteral(resourceName: "tabbar_profile_normal").originalImage, selectedImage: #imageLiteral(resourceName: "tabbar_profile_selected").originalImage)
        
        tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor(hex: "#888888"), .font: UIFont.systemFont(ofSize: 10)], for: .normal)
        tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor(hex: "#09BB07"), .font: UIFont.systemFont(ofSize: 10)], for: .selected)
        viewControllers = [recommendNav, searchNav, personalNav]
    }
}
