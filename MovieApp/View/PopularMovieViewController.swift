//
//  ViewController.swift
//  MovieApp
//
//  Created by Ogabek Bakhodirov on 16/08/22.
//

import UIKit

class PopularMovieViewController: UIViewController {
    
    var loader: PopularMovieProtocol?
    
    
    lazy var newToken: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.text = "popular"
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        fetchData()
    }

    func setupSubviews(){
        view.addSubview(newToken)
        
        NSLayoutConstraint.activate([
            newToken.topAnchor.constraint(equalTo: view.topAnchor),
            newToken.leftAnchor.constraint(equalTo: view.leftAnchor),
            newToken.rightAnchor.constraint(equalTo: view.rightAnchor),
            newToken.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func fetchData(){
        loader?.getPopularMovie(completion: { result in
            switch result{
            case let .success(popularMovie):
                DispatchQueue.main.async {
                    self.newToken.text = "\(popularMovie.result?[0].adult)"
                    print(popularMovie)
                }
            case let .failure(error):
                print("\(error.localizedDescription) errr" )
            }
        }) 
    }
}

