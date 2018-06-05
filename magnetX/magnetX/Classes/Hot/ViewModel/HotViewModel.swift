//
//  HotViewModel.swift
//  magnetX
//
//  Created by hsuyelin on 2018/6/5.
//  Copyright © 2018年 hsuyelin. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxSwiftExt
import Differentiator
import RxSwiftX

struct HotMovieListModel {
    var items: [HotMovieModel]
}

extension HotMovieListModel: SectionModelType {
    init(original: HotMovieListModel, items: [HotMovieModel]) {
        self = original
        self.items = items
    }
}

class HotMovieViewModel {
    struct Input {
        let refresh: Observable<Void>
        let more: Observable<Void>
        let type: Observable<HotType>
    }
    
    struct Output {
        let items: Driver<[HotMovieListModel]>
        let refreshState: Driver<UIState>
        let moreState: Driver<UIState>
    }
    
    private var startIndex = 0
    private var sections: [HotMovieListModel] = []
}

extension HotMovieViewModel: ViewModelType {
    func transform(_ input: HotMovieViewModel.Input) -> HotMovieViewModel.Output {
        let refreshState = PublishRelay<UIState>()
        let moreState = PublishRelay<UIState>()
        
        let refresh = input.refresh.withLatestFrom(input.type).map({ type -> HotType in
            self.startIndex = 0
            return type
        }).flatMap({ (type) -> Observable<[HotMovieModel]> in
            let target = type == .nowPlaying ? MoviesTarget.getNowPlaying(startIndex: self.startIndex) : MoviesTarget.getUpComing(startIndex: self.startIndex)
            return target.cache.requestWithResult([HotMovieModel].self).trackState(refreshState, loading: false).catchErrorJustReturn([])
        }).map({ items -> [HotMovieListModel] in
            self.sections = [HotMovieListModel(items: items)]
            return self.sections
        })
        
        let more = input.more.withLatestFrom(input.type).map({ type -> HotType in
            self.startIndex += 20
            return type
        }).flatMapLatest { (type) -> Observable<[HotMovieModel]> in
            let target = type == .nowPlaying ? MoviesTarget.getNowPlaying(startIndex: self.startIndex) : MoviesTarget.getUpComing(startIndex: self.startIndex)
            return target.request().mapResult([HotMovieModel].self).trackState(moreState, loading: false).catchErrorJustReturn([])
            }.map({ items -> [HotMovieListModel] in
                self.sections.append(HotMovieListModel(items: items))
                return self.sections
            })
        
        let items = Observable.merge(refresh, more).asDriver(onErrorJustReturn: [])
        
        return Output(items: items, refreshState: refreshState.asDriver(onErrorJustReturn: .idle), moreState: moreState.asDriver(onErrorJustReturn: .idle))
    }
}

