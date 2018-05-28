//
//  HotViewController.swift
//  magnetX
//
//  Created by hsuyelin on 2018/5/28.
//  Copyright © 2018年 hsuyelin. All rights reserved.
//

import UIKit
import Foundation
import LTScrollView

class HotViewController: BaseViewController {
    
    private lazy var viewControllers: [UIViewController] = {
        let nowPlayingVC = NowPlayingViewController()
        let upComingVC = UpComingViewController()
        return [nowPlayingVC, upComingVC]
    }()
    
    private lazy var titles: [String] = {
        return ["正在热映", "即将上映"]
    }()
    
    private lazy var layout: LTLayout = {
        let layout = LTLayout()
        layout.titleViewBgColor = UIColor.white
        layout.titleColor = UIColor(r: 133.0, g: 133.0, b: 133.0)
        layout.titleSelectColor = UIColor(r: 56.0, g: 56.0, b: 56.0)
        layout.titleFont = UIFont.systemFont(ofSize: 15.0)
        layout.bottomLineColor = UIColor.selected
        layout.pageBottomLineColor = UIColor(r: 230.0, g: 230.0, b: 230.0)
        layout.scale = 1.08
        layout.sliderHeight = 45.0
        layout.isAverage = true
        return layout
    }()
    
    private lazy var pageView: LTAdvancedManager = {
        let Y: CGFloat = glt_navWithStatusBarHeight
        let H: CGFloat = UIScreen.height - Y
        let pageView = LTAdvancedManager(frame: CGRect(x: 0.0, y: Y, width: UIScreen.width, height: H), viewControllers: viewControllers, titles: titles, currentViewController: self, layout: layout, headerViewHandle: { () -> UIView in
            return UIView()
        })
        pageView.hoverY = glt_navWithStatusBarHeight
        pageView.delegate = self
        return pageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItem()
        pageManagerConfig()
        addSubViews()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupNavigationItem() {
        navigation.item.leftBarButtonItem = nil
        navigation.item.title = "热门"
    }
    
    private func addSubViews() {
        view.addSubview(pageView)
    }
}

extension HotViewController: LTAdvancedScrollViewDelegate {

    private func pageManagerConfig() {
        /// MARK: pageView点击事件
        pageView.advancedDidSelectIndexHandle = {
            print("选中了 -> \($0)")
        }
    }
}
