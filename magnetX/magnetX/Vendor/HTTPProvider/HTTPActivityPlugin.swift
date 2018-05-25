//
//  HTTPActivityPlugin.swift
//  ChengTayTong
//
//  Created by GorXion on 2018/3/1.
//  Copyright © 2018年 adinnet. All rights reserved.
//

import Moya
import Result

public final class HTTPActivityPlugin: PluginType {
    
    private static var numberOfRequests: Int = 0 {
        didSet {
            if numberOfRequests > 1 { return }
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = self.numberOfRequests > 0
            }
        }
    }
    
    public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request
        request.timeoutInterval = 10
        return request
    }
    
    public func willSend(_ request: RequestType, target: TargetType) {
        HTTPActivityPlugin.numberOfRequests += 1
    }
    
    public func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        HTTPActivityPlugin.numberOfRequests -= 1
    }
}
