//
//  MovieDetailViewController.swift
//  magnetX
//
//  Created by hsuyelin on 2018/5/30.
//  Copyright © 2018年 hsuyelin. All rights reserved.
//

import UIKit
import Foundation

class MovieDetailViewController: BaseViewController, Routable {
    static func registerRoute(parameters: [String : Any]?) -> Routable {
        
        let movideDetailVC = MovieDetailViewController()
        guard let parameters = parameters else { return movideDetailVC }
        if let id = parameters["id"] as? String {
            movideDetailVC.id = id
        }
        return movideDetailVC
    }
    
    var id: String = ""
    private let disposeBag = DisposeBag()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.backgroundColor = UIColor.white
//        tableView.separatorStyle = .none
        tableView.rowHeight = 125.rpx
        tableView.isSkeletonable = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationItem()
        addSubViews()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupNavigationItem() {
        navigation.item.leftBarButtonItem = nil
        navigation.item.title = "电影"
        navigation.bar.alpha = 0
    }
    
    private func addSubViews() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: UITableViewDelegate
extension MovieDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

// MARK: UITableViewDataSource
extension MovieDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        configureCell(cell: cell, forRowAt: indexPath)
        return cell
    }
    
    func configureCell(cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
}
