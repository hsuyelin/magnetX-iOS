//
//  SearchViewController.swift
//  magnetX
//
//  Created by hsuyelin on 2018/5/24.
//  Copyright © 2018年 hsuyelin. All rights reserved.
//

import UIKit
import Foundation

class SearchViewController: BaseViewController, Routable {
    static func registerRoute(parameters: [String : Any]?) -> Routable {
        return SearchViewController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupNavigationItem() {
        navigation.item.leftBarButtonItem = nil
        navigation.item.title = "找片"
    }
}
