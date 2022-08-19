//
//  PopularMovieModel.swift
//  MovieApp
//
//  Created by Ogabek Bakhodirov on 16/08/22.
//

import Foundation

struct PopularMovieModel: Codable {
    var page: Int?
    var results: [Results]
    var totalResults: Int?
    var totalPages: Int?
    
    enum CodingKeys: String, CodingKey{
        case page
        case results
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}
