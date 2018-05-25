//
//  HTTPLoggerPlugin.swift
//  ChengTayTong
//
//  Created by GorXion on 2018/3/2.
//  Copyright © 2018年 adinnet. All rights reserved.
//

import Moya
import Result

public struct HTTPLoggerPlugin: PluginType {
    
    public func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        debugPrint("*********************************************Result*********************************************")
        debugPrint("requestURL:", target.baseURL.absoluteString + target.path)
        if case .requestParameters(let parameters, _) = target.task {
            debugPrint("parameters:", parameters)
        }
        switch result {
        case .success(let response):
            debugPrint("-----request success-----")
            do {
                debugPrint(try response.mapString())
            } catch {}
        case .failure:
            debugPrint("-----request failure-----")
        }
        debugPrint("**********************************************End**********************************************")
        debugPrint()
    }
}
