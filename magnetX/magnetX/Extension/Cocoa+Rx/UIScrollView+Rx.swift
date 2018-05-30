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
    
    var isEditing: Binder<Bool> {
        return Binder(base) { tableView, isEditing in
            tableView.setEditing(isEditing, animated: true)
        }
    }
    
    var deselectRow: Binder<IndexPath> {
        return Binder(base) { tableView, indexPath in
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}

extension Reactive where Base: UIScrollView {
    
    var bounces: Binder<Bool> {
        return Binder(base) { scrollView, bounces in
            scrollView.bounces = bounces
        }
    }
}
