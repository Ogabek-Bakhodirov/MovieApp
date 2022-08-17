//
//  PopularMovieCell.swift
//  MovieApp
//
//  Created by Ogabek Bakhodirov on 18/08/22.
//

import UIKit

class PopularMovieCell: UITableViewCell{
    
    static var cellName: String = String(describing: PopularMovieCell.self)
    
    private lazy var movieImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "pc_movieImage")
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private(set) lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Title"
        view.font = .systemFont(ofSize: 16)
        view.contentMode = .center
        
        return view
    }()
    
    private(set) lazy var releaseData: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "2004.03.20"
        view.textColor = .gray
        view.font = .systemFont(ofSize: 15)
        view.contentMode = .center
        
        return view
    }()
    
    private(set) lazy var movieTitleInfoStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [titleLabel, releaseData])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.spacing = 3
        view.axis = .vertical
        view.distribution = .fill
        
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews(){
        addSubview(movieImage)
        addSubview(movieTitleInfoStackView)
        
        NSLayoutConstraint.activate([
            movieTitleInfoStackView.topAnchor.constraint(equalTo: topAnchor),
            movieTitleInfoStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40),
            movieTitleInfoStackView.leftAnchor.constraint(equalTo: movieImage.rightAnchor,constant: 15),
            movieTitleInfoStackView.rightAnchor.constraint(equalTo: rightAnchor),

            movieImage.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            movieImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            movieImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            movieImage.widthAnchor.constraint(equalToConstant: 120),
            movieImage.heightAnchor.constraint(equalToConstant: 150),

        ])
    }
}
