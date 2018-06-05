//
//  CommonModel.swift
//  magnetX
//
//  Created by hsuyelin on 2018/6/5.
//  Copyright © 2018年 hsuyelin. All rights reserved.
//

import Foundation

struct RatingModel: Codable {
    var max: String
    var average: String
    var stars: String
    var min: String
}

struct ImagesModel: Codable {
    var small: String
    var medium: String
    var large: String
}

struct PersonalAttrModel: Codable {
    var alt: String
    var name: String
    var id: String
    var avatars: ImagesModel
}
