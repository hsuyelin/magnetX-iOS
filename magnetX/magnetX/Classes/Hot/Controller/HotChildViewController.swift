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
import RxDataSources
import CocoaChainKit
import SkeletonView
import RxSwiftX

enum HotType: String {
    case nowPlaying
    case upComing
}

class HotChildViewController: BaseViewController {
    
    private var hotType: HotType = .nowPlaying

    private var target: MoviesTarget {
        switch hotType {
        case .nowPlaying:
            return MoviesTarget.getNowPlaying(startIndex: startIndex)
        case .upComing:
            return MoviesTarget.getUpComing(startIndex: startIndex)
        }
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .none
        tableView.rowHeight = 125.rpx
        tableView.register(HotMovieCell.self, forCellReuseIdentifier: "HotMovieCell")
        tableView.mj_header = MJRefreshNormalHeader()
        tableView.mj_footer = MJRefreshBackNormalFooter()
        return tableView
    }()
    
    private lazy var dataSource: RxTableViewSectionedReloadDataSource<HotMovieListModel> = {
        RxTableViewSectionedReloadDataSource<HotMovieListModel>(configureCell: { (_, tableView, indexPath, item) -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: "HotMovieCell", for: indexPath) as! HotMovieCell
            cell.bindItem(item)
            return cell
        })
    }()
    
    private let disposeBag = DisposeBag()
    private var startIndex = 0
    
    // MARK: - life cycle
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
        disablesAdjustScrollViewInsets(tableView)
        addSubViews()
        bindViewModel()
        didSelectRow()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: private
    private func setupNavigationItem() {
        navigation.item.leftBarButtonItem = nil
    }
    
    private func addSubViews() {
        view.addSubview(tableView)
        let tabbarHeight: CGFloat = YL_IS_IPHONEX ? 83.0 : 44.0
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(44.0)
            make.left.right.equalToSuperview()
            make.height.equalTo(UIScreen.height - tabbarHeight - yl_navWithStatusBarHeight - 44.0)
        }
        tableView.mj_header.beginRefreshing()
    }

    private func bindViewModel() {
        let viewModel = HotMovieViewModel()
        let refresh = tableView.mj_header.rx.refreshing.shareOnce()
        let more = tableView.mj_footer.rx.refreshing.shareOnce()
        let input = HotMovieViewModel.Input(refresh: refresh,
                                               more: more,
                                               type: Observable.of(hotType))
        let output = viewModel.transform(input)
        output.items.drive(tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)

        output.refreshState.map(to: ()).drive(tableView.mj_header.rx.endRefreshing).disposed(by: disposeBag)
        output.moreState.map(to: ()).drive(tableView.mj_footer.rx.endRefreshing).disposed(by: disposeBag)
        
        output.refreshState.drive(HUD.rx.state).disposed(by: disposeBag)
        output.moreState.drive(HUD.rx.state).disposed(by: disposeBag)
    }
    
    private func didSelectRow() {
        tableView.rx.itemSelected.asDriver().drive(tableView.rx.deselectRow).disposed(by: disposeBag)
        tableView.rx.itemSelected.map { indexPath in
            return (indexPath, self.dataSource[indexPath])
        }
        .subscribe(onNext: { indexPath, model in
            print(model)
            print(XUtils.getCurrentRegion())
            self.push(MovieDetailViewController.self, parameters: ["id": model.id, "posterURL": model.images.medium, "movieName": model.title])
        })
        .disposed(by: disposeBag)
    }
}
