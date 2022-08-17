//
//  PopularMovieURL.swift
//  MovieApp
//
//  Created by Ogabek Bakhodirov on 18/08/22.
//

import Foundation

struct PopularMovieURL{
    static var scheme = "https"
    static var host = "api.themoviedb.org"
    static var path = "/3/movie/popular"
    static var queryItems = [URLQueryItem(name: "api_key", value: "a86762fb6e7d30af415377e4d8eb69d8"),
                             URLQueryItem(name: "language", value: "en-US"),
                             URLQueryItem(name: "page", value: "1")]
}
