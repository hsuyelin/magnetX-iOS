//
//  MovieDetailViewController.swift
//  magnetX
//
//  Created by hsuyelin on 2018/5/30.
//  Copyright © 2018年 hsuyelin. All rights reserved.
//

import UIKit
import Foundation
import Kingfisher
import ColorThiefSwift

class MovieDetailViewController: BaseViewController, Routable {
    static func registerRoute(parameters: [String : Any]?) -> Routable {
        
        let movideDetailVC = MovieDetailViewController()
        guard let parameters = parameters else { return movideDetailVC }
        if let id = parameters["id"] as? String {
            movideDetailVC.id = id
        }
        if let posterURL = parameters["posterURL"] as? String {
            movideDetailVC.posterURL = posterURL
        }
        return movideDetailVC
    }
    
    var id: String = ""
    var posterURL: String = ""
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
        let v1 = UIView.init(frame: CGRect(x: 15, y: 80, width: 50, height: 50))
        v1.backgroundColor = UIColor.red
        view.addSubview(v1)
        
        let v2 = UIView.init(frame: CGRect(x: 80, y: 80, width: 50, height: 50))
        v2.backgroundColor = UIColor.red
        view.addSubview(v2)
        
        let v3 = UIView.init(frame: CGRect(x: 145, y: 150, width: 50, height: 50))
        v3.backgroundColor = UIColor.red
        view.addSubview(v3)
        
        let imgView = UIImageView.init(frame: CGRect(x: 100, y: 100, width: 200, height: 300))
        imgView.backgroundColor = UIColor.red
        imgView.center = view.center
        view.addSubview(imgView)
        let url: URL = URL(string: thumbnailUrl + posterURL)!
        KingfisherManager.shared.downloader.downloadImage(with: url, retrieveImageTask: nil, options: nil, progressBlock: nil) { (image, error, url, data) in
            imgView.image = image
//            DispatchQueue.global(qos: .default).async {
//                guard let colors = ColorThief.getPalette(from: image!, colorCount: 10, quality: 1, ignoreWhite: true) else {
//                    return
//                }
                let start = Date()
                guard let dominantColor = ColorThief.getColor(from: image!) else {
                    return
                }
                let elapsed = -start.timeIntervalSinceNow
                NSLog("time for getColorFromImage: \(Int(elapsed * 1000.0))ms")
//                DispatchQueue.main.async { [weak self] in
                    self.navigation.bar.backgroundColor = dominantColor.makeUIColor()
//                    v1.backgroundColor = colors[0].makeUIColor()
//                    v2.backgroundColor = colors[1].makeUIColor()
//                    v3.backgroundColor = colors[2].makeUIColor()
//                }
//            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupNavigationItem() {
        navigation.item.leftBarButtonItem = nil
        navigation.item.title = "电影"
//        navigation.bar.alpha = 0
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
