//
//  HotMovieModel.swift
//  magnetX
//
//  Created by hsuyelin on 2018/6/5.
//  Copyright © 2018年 hsuyelin. All rights reserved.
//

import Foundation

struct HotMovieModel: Codable {
    var title: String
    var collect_count: String
    var original_title: String
    var subtype: String
    var year: String
    var alt: String
    var id: String
    
    var rating: RatingModel
    var genres: [String]
    var casts: [PersonalAttrModel]
    var directors: [PersonalAttrModel]
    var images: ImagesModel
    
    var director: String {
        if directors.count == 0 {
            return "暂无数据"
        }
        else {
            let directorsArr = directors.map { $0.name }
            return directorsArr.joined(separator: " / ")
        }
    }
    
    var cast: String {
        if casts.count == 0 {
            return "暂无数据"
        }
        else {
            let castsArr = casts.map { $0.name }
            return castsArr.joined(separator: " / ")
        }
    }
}



