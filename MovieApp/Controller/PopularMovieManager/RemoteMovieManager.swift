//
//  RemoteMovieManager.swift
//  MovieApp
//
//  Created by Ogabek Bakhodirov on 16/08/22.
//

import Foundation
import UIKit

class RemoteMovieManager: PopularMovieProtocol{

    var popularMovieViewController = PopularMovieViewController()
    
    func getPopularMovie(completion: @escaping ((PopularMovieResult) -> Void)) {
        
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "api.themoviedb.org"
        urlComponent.path = "/3/movie/popular"
        urlComponent.queryItems = [URLQueryItem(name: "api_key", value: "a86762fb6e7d30af415377e4d8eb69d8"),
                        URLQueryItem(name: "language", value: "en-US"),
                        URLQueryItem(name: "page", value: "1")]
 
        guard let url = URL(string: "\(urlComponent)") else {return}
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) {data, response, error in 
            guard let data = data, let response = response else {
                return completion(.failure(UnExpectedData().unExpectedData() as! Error))
            }
            let decoder = JSONDecoder()
            guard let popularMovie = try? decoder.decode(PopularMovieModel.self, from: data) else {
                if let error = error{
                    completion(.failure(error))
                }
                return
            }
            return completion(.success(popularMovie))
        }
        task.resume()
    }
    
    //MARK: - Get Movie Image
//    func getImage(completion: @escaping ((UIImage?, Error?) -> Void)){
//        var movieImageURL: String?
//        var image: UIImage?
//        popularMovieViewController.sendMovieInfo = { imageURL in
//            movieImageURL = imageURL
//        }
//                
//        if let url = URL(string: "https://image.tmdb.org/t/p/w500/\(movieImageURL)"){
//            let imageRequest = URLRequest(url: url)
//            let dataTask = URLSession.shared.dataTask(with: imageRequest) { data, response, error in
//                guard let data = data, let _ = response else {
//                    return completion(nil, error)
//                }
//                image = UIImage(data: data)
//                completion(image, nil)
//            }
//            dataTask.resume() 
//        }
//    }
}
