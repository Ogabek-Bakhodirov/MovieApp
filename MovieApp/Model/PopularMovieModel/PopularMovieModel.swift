//
//  PopularMovieModel.swift
//  MovieApp
//
//  Created by Ogabek Bakhodirov on 16/08/22.
//

import Foundation

struct PopularMovieModel: Codable{
    var page: Int?
    var result: [Result]?
    var totalResults: Int?
    var totalPages: Int?
    
    enum CodingKeys: String, CodingKey{
        case page
        case result
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}

struct Result: Codable{
    var poster_path: String?
    var adult: Bool
    var overview: String
    var release_date: String
    var genre_ids: [Int]
    var id: Int
    var original_title: String
    var original_language: String
    var title: String
    var backdrop_path: String?
    var popularity: Double
    var vote_count: Int
    var video: Bool
    var vote_average: Double
}
