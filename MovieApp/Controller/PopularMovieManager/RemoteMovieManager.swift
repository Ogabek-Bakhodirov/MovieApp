//
//  RemoteMovieManager.swift
//  MovieApp
//
//  Created by Ogabek Bakhodirov on 16/08/22.
//

import Foundation

class RemoteMovieManager: PopularMovieProtocol{
    func getPopularMovie(completion: @escaping ((PopularMovieResult) -> Void)) {
        let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=a86762fb6e7d30af415377e4d8eb69d8&language=en-US&page=1")
        guard let url = url else { return }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) {data, response, error in 
            guard let data = data, let response = response else {
                return completion(.failure(UnExpectedData().unExpectedData() as! Error))
            }
            let decoder = JSONDecoder()
            guard let popularMovie = try? decoder.decode(PopularMovieModel.self, from: data) else {
                return completion(.failure(UnExpectedData().unExpectedData() as! Error))
            }
            completion(.success(popularMovie))
        }
        task.resume()
    }
}
