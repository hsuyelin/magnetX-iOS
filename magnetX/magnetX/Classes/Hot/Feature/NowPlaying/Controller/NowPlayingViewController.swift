//
//  NowPlayingViewController.swift
//  magnetX
//
//  Created by hsuyelin on 2018/5/28.
//  Copyright © 2018年 hsuyelin. All rights reserved.
//

import Foundation

class NowPlayingViewController: BaseViewController {
    
    private lazy var listView: UITableView = {
        let listView = UITableView(frame: CGRect.zero, style: .plain)
        listView.backgroundColor = UIColor.white
        listView.delegate = self
        listView.dataSource = self
        listView.separatorStyle = .none
        listView.rowHeight = 125.rpx
        listView.register(CommonMovieCell.self, forCellReuseIdentifier: "CommonMovieCell")
//        listView.mj_header = MJRefreshNormalHeader()
//        listView.mj_footer = MJRefreshBackNormalFooter()
        return listView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        disableAdjustsScrollViewInsets(listView)
        addSubViews()
        setupNavigationItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupNavigationItem() {
        navigation.item.leftBarButtonItem = nil
    }
    
    private func addSubViews() {
        view.addSubview(listView)
        let tabbarHeight: CGFloat = YL_IS_IPHONEX ? 83.0 : 44.0
        listView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(44.0)
            make.left.right.equalToSuperview()
            make.height.equalTo(UIScreen.height - tabbarHeight - yl_navWithStatusBarHeight - 44.0)
        }
    }
}

extension NowPlayingViewController: UITableViewDelegate {
    
    /// MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension NowPlayingViewController: UITableViewDataSource {
    
    // MARK: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 25
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommonMovieCell", for: indexPath)
        configureCell(cell: cell, forRowAt: indexPath)
        return cell
    }
    
    func configureCell(cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
}

