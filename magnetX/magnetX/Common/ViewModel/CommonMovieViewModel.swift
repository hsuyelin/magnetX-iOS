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
import RxSwiftExt
import Differentiator
import RxNetwork

struct CommonMovieListModel {
    var items: [CommonMovieModel]
}

extension CommonMovieListModel: SectionModelType {
    init(original: CommonMovieListModel, items: [CommonMovieModel]) {
        self = original
        self.items = items
    }
}

class CommonMovieViewModel {
    struct Input {
        let refresh: Observable<Void>
        let more: Observable<Void>
        let type: Observable<HotType>
    }
    
    struct Output {
        let items: Driver<[CommonMovieListModel]>
        let refreshState: Driver<UIState>
        let moreState: Driver<UIState>
    }
    
    private var pageIndex = 1
    private var sections: [CommonMovieListModel] = []
}

extension CommonMovieViewModel: ViewModelType {
    func transform(_ input: CommonMovieViewModel.Input) -> CommonMovieViewModel.Output {
        let refreshState = PublishRelay<UIState>()
        let moreState = PublishRelay<UIState>()
        
        let refresh = input.refresh.withLatestFrom(input.type).map({ type -> HotType in
            self.pageIndex = 1
            return type
        }).flatMap({ (type) -> Observable<[CommonMovieModel]> in
            let target = type == .nowPlaying ? MoviesTarget.getNowPlaying(pageIndex: self.pageIndex) : MoviesTarget.getUpComing(pageIndex: self.pageIndex)
            return target.cache.requestWithResult([CommonMovieModel].self).trackState(refreshState, loading: false).catchErrorJustReturn([])
        }).map({ items -> [CommonMovieListModel] in
            self.sections = [CommonMovieListModel(items: items)]
            return self.sections
        })
    
        let more = input.more.withLatestFrom(input.type).map({ type -> HotType in
            self.pageIndex += 1
            return type
        }).flatMapLatest { (type) -> Observable<[CommonMovieModel]> in
            let target = type == .nowPlaying ? MoviesTarget.getNowPlaying(pageIndex: self.pageIndex) : MoviesTarget.getUpComing(pageIndex: self.pageIndex)
            return target.request().mapResult([CommonMovieModel].self).trackState(moreState, loading: false).catchErrorJustReturn([])
        }.map({ items -> [CommonMovieListModel] in
            self.sections.append(CommonMovieListModel(items: items))
            return self.sections
        })
        
        let items = Observable.merge(refresh, more).asDriver(onErrorJustReturn: [])
        
        return Output(items: items, refreshState: refreshState.asDriver(onErrorJustReturn: .idle), moreState: moreState.asDriver(onErrorJustReturn: .idle))
    }
}
