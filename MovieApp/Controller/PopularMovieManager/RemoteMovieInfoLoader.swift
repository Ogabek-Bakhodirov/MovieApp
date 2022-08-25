//
//  RemoteMovieInfoLoader.swift
//  MovieApp
//
//  Created by Ogabek Bakhodirov on 24/08/22.
//

import Foundation

class RemoteMovieInfoLoader{
    var apiKey = "a86762fb6e7d30af415377e4d8eb69d8"
    
    func fetchMovieInfo(movieID: Int, completion: @escaping((MovieInfo?, Error?) -> Void)){
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieID)/videos?api_key=\(apiKey)&language=en-US")
        guard let url = url else {return}
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let _ = response else { return }
            let decoder = JSONDecoder()
            guard let movieInfo = try? decoder.decode(MovieInfo.self, from: data) else {return}
            completion(movieInfo, nil)
        }
        task.resume()
    }
}
