//
//  NetworkService.swift
//  magnetX
//
//  Created by hsuyelin on 2018/5/29.
//  Copyright © 2018年 hsuyelin. All rights reserved.
//

import Foundation
import Moya

class NetworkService  {
    
    public static func configService() {
        Network.shared.timeoutInterval = 20
        let plugins: [PluginType] = NetworkEnvironment.environment == .develop ? [NetworkIndicatorPlugin(), NetworkLoggerPlugin(verbose: true)] : [NetworkIndicatorPlugin()]
        Network.shared.plugins = plugins
        Network.shared.taskClosure = { target in
            switch target.task {
            case let .requestParameters(parameters, encoding):
                var params = parameters
                params.updateValue(TMDB_API_KEY, forKey: "api_key")
                params.updateValue(XUtils.getCurrentLanguage(), forKey: "language")
                return .requestParameters(parameters: params, encoding: encoding)
            case .requestPlain:
                var params = [String: String]()
                params.updateValue(TMDB_API_KEY, forKey: "api_key")
                params.updateValue(XUtils.getCurrentLanguage(), forKey: "language")
                return .requestParameters(parameters: params, encoding: URLEncoding.default)
                
            default:
                return target.task
            }
        }
    }
}
