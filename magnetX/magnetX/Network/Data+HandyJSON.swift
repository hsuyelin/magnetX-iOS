//
//  Data+HandyJSON.swift
//  ChengTayTong
//
//  Created by GorXion on 2018/3/13.
//  Copyright © 2018年 adinnet. All rights reserved.
//

import HandyJSON

extension Data {
    func mapObject<T>(_ type: T.Type) -> HTTPResponse<T> {
        let json = String(data: self, encoding: .utf8)
        return JSONDeserializer.deserializeFrom(json: json) ?? HTTPResponse<T>()
    }
}
