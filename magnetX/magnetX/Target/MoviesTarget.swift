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
    case nowPlaying(pageIndex: Int)
    case upComing(pageIndex: Int)
}

extension MoviesTarget: TargetType {
    
    var path: String {
        switch self {
        case .getPopular:
            return "/movie/popular"
        case .nowPlaying:
            return "/movie/now_playing"
        case .upComing:
            return "/movie/upcoming"
        }
    }
    
    var task: Task {
        switch self {
        case .getPopular(let pageIndex):
            return .requestParameters(parameters: ["page": pageIndex], encoding: URLEncoding.default)
        case .nowPlaying(let pageIndex):
            return .requestParameters(parameters: ["page": pageIndex], encoding: URLEncoding.default)
        case .upComing(let pageIndex):
            return .requestParameters(parameters: ["page": pageIndex], encoding: URLEncoding.default)
        }
    }
}
