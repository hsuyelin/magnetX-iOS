//
//  UIScrollView+Rx.swift
//  magnetX
//
//  Created by hsuyelin on 2018/5/30.
//  Copyright © 2018年 hsuyelin. All rights reserved.
//

import RxSwift
import RxCocoa

extension Reactive where Base: UITableView {
    
    var deselectRow: Binder<IndexPath> {
        return Binder(base) { tableView, indexPath in
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
