//
//  RemoteMovieManager.swift
//  MovieApp
//
//  Created by Ogabek Bakhodirov on 16/08/22.
//

import Foundation
import UIKit

class RemoteMovieManager: PopularMovieProtocol{
    
    func getPopularMovie(url: typeURL, completion: @escaping ((PopularMovieResult) -> Void)) {

        guard let url = URL(string: url.rawValue) else {return}
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) {data, response, error in 
            guard let data = data, let _ = response else {
                return completion(.failure(UnExpectedData().unExpectedData() as! Error))
            }
            let decoder = JSONDecoder()
            guard let popularMovie = try? decoder.decode(MovieModel.self, from: data) else {
                if let error = error{
                    completion(.failure(error))
                }
                return
            }
            return completion(.success(popularMovie))
        }
        task.resume()
    }
}
