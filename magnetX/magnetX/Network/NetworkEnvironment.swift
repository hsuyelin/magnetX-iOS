//
//  NetworkConfig.swift
//  ChengTayTong
//
//  Created by GorXion on 2018/3/2.
//  Copyright © 2018年 adinnet. All rights reserved.
//

public enum NetworkEnvironment {
    case develop
    case product
    
    static let environment: NetworkEnvironment = .product
    
    var baseURL: String {
        switch self {
        case .develop:
            return "https://api.themoviedb.org/3/movie"
        case .product:
            return "https://api.themoviedb.org/3/movie"
        }
    }
}
