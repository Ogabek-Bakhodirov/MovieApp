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
                self.movieKey = movieInfo?.results?[0].key
                self.fetchMoviePreview()
            }
        }
    }
    
    func fetchMoviePreview(){
        guard let movieKey = movieKey else { return }
        let string = "https://m.youtube.com/watch?v=\(movieKey)"//86-rEgNtyQw
        guard let url = URL(string: string) else {return}
        let provider = LPMetadataProvider()
        DispatchQueue.main.async {
            provider.startFetchingMetadata(for: url) { [weak self] metaData, err in
            if let metaData = metaData, err == nil{
                    self?.linkPreview.metadata = metaData
                }
            }
        }
    }
    
    func setupLinkPreview(){
        view.addSubview(linkPreview)
        NSLayoutConstraint.activate([
            linkPreview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            linkPreview.leftAnchor.constraint(equalTo: view.leftAnchor),
            linkPreview.rightAnchor.constraint(equalTo: view.rightAnchor),
            linkPreview.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
}
    

//                    self.view.addSubview(linkPreview)
//                    linkPreview.frame = CGRect(x: 0, y: 0, width: 250, height: 250)
//                    linkPreview.center = self.view.center 
