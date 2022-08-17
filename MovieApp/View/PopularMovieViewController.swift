//
//  ViewController.swift
//  MovieApp
//
//  Created by Ogabek Bakhodirov on 16/08/22.
//

import UIKit

class PopularMovieViewController: UIViewController {
    
    var loader: PopularMovieProtocol?
    
    lazy var headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.05196797848, green: 0.1966994107, blue: 0.3150942922, alpha: 1)
        
        return view
    }()
    
    lazy var logoImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "logo_TMDB")
        view.contentMode = .scaleAspectFit
        
        return view
    }()

    
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
        view.addSubview(headerView)
        view.addSubview(logoImage)
        view.addSubview(newToken)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            headerView.rightAnchor.constraint(equalTo: view.rightAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 60),
            
            logoImage.topAnchor.constraint(equalTo: headerView.topAnchor),
            logoImage.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 20),
            logoImage.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: -20),
            logoImage.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            
            newToken.topAnchor.constraint(equalTo: headerView.bottomAnchor),
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
                    self.newToken.text = "\(popularMovie.totalResults!)"
                    print(popularMovie)
                }
            case let .failure(error):
                print("\(error.localizedDescription) errr" )
            }
        }) 
    }
}

