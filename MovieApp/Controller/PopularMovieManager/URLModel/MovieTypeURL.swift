//
//  PopularMovieURL.swift
//  MovieApp
//
//  Created by Ogabek Bakhodirov on 18/08/22.
//

import Foundation

enum typeURL: String{
    case popular = "https://api.themoviedb.org/3/movie/popular?api_key=a86762fb6e7d30af415377e4d8eb69d8&language=en-US&page=1"
    case upcoming = "https://api.themoviedb.org/3/movie/upcoming?api_key=a86762fb6e7d30af415377e4d8eb69d8&language=en-US&page=1"
    case topRated = "https://api.themoviedb.org/3/movie/top_rated?api_key=a86762fb6e7d30af415377e4d8eb69d8&language=en-US&page=1"
}

struct MovieTypeURL{
    static var url = typeURL.upcoming.rawValue
}

