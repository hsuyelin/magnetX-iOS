//
//  HTTPResponse.swift
//  ChengTayTong
//
//  Created by GorXion on 2018/3/1.
//  Copyright © 2018年 adinnet. All rights reserved.
//

import HandyJSON

public struct HTTPResponse<T: HandyJSON>: HandyJSON {
    
    private var status_message = ""
    private var status_code = ""
    var result: T?
    
    var success: Bool {
        return status_code == "201"
    }
    
    var statusCode: String {
        return status_code
    }
    
    var statusMessage: String {
        return status_message
    }
    
    public init() {}
}

struct ResponseModel: HandyJSON {
}

extension String: HandyJSON {}
extension Array: HandyJSON {}
extension Array where Element: HandyJSON {}
