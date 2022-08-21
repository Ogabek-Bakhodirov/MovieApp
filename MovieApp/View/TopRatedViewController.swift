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
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([

            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
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

//MARK: - TopRatedViewController extension
extension TopRatedViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        topRatedMovie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TopRatedCell.cellName) as? TopRatedCell else {
            return UITableViewCell()
        }
        
        let movie = topRatedMovie[indexPath.row]
        cell.selectionStyle = .none
        cell.titleLabel.text = movie.original_title
        cell.titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        cell.overviewLabel.text = movie.overview
        cell.releaseData.text = movie.release_date
        cell.movieImage.loadImageFromURL(stringURL: "https://image.tmdb.org/t/p/w200\(movie.poster_path ?? "/pIkRyD18kl4FhoCNQuWxWu5cBLM.jpg")")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieInfoViewController = MovieInfoViewController()
        movieInfoViewController.modalPresentationStyle = .fullScreen
        movieInfoViewController.modalTransitionStyle = .coverVertical
        navigationController?.pushViewController(movieInfoViewController, animated: true)
    }
} 
