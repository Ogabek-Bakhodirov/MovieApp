//
//  MovieImageModel.swift
//  MovieApp
//
//  Created by Ogabek Bakhodirov on 19/08/22.
//

import Foundation

struct MovieImage: Codable{
    var id: Int
    var backdrops: [Backdrops]
    var posters: [Posters]
}

struct Backdrops: Codable{
    var aspect_ratio: Double
    var file_path: String
    var height: Int
    var iso_639_1: String?
    var vote_average: Int
    var vote_count: Int
    var width: Int
}


struct Posters: Codable{
          var aspect_ratio: Double
          var file_path: String
          var height: Int
          var iso_639_1: String?
          var vote_average: Int
          var vote_count: Int
          var width: Int  
}
