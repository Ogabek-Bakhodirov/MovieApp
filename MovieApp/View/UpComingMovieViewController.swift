//
//  UpComingMovieViewControlelr.swift
//  MovieApp
//
//  Created by Ogabek Bakhodirov on 17/08/22.
//

import UIKit

class UpComingMovieViewController: UIViewController{
    
    var loader: PopularMovieProtocol? 
    var upcomingMovie: [Results] = []
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(UpComingCell.self, forCellReuseIdentifier: UpComingCell.cellName)
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
    
    private func fetchData(){
        loader?.getPopularMovie(url: .upcoming, completion: { result in
            switch result {
            case .success(let movie):
                
                self.upcomingMovie = movie.results
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}

//MARK: - UpComingMovieViewController extension
extension UpComingMovieViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        upcomingMovie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UpComingCell.cellName) as? UpComingCell else {
            return UITableViewCell()
        }
        let movie = upcomingMovie[indexPath.row]
        cell.selectionStyle = .none
        cell.titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        cell.titleLabel.text = upcomingMovie[indexPath.row].original_title
        cell.overviewLabel.text = movie.overview
        cell.releaseData.text = movie.release_date
        
        DispatchQueue.global(qos: .userInteractive).async {
            cell.movieImage.loadImageFromURL(stringURL:"https://image.tmdb.org/t/p/w200\(movie.poster_path ?? "/pIkRyD18kl4FhoCNQuWxWu5cBLM.jpg")")
        } 
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieID = upcomingMovie[indexPath.row].id
        let movieInfoViewController = MovieInfoViewController()
        
        movieInfoViewController.modalPresentationStyle = .fullScreen
        movieInfoViewController.movieID = movieID
        movieInfoViewController.modalTransitionStyle = .coverVertical
        navigationController?.pushViewController(movieInfoViewController, animated: true)
    }
} 
