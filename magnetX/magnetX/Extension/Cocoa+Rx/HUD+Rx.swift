//
//  HUD+Rx.swift
//  magnetX
//
//  Created by hsuyelin on 2018/5/31.
//  Copyright © 2018年 hsuyelin. All rights reserved.
//

import RxSwift
import RxCocoa

extension HUD: ReactiveCompatible {}

extension Reactive where Base: HUD {
    
    static var state: Binder<UIState> {
        return Binder(UIApplication.shared) { _, state in
            switch state {
            case .idle:
                break
            case .loading:
                HUD.show()
            case .success(let info):
                if let info = info {
                    HUD.showInfo(info: info)
                }
                else {
                    HUD.dismiss()
                }
            case .failure(let info):
                if let info = info {
                    HUD.showInfo(info: info)
                }
                else {
                    HUD.dismiss()
                }
            }
        }
    }
}
