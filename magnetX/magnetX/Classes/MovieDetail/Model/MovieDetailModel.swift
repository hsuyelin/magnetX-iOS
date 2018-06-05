//
//  MovieDetailModel.swift
//  magnetX
//
//  Created by hsuyelin on 2018/5/30.
//  Copyright © 2018年 hsuyelin. All rights reserved.
//

import Foundation

struct MovieDetailModel: Codable {
    var reviews_count: String
    var wish_count: String
    var douban_site: String
    var year: String
    var alt: String
    var id: String
    var mobile_url: String
    var title: String
    var do_count: String
    var share_url: String
    var seasons_count: String
    var schedule_url: String
    var episodes_count: String
    var collect_count: String
    var current_season: String
    var original_title: String
    var summary: String
    var subtype: String
    var comments_count: String
    var ratings_count: String
    
    var rating: RatingModel
    var images: ImagesModel
    var countries: [String]
    var genres: [String]
    var aka: [String]
    var casts: [PersonalAttrModel]
    var directors: [PersonalAttrModel]
    
    var yearAndGenres: String {
        var year = ""
        if self.year.isBlank == false {
            year = self.year
        }
        
        var genres = ""
        if self.genres.count == 0 {
            return year + genres
        }
        else {
            let genresArr = self.genres.map { $0 }
            genres = genresArr.joined(separator: " / ")
            if self.year.isBlank {
                return genres
            }
            else {
                return year + " / " + genres
            }
        }
    }
}


