//
//  MovieDetailMovieModel.swift
//  magnetX
//
//  Created by hsuyelin on 2018/5/30.
//  Copyright © 2018年 hsuyelin. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxSwiftExt
import Differentiator
import RxNetwork

struct MovieDetailListModel {
    var items: [MovieDetailModel]
}

extension MovieDetailListModel: SectionModelType {
    init(original: MovieDetailListModel, items: [MovieDetailModel]) {
        self = original
        self.items = items
    }
}

class MovieDetailViewModel {
    struct Input {
        let refresh: Observable<Void>
        let target: Observable<MoviesTarget>
    }
    
    struct Output {
        let items: Driver<[MovieDetailListModel]>
        let refreshState: Driver<UIState>
    }

    private var sections: [MovieDetailListModel] = []
}

extension MovieDetailViewModel: ViewModelType {
    func transform(_ input: MovieDetailViewModel.Input) -> MovieDetailViewModel.Output {
        
        let refreshState = PublishRelay<UIState>()
        
        let items = input.refresh.withLatestFrom(input.target).map({ target -> MoviesTarget in
            return target
        }).flatMap({
            $0.cache.request([MovieDetailModel].self).trackNWState(refreshState).catchErrorJustComplete()
        }).map({ items -> [MovieDetailListModel] in
            self.sections = [MovieDetailListModel(items: items)]
            return self.sections
        }).asDriver(onErrorJustReturn: [])
        
        return Output(items: items, refreshState: refreshState.asDriver(onErrorJustReturn: .idle))
    }
}


