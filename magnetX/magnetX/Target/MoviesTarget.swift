//
//  MoviesTarget.swift
//  magnetX
//
//  Created by hsuyelin on 2018/5/25.
//  Copyright © 2018年 hsuyelin. All rights reserved.
//

import Moya

// startIndex 从第 startIndex 位置开始继续索引
enum MoviesTarget {
    case getPopular(startIndex: Int)
    case getNowPlaying(startIndex: Int)
    case getUpComing(startIndex: Int)
    case getDetails(id: String)
    case getTopRated(startIndex: Int)
}

extension MoviesTarget: TargetType {
    
    var path: String {
        switch self {
        case .getPopular:
            return "/popular"
        case .getNowPlaying:
            return "/in_theaters"
        case .getUpComing:
            return "/coming_soon"
        case .getTopRated:
            return "/top_rated"
        case .getDetails(let id):
            return "/subject/\(id.urlEncoding())"
        }
    }
    
    var task: Task {
        switch self {
        case .getPopular(let startIndex):
            return .requestParameters(parameters: ["start": startIndex], encoding: URLEncoding.default)
        case .getNowPlaying(let startIndex):
            return .requestParameters(parameters: ["start": startIndex], encoding: URLEncoding.default)
        case .getUpComing(let startIndex):
            return .requestParameters(parameters: ["start": startIndex], encoding: URLEncoding.default)
        case .getTopRated(let startIndex):
            return .requestParameters(parameters: ["start": startIndex], encoding: URLEncoding.default)
        case .getDetails:
            return .requestPlain
        }
    }
}
