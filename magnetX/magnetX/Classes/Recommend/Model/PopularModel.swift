//
//  PopularModel.swift
//  magnetX
//
//  Created by hsuyelin on 2018/5/25.
//  Copyright © 2018年 hsuyelin. All rights reserved.
//

import HandyJSON

/// 时下最流行的电影
struct PopularModel: HandyJSON {
    var vote_count: String?
    var id: String?
    var video: Bool?
    var title: String?
    var popularity: String?
    var poster_path: String?
    var original_language: String?
    var original_title: String?
    var genre_ids: Array<String>?
    var backdrop_path: String?
    var adult: String?
    var overview: String?
    var release_date: String?
}
