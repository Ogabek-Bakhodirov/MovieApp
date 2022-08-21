//
//  PopularMovieProtocol.swift
//  MovieApp
//
//  Created by Ogabek Bakhodirov on 16/08/22.
//

import Foundation

enum PopularMovieResult{
    case success(MovieModel)
    case failure(Error)
}

protocol PopularMovieProtocol{
    func getPopularMovie(completion: @escaping ((PopularMovieResult) -> Void))
}
