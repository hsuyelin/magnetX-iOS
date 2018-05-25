//
//  Network+Rx.swift
//  ChengTayTong
//
//  Created by GorXion on 2018/3/12.
//  Copyright © 2018年 adinnet. All rights reserved.
//

import RxSwift
import Moya
import HandyJSON

extension TargetType {
    
    public func request(cache: ((Data) -> Void)? = nil) -> Single<Response> {
        if let cache = cache {
            if let data = HTTPCache.shared.cachedData(for: self) {
                cache(data)
            }
            return MultiProvider.shared.rx.request(.target(self)).catchError().storeCachedData(self)
        }
        return MultiProvider.shared.rx.request(.target(self)).catchError()
    }
}

extension PrimitiveSequence where TraitType == SingleTrait, ElementType == Response {
    public func mapObject<T>(_ type: T.Type) -> Single<HTTPResponse<T>> {
        return flatMap { response -> Single<HTTPResponse<T>> in
            let resp = JSONDeserializer.deserializeFrom(json: try response.mapString()) ?? HTTPResponse<T>()
            if resp.success {
                return Single.just(resp)
            }
            return Single.error(NetworkError.error(message: resp.statusMessage))
        }
    }
    
    public func storeCachedData(_ target: TargetType) -> Single<Response> {
        return flatMap({ response -> Single<Response> in
            HTTPCache.shared.storeCachedData(response.data, for: target)
            return Single.just(response)
        })
    }
    
    public func catchError() -> Single<Response> {
        return flatMap({ (response) -> Single<Response> in
            guard !response.data.isEmpty else {
                return Single.error(NetworkError.emptyData)
            }
            return Single.just(response).filterSuccessfulStatusAndRedirectCodes()
        })
    }
}

extension ObservableType where E == Response {
    
    public func mapObject<T>(_ type: T.Type) -> Observable<HTTPResponse<T>> {
        return flatMap { response -> Observable<HTTPResponse<T>> in
            let resp = JSONDeserializer.deserializeFrom(json: try response.mapString()) ?? HTTPResponse<T>()
            if resp.success {
                return Observable.just(resp)
            }
            return Observable.error(NetworkError.error(message: resp.statusMessage))
        }
    }
    
    public func storeCachedData(_ target: TargetType) -> Observable<Response> {
        return flatMap({ response -> Observable<Response> in
            HTTPCache.shared.storeCachedData(response.data, for: target)
            return Observable.just(response)
        })
    }
    
    public func catchError() -> Observable<Response> {
        return flatMap({ (response) -> Observable<Response> in
            guard !response.data.isEmpty else {
                return Observable.error(NetworkError.emptyData)
            }
            return Observable.just(response).filterSuccessfulStatusAndRedirectCodes()
        })
    }
}
