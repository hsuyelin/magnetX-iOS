//
//  RecommendViewController.swift
//  magnetX
//
//  Created by hsuyelin on 2018/5/24.
//  Copyright © 2018年 hsuyelin. All rights reserved.
//

import UIKit
import Foundation

class RecommendViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationItem()
        test()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupNavigationItem() {
        navigation.item.leftBarButtonItem = nil
        navigation.item.title = "推荐"
    }
    
    private func test() {
        MoviesTarget.getPopular.request(cache: { (response: HTTPResponse<[PopularModel]>) in
        }, success: { (response: HTTPResponse<[PopularModel]>) in
            if response.success {
                debugPrint("success")
            }
        }) { _ in
            
        }
    }
}
