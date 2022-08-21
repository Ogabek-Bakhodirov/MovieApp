//
//  TopMovieViewController.swift
//  MovieApp
//
//  Created by Ogabek Bakhodirov on 17/08/22.
//

import UIKit

class TopRatedViewController: UIViewController{
    var loader: PopularMovieProtocol?
    var topRatedMovie: [Results] = []
    
    private lazy var headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.05196797848, green: 0.1966994107, blue: 0.3150942922, alpha: 1)
        
        return view
    }()
    
    private lazy var logoImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "logo_TMDB")
        view.contentMode = .scaleAspectFit
        
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(TopRatedCell.self, forCellReuseIdentifier: TopRatedCell.cellName)
        view.delegate = self
        view.dataSource = self
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        fetchData()
    }

    private func setupSubviews(){
        view.addSubview(headerView)
        view.addSubview(logoImage)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            headerView.rightAnchor.constraint(equalTo: view.rightAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 60),
            
            logoImage.topAnchor.constraint(equalTo: headerView.topAnchor),
            logoImage.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 20),
            logoImage.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: -20),
            logoImage.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func fetchData(){
        loader?.getPopularMovie(url: .topRated, completion: { result in
            switch result {
            case .success(let movieModel):
                self.topRatedMovie = movieModel.results
                DispatchQueue.main.async{
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}

extension TopRatedViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        topRatedMovie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TopRatedCell.cellName) as? TopRatedCell else {
            return UITableViewCell()
        }
        
        let movie = topRatedMovie[indexPath.row]
        cell.titleLabel.text = movie.original_title
        cell.titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        cell.overviewLabel.text = movie.overview
        cell.releaseData.text = movie.release_date
        cell.movieImage.loadImageFromURL(stringURL: "https://image.tmdb.org/t/p/w200\(movie.poster_path ?? "/pIkRyD18kl4FhoCNQuWxWu5cBLM.jpg")")
        
        return cell
    }
} 
