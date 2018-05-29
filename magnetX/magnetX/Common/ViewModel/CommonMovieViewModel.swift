//
//  CommonMovieViewModel.swift
//  magnetX
//
//  Created by hsuyelin on 2018/5/29.
//  Copyright © 2018年 hsuyelin. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class CommonMovieViewModel {
    struct Input {
        let refresh: ControlEvent<Void>
        let more: ControlEvent<Void>
        let pageIndex: Observable<Int>
        let apiName: Observable<String>
    }
    
    struct Output {
        let items: Driver<[CommonMovieModel]>
        let endRefresh: Driver<Void>
        let endMore: Driver<Void>
    }
    
    private var pageIndex = 1
    private var items: [CommonMovieModel] = []
}

extension CommonMovieViewModel: ViewModelType {
    func transform(_ input: CommonMovieViewModel.Input) -> CommonMovieViewModel.Output {
//        let refresh = input.refresh.withLatestFrom(input.apiName, input.pageIndex)
    }
}
