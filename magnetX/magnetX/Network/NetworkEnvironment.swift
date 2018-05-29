//
//  NetworkEnvironment.swift
//  magnetX
//
//  Created by hsuyelin on 2018/5/29.
//  Copyright © 2018年 hsuyelin. All rights reserved.
//

public enum NetworkEnvironment {
    case develop
    case product
    
    static let environment: NetworkEnvironment = .develop
    
    var baseURL: String {
        switch self {
        case .develop:
            return "https://api.themoviedb.org/3"
        case .product:
            return "https://api.themoviedb.org/3"
        }
    }
}
