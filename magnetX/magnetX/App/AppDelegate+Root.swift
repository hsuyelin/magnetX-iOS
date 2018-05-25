//
//  AppDelegate+Root.swift
//  magnetX
//
//  Created by hsuyelin on 2018/5/24.
//  Copyright © 2018年 hsuyelin. All rights reserved.
//

import Foundation
import EachNavigationBar

extension AppDelegate: UITabBarControllerDelegate {
    
    func setRootViewController() {
        UIViewController.setupNavigationBar
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        let mainVC = MainViewController()
        mainVC.tabBar.tintColor = UIColor(hex: "09BB07")
        mainVC.delegate = self
        window?.rootViewController = mainVC
        window?.makeKeyAndVisible()
    }
}
