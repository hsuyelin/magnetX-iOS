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
import FDTemplateLayoutCell
import RxDataSources
import RxSwift
import RxSwiftX

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
        if let movieName = parameters["movieName"] as? String {
            movideDetailVC.movieName = movieName
        }
        return movideDetailVC
    }
    
    var id: String = ""
    var posterURL: String = ""
    var movieName: String = ""
    var originalRect: CGRect = CGRect()
    private let disposeBag = DisposeBag()
    
    private var overViewModel = MovieDetailOverViewModel.init(isExpanded: false, content: "", contentHeight: 90.rpx)
    
    private lazy var iconAndTextView: UIButton = {
        let iconAndTextView = UIButton.init(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.width - 100.rpx, height: 44.rpx))
        iconAndTextView.setImage(#imageLiteral(resourceName: "ic_nav_movie_white"), for: UIControlState.normal)
        iconAndTextView.setTitle("电影", for: UIControlState.normal)
        iconAndTextView.setTitleColor(UIColor.white, for: UIControlState.normal)
        iconAndTextView.titleLabel?.font = UIFont.systemFont(ofSize: 17.rpx)
        iconAndTextView.titleEdgeInsets = UIEdgeInsetsMake(0.0, 8.0, 0.0, 0.0)
        return iconAndTextView
    }()
    
    private lazy var onlyTextView: UIButton = {
        let onlyTextView = UIButton.init(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.width - 100.rpx, height: 44.rpx))
        onlyTextView.setTitle(movieName, for: UIControlState.normal)
        onlyTextView.setTitleColor(UIColor.white, for: UIControlState.normal)
        onlyTextView.titleLabel?.font = UIFont.systemFont(ofSize: 17.rpx)
        return onlyTextView
    }()
    
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
        tableView.estimatedRowHeight = 125.rpx
        tableView.isSkeletonable = true
        tableView.register(MovieDetailInfoCell.self, forCellReuseIdentifier: "MovieDetailInfoCell")
        tableView.register(MovieDetailOverViewCell.self, forCellReuseIdentifier: "MovieDetailOverViewCell")
        tableView.tableHeaderView = tableHeaderView
        let footerView: UIView =  UIView.init(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.width, height: 1000.rpx))
        footerView.backgroundColor = UIColor.white
        tableView.tableFooterView = footerView
        return tableView
    }()
    
    private lazy var dataSource: RxTableViewSectionedReloadProxy<MovieDetailListModel> = {
        RxTableViewSectionedReloadProxy<MovieDetailListModel>(configureCell: { (_, tableView, indexPath, item) -> UITableViewCell in
            if indexPath.section == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDetailInfoCell", for: indexPath) as! MovieDetailInfoCell
                cell.bindItem(item)
                return cell
            }
            else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDetailOverViewCell", for: indexPath) as! MovieDetailOverViewCell
                cell.bindItem(item)
                cell.didClickExpandHandler = {[weak self] contentHeight in
                    if let strongSelf = self {
                        strongSelf.overViewModel.isExpanded = !strongSelf.overViewModel.isExpanded
                        strongSelf.overViewModel.contentHeight = contentHeight
                        strongSelf.tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.fade)
                    }
                }
                return cell
            }
        }, heightForRowAtIndexPath: {[weak self] _, indexPath, item in
            if indexPath.section == 0 {
                return 125.rpx
            }
            else {
                if let strongSelf = self {
                    if strongSelf.overViewModel.isExpanded == false {
                        return 125.rpx
                    }
                    else {
                        return strongSelf.overViewModel.contentHeight
                    }
                }
                else {
                    return CGFloat.leastNormalMagnitude
                }
            }
            }, heightForHeaderInSection: { _, _ in
                return CGFloat.leastNormalMagnitude
        }, heightForFooterInSection: { _, _ in
            return CGFloat.leastNormalMagnitude
        })
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        disablesAdjustScrollViewInsets(tableView)
        setupNavigationItem()
        addSubViews()
        loadPoster()
        bindViewModel()
        scrollHandler()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupNavigationItem() {
        navigation.item.titleView = iconAndTextView
        navigation.bar.alpha = 0
    }
    
    private func addSubViews() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        tableHeaderView.insertSubview(scaleHeaderView, at: 0)
    }
    
    private func loadPoster() {
        let resource = ImageResource(downloadURL: URL(string: posterURL)!)
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
    
    private func bindViewModel() {
        let viewModel = MovieDetailViewModel()
        let input = MovieDetailViewModel.Input(target: Observable.of(MoviesTarget.getDetails(id: self.id)))
        let output = viewModel.transform(input)
        output.items.drive(tableView.rx.items(proxy: dataSource)).disposed(by: disposeBag)
    }
    
    private func scrollHandler() {
        tableView.rx.contentOffset.subscribeNext(weak: self) { (self) -> (CGPoint) -> Void in { contentOffset in
            let offsetY: CGFloat = contentOffset.y
            let alpha: CGFloat = offsetY >= UIScreen.width - CGFloat(yl_navHeight) ? 1.0 : offsetY / (UIScreen.width - CGFloat(yl_navHeight))
            if offsetY < 0 {
                self.scaleHeaderView.frame = CGRect.init(x: self.originalRect.origin.x, y: offsetY, width: UIScreen.width, height: UIScreen.width + yl_statusBarHeight - offsetY)
            }
            else {
                self.navigation.bar.alpha = alpha
                
                if offsetY > 365.0 {
                    self.navigation.item.titleView = self.onlyTextView
                }
                else {
                    self.navigation.item.titleView = self.iconAndTextView
                }
            }
            }}.disposed(by: disposeBag)
    }
}
