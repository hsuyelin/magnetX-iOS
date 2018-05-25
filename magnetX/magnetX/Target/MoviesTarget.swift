//
//  MoviesTarget.swift
//  magnetX
//
//  Created by hsuyelin on 2018/5/25.
//  Copyright © 2018年 hsuyelin. All rights reserved.
//

import Moya

enum MoviesTarget {
    case getPopular
}

extension MoviesTarget: TargetType {
    
    var path: String {
        switch self {
        case .getPopular:
            return "/popular"
        }
    }
    
    var task: Task {
        switch self {
        case .getPopular:
            return .requestParameters(parameters: ["page": 1], encoding: URLEncoding.default)
        }
    }
}
