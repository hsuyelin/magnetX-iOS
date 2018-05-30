//
//  MoviesTarget.swift
//  magnetX
//
//  Created by hsuyelin on 2018/5/25.
//  Copyright © 2018年 hsuyelin. All rights reserved.
//

import Moya

enum MoviesTarget {
    case getPopular(pageIndex: Int)
    case getNowPlaying(pageIndex: Int)
    case getUpComing(pageIndex: Int)
    case getDetails(id: String)
    case getTopRated(pageIndex: Int)
}

extension MoviesTarget: TargetType {
    
    var path: String {
        switch self {
        case .getPopular:
            return "/movie/popular"
        case .getNowPlaying:
            return "/movie/now_playing"
        case .getUpComing:
            return "/movie/upcoming"
        case .getTopRated:
            return "/movie/top_rated"
        case .getDetails(let id):
            return "/movie/\(id.urlEncoding())"
        }
    }
    
    var task: Task {
        switch self {
        case .getPopular(let pageIndex):
            return .requestParameters(parameters: ["page": pageIndex], encoding: URLEncoding.default)
        case .getNowPlaying(let pageIndex):
            return .requestParameters(parameters: ["page": pageIndex], encoding: URLEncoding.default)
        case .getUpComing(let pageIndex):
            return .requestParameters(parameters: ["page": pageIndex], encoding: URLEncoding.default)
        case .getTopRated(let pageIndex):
            return .requestParameters(parameters: ["page": pageIndex], encoding: URLEncoding.default)
        case .getDetails:
            return .requestPlain
        }
    }
}
