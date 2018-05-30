//
//  MovieDetailModel.swift
//  magnetX
//
//  Created by hsuyelin on 2018/5/30.
//  Copyright © 2018年 hsuyelin. All rights reserved.
//

import Foundation

struct MovieDetailModel: Codable {
    var adult: Bool
    var backdrop_path: String
    var belongs_to_collection: Array<belongToColletionModel>
    var budget: String
    var genres: Array<genresModel>
    var homepage: String
    var id: String
    var imdb_id: String
    var original_language: String
    var original_title: String
    var overview: String
    var popularity: String
    var poster_path: String
    var production_companies: Array<productionCompaniesModel>
    var production_countries: Array<productionCountriesModel>
    var release_date: String
    var revenue: String
    var runtime: String
    var spoken_languages: Array<spokenLanguages>
    var status: String
    var tagline: String
    var title: String
    var video: String
    var vote_average: String
    var vote_count: String
}

struct belongToColletionModel: Codable {
    var id: String
    var name: String
    var poster_path: String
    var backdrop_path: String
}

struct genresModel: Codable {
    var id: String
    var name: String
}

struct productionCompaniesModel: Codable {
    var id: String
    var name: String
    var logo_path: String
    var origin_country: String
}

struct productionCountriesModel: Codable {
    var iso_3166_1: String
    var name: String
}

struct spokenLanguages: Codable {
    var iso_639_1: String
    var name: String
}



