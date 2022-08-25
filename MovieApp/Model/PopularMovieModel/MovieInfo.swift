//
//  MovieInfo.swift
//  MovieApp
//
//  Created by Ogabek Bakhodirov on 24/08/22.
//

import Foundation
struct MovieInfo: Codable{
    var id: Int?
    var results: [MovieInfoResults]?
}

struct MovieInfoResults: Codable{
      let iso_639_1: String
      let iso_3166_1: String
      let name: String
      let key: String
      let site: String
      let size: Int
      let type: String
      let official: Bool
      let published_at: String
      let id: String
}
