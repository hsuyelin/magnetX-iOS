//
//  BaseTarget.swift
//  magnetX
//
//  Created by hsuyelin on 2018/5/29.
//  Copyright © 2018年 hsuyelin. All rights reserved.
//

import Foundation
import Moya

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
}
