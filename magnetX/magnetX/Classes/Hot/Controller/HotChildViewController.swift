//
//  HotChildViewController.swift
//  magnetX
//
//  Created by hsuyelin on 2018/5/29.
//  Copyright © 2018年 hsuyelin. All rights reserved.
//

import UIKit
import MJRefresh
import RxSwift
import RxCocoa

enum HotType: String {
    case nowPlaying
    case upComing
}

class HotChildViewController: BaseViewController {
    
    private var hotType: HotType = .nowPlaying

    private var target: MoviesTarget {
        switch hotType {
        case .nowPlaying:
            return MoviesTarget.nowPlaying(pageIndex: pageIndex)
        case .upComing:
            return MoviesTarget.upComing(pageIndex: pageIndex)
        }
    }
    
    private lazy var listView: UITableView = {
        let listView = UITableView(frame: CGRect.zero, style: .plain)
        listView.backgroundColor = UIColor.white
        listView.delegate = self
        listView.separatorStyle = .none
        listView.rowHeight = 125.rpx
        listView.register(CommonMovieCell.self, forCellReuseIdentifier: "CommonMovieCell")
        listView.mj_header = MJRefreshNormalHeader()
        listView.mj_footer = MJRefreshBackNormalFooter()
        return listView
    }()
    
    private lazy var dataSource: [CommonMovieModel] = {
        let dataSource: [CommonMovieModel] = []
        return dataSource
    }()
    
    private let disposeBag = DisposeBag()
    private var pageIndex = 1
    
    /// MARK: - life cycle
    convenience init(hotType: HotType) {
        self.init(nibName: nil, bundle: nil)
        self.hotType = hotType
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupNavigationItem()
        disablesAdjustScrollViewInsets(listView)
        addSubViews()
        bindViewModel()
        listView.mj_header.beginRefreshing()
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

    private func bindViewModel() {
        
    }
    
}

extension HotChildViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
