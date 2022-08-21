//
//  TokenManager.swift
//  MovieApp
//
//  Created by Ogabek Bakhodirov on 16/08/22.
//

import Foundation

enum TokenLoaderResult{
    case success(TokenModel)
    case failure(Error)
}

class TokenManager{
    func tokenLoader(completion: @escaping ((TokenLoaderResult) -> Void)){
        let url = URL(string: "https://api.themoviedb.org/3/authentication/token/new?api_key=a86762fb6e7d30af415377e4d8eb69d8")
        guard let url = url else {return}
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in 
            guard let data = data, let _ = response else { 
                return completion(.failure(WrongURL().wrongURL(error: error!)))
            }
             let decoder = JSONDecoder()
            guard let newToken = try? decoder.decode(TokenModel.self, from: data) else {
                return completion(.failure(UnExpectedData().unExpectedData() as! Error))
            }
            completion(.success(newToken))
        }
        task.resume()
    }
}

struct WrongURL: Error {
    func wrongURL(error: Error) -> Error{
        print("wrong url error")
        return error.localizedDescription as! Error
    }
}

struct UnExpectedData: Error {
    func unExpectedData(){
        print("Un expected data error")
    }
}
