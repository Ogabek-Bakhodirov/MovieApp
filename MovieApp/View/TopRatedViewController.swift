//
//  TopMovieViewController.swift
//  MovieApp
//
//  Created by Ogabek Bakhodirov on 17/08/22.
//

import UIKit

class TopRatedViewController: UIViewController{
    lazy var newToken: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.text = "Top"
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
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
}
