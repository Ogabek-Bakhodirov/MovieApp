//
//  MovieInfoViewController.swift
//  MovieApp
//
//  Created by Ogabek Bakhodirov on 21/08/22.
//

import UIKit
import LinkPresentation

class MovieInfoViewController: UIViewController{
    
    var movieKey: String?
    var movieID: Int = 0
    
    lazy var linkPreview: LPLinkView = {
        let view = LPLinkView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = .white
        fetchMovieKey()
        setupLinkPreview()
    }
    
    func fetchMovieKey(){
        RemoteMovieInfoLoader().fetchMovieInfo(movieID: movieID) { movieInfo, error in
            if error == nil{
                guard let key = movieInfo?.results?[0].key else {return}
                self.movieKey = key
                self.fetchMoviePreview()
            }
        }
    }
    
    func fetchMoviePreview(){
        guard let movieKey = movieKey else { return }
        let string = "https://m.youtube.com/watch?v=\(movieKey)"//86-rEgNtyQw
        guard let url = URL(string: string) else {return}
        let provider = LPMetadataProvider()
        DispatchQueue.global(qos: .userInitiated).async {
            provider.startFetchingMetadata(for: url) { [weak self] metaData, err in
                if let metaData = metaData, err == nil{
                    DispatchQueue.main.async {
                        self?.linkPreview.metadata = metaData
                    }
                }
            }
        }
    }
    
    func setupLinkPreview(){
        view.addSubview(linkPreview)
        NSLayoutConstraint.activate([
            linkPreview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            linkPreview.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            linkPreview.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            linkPreview.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
}

