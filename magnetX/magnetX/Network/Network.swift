//
//  Network.swift
//  ChengTayTong
//
//  Created by G-Xi0N on 2018/3/9.
//  Copyright © 2018年 adinnet. All rights reserved.
//

import Moya
import HandyJSON

enum NetworkError: Error {
    case emptyData
    case error(message: String)
}

extension TargetType {
    var baseURL: URL {
        return URL(string: NetworkEnvironment.environment.baseURL)!
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    var headers: [String: String]? {
        return nil
    }
    
    public func request<T>(cache: ((HTTPResponse<T>) -> Void)? = nil,
                           success: @escaping (HTTPResponse<T>) -> Void,
                           failure: @escaping (Error) -> ()) {
        if let cache = cache {
            if let data = HTTPCache.shared.cachedData(for: self) {
                cache(data.mapObject(T.self))
            }
        }
        MultiProvider.shared.request(.target(self)) { (result) in
            switch result {
            case .success(let response):
                do {
                    guard !response.data.isEmpty else {
                        failure(NetworkError.emptyData)
                        return
                    }
                    let json = try response.filterSuccessfulStatusAndRedirectCodes().mapString()
                    success(JSONDeserializer.deserializeFrom(json: json) ?? HTTPResponse<T>())
                    if cache != nil {
                        HTTPCache.shared.storeCachedData(response.data, for: self)
                    }
                } catch let error {
                    failure(error)
                }
            case .failure(let error):
                failure(error)
            }
        }
    }
}

extension MoyaProvider {
    convenience init() {
        self.init(endpointClosure: { (target) -> Endpoint in
            MoyaProvider.defaultEndpointMapping(for: target).replacing(task: MoyaProvider.encrypt(target))
        }, plugins: [HTTPLoggerPlugin(), HTTPActivityPlugin()])
    }
    
    private static func encrypt(_ target: TargetType) -> Task {
        switch target.task {
        case .requestParameters(let parameters, let encoding):
            var params = parameters
            params.updateValue(TMDB_API_KEY, forKey: "api_key")
            params.updateValue(XUtils.getCurrentLanguage(), forKey: "language")
            return .requestParameters(parameters: params, encoding: encoding)
        default:
            return target.task
        }
    }
}

final class MultiProvider {
    static let shared = MoyaProvider<MultiTarget>()
}
