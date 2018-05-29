//
//  Network+Rx.swift
//  RxNetwork_Example
//
//  Created by GorXion on 2018/5/28.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import RxNetwork
import RxSwift
import Moya

extension Network {
    
    enum Error: Swift.Error {
        case status(code: Int, message: String)
    }
}

extension Network {
    
    struct Response<T: Codable>: Codable {
        let status_code: Int
        let status_message: String
        let results: T
        var success: Bool {
            return status_code == 0
        }
    }
}

extension PrimitiveSequence where TraitType == SingleTrait, ElementType: Moya.Response {
    
    func mapResult<T: Codable>(_ type: T.Type,
                               atKeyPath keyPath: String? = nil,
                               using decoder: JSONDecoder = .init()) -> Single<T> {
        return flatMap { response -> Single<T> in
            if let resp = try? response.map(Network.Response<T>.self) {
                if resp.success {
                    return Single.just(resp.results)
                }
                return Single.error(Network.Error.status(code: resp.status_code, message: resp.status_message))
            }
            return Single.error(MoyaError.jsonMapping(response))
        }
    }
}

extension PrimitiveSequence where TraitType == SingleTrait, ElementType: TargetType {
    
    func requestWithResult<T: Codable>(_ type: T.Type,
                                       atKeyPath keyPath: String? = nil,
                                       using decoder: JSONDecoder = .init()) -> Single<T> {
        return flatMap({ target -> Single<T> in
            target.request(Network.Response<T>.self, atKeyPath: keyPath, using: decoder).map({
                if $0.success { return $0.results }
                throw Network.Error.status(code: $0.status_code, message: $0.status_message)
            }).storeCachedObject(for: target)
        })
    }
}

extension ObservableType where E: TargetType {
    
    func requestWithResult<T: Codable>(_ type: T.Type,
                                       atKeyPath keyPath: String? = nil,
                                       using decoder: JSONDecoder = .init()) -> Observable<T> {
        return flatMap { target -> Observable<T> in
            let result = target.request(Network.Response<T>.self, atKeyPath: keyPath, using: decoder).map({ response -> T in
                if response.success { return response.results }
                throw Network.Error.status(code: response.status_code, message: response.status_message)
            }).storeCachedObject(for: target).asObservable()
            
            if let object = target.cachedObject(type) {
                return result.startWith(object)
            }
            return result
        }
    }
}

