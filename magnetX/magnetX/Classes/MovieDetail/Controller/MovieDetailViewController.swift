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
    var originalRect: CGRect = CGRect()
    private let disposeBag = DisposeBag()
    
    private lazy var tableHeaderView: MovieDetailHeaderView = {
        let tableHeaderView = MovieDetailHeaderView.init(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.width, height: UIScreen.width + yl_statusBarHeight))
        originalRect = tableHeaderView.frame
        return tableHeaderView
    }()
    
    private lazy var scaleHeaderView: UIImageView = {
        let scaleHeaderView = UIImageView.init(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.width, height: UIScreen.width + yl_statusBarHeight))
        scaleHeaderView.contentMode = .scaleAspectFill
        scaleHeaderView.clipsToBounds = true
        return scaleHeaderView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.rowHeight = 125.rpx
        tableView.isSkeletonable = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView.tableHeaderView = tableHeaderView
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        disablesAdjustScrollViewInsets(tableView)
        setupNavigationItem()
        addSubViews()
        loadPoster()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupNavigationItem() {
        navigation.item.title = "电影"
        navigation.bar.alpha = 0
    }
    
    private func addSubViews() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        tableHeaderView.insertSubview(scaleHeaderView, at: 0)
        
        let rateAreaView = MovieRateAreaView.init(frame: CGRect(x: 100, y: 100, width: 85.rpx, height: 85.rpx))
        view.addSubview(rateAreaView)
    }
    
    private func loadPoster() {
        let resource = ImageResource(downloadURL: URL(string: thumbnailUrl + posterURL)!)
        KingfisherManager.shared.retrieveImage(with: resource, options: nil, progressBlock: nil) { (image, error, cacheType, imageURL) in
            if error == nil {
                guard let dominantColor = ColorThief.getColor(from: image!) else {
                    return
                }
                self.navigation.bar.backgroundColor = dominantColor.makeUIColor()
                self.tableHeaderView.loadPosterImage(image: image)
                self.scaleHeaderView.backgroundColor = dominantColor.makeUIColor()
            }
            else {
                self.scaleHeaderView.image = #imageLiteral(resourceName: "img_poster_placeholder")
            }
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
        let myCustomSelectionColorView = UIView()
        myCustomSelectionColorView.backgroundColor = UIColor.cellHighlightedColor
        cell.selectedBackgroundView = myCustomSelectionColorView
        return cell
    }
}

extension MovieDetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY: CGFloat = scrollView.contentOffset.y
        if offsetY < 0 {
            scaleHeaderView.frame = CGRect.init(x: originalRect.origin.x, y: offsetY, width: UIScreen.width, height: UIScreen.width + yl_statusBarHeight - offsetY)
        }
    }
}
