//
//  BaseViewController.swift
//  magnetX
//
//  Created by hsuyelin on 2018/5/24.
//  Copyright © 2018年 hsuyelin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import EachNavigationBar

class BaseViewController: UIViewController {
    
    let baseDisposeBag = DisposeBag()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configBaseUIConfig()
        configureBaseNavigationBar()
    }
    
    deinit {
        debugPrint("\(type(of: self)) deinit")
        NotificationCenter.default.removeObserver(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - private
    private func configBaseUIConfig() {
        view.backgroundColor = UIColor(hex: "#F7F7F7")
    }
    
    private func configureBaseNavigationBar() {
        navigation.bar.backgroundColor = UIColor.global
        navigation.bar.tintColor = UIColor.white
        navigation.bar.isTranslucent = false
        navigation.bar.shadowImage = UIImage()
        navigation.bar.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 18)]
        navigation.item.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "nav_back_white").originalImage, style: .plain, target: self, action: #selector(backBarButtonAction))
    }
    
    @objc private func backBarButtonAction() {
        goBack()
    }
}

