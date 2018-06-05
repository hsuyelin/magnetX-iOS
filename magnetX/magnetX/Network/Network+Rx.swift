//
//  NetworkError+Rx.swift
//  LightCloud
//
//  Created by GorXion on 2018/5/29.
//  Copyright © 2018年 gaoX. All rights reserved.
//

import RxSwiftX
import Moya

extension Network {
    
    enum Error: Swift.Error {
        case status(code: Int, message: String)
        
        var status_message: String {
            switch self {
            case let .status(_, message):
                return message
            }
        }
    }
}

extension Error {
    
    var errorMessage: String {
        if let error = self as? Network.Error {
            return error.status_message
        }
        return "未知错误"
    }
}

extension Network {
    
    struct Response<T: Codable>: Codable {
        let status_code: Int
        let status_message: String
        let subjects: T
        
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
                    return Single.just(resp.subjects)
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
            target.request().map(Network.Response<T>.self, atKeyPath: keyPath, using: decoder).map({
                if $0.success { return $0.subjects }
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
            let result = target.request().map(Network.Response<T>.self, atKeyPath: keyPath, using: decoder).map({ response -> T in
                if response.success { return response.subjects }
                throw Network.Error.status(code: response.status_code, message: response.status_message)
            }).storeCachedObject(for: target).asObservable()
            
            if let object = target.cachedObject(type) {
                return result.startWith(object)
            }
            return result
        }
    }
}
