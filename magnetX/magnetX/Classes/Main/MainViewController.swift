//
//  MainViewController.swift
//  magnetX
//
//  Created by hsuyelin on 2018/5/24.
//  Copyright © 2018年 hsuyelin. All rights reserved.
//

import UIKit
import Foundation
import SnapKit

class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCustomChildVC()
    }
    
    private func setupCustomChildVC() {
        /// 热门
        let hotNav = UINavigationController(rootViewController: HotViewController())
        hotNav.navigation.configuration.isEnabled = true
        hotNav.navigationBar.barStyle = .black
        hotNav.tabBarItem = UITabBarItem(title: "热门", image: #imageLiteral(resourceName: "tabbar_hot_normal").originalImage, selectedImage: #imageLiteral(resourceName: "tabbar_hot_selected").originalImage)
        
        /// 推荐
        let recommendNav = UINavigationController(rootViewController: RecommendViewController())
        recommendNav.navigation.configuration.isEnabled = true
        recommendNav.navigationBar.barStyle = .black
        recommendNav.tabBarItem = UITabBarItem(title: "推荐", image: #imageLiteral(resourceName: "tabbar_rec_normal").originalImage, selectedImage: #imageLiteral(resourceName: "tabbar_rec_selected").originalImage)
        
        /// 搜索
        let searchNav = UINavigationController(rootViewController: SearchViewController())
        searchNav.navigation.configuration.isEnabled = true
        searchNav.navigationBar.barStyle = .black
        searchNav.tabBarItem = UITabBarItem(title: "找片", image: #imageLiteral(resourceName: "tabbar_discover_normal").originalImage, selectedImage: #imageLiteral(resourceName: "tabbar_discover_selected").originalImage)
        
        /// 我
        let personalNav = UINavigationController(rootViewController: PersonalViewController())
        personalNav.navigation.configuration.isEnabled = true
        personalNav.navigationBar.barStyle = .black
        personalNav.tabBarItem = UITabBarItem(title: "我的", image: #imageLiteral(resourceName: "tabbar_profile_normal").originalImage, selectedImage: #imageLiteral(resourceName: "tabbar_profile_selected").originalImage)
        
        tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.normal, .font: UIFont.systemFont(ofSize: 10)], for: .normal)
        tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.selected, .font: UIFont.systemFont(ofSize: 10)], for: .selected)
        viewControllers = [hotNav, recommendNav, searchNav, personalNav]
    }
}
