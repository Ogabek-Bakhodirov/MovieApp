//
//  ViewController.swift
//  MovieApp
//
//  Created by Ogabek Bakhodirov on 16/08/22.
//

import UIKit

class PopularMovieViewController: UIViewController {
    
    var loader: PopularMovieProtocol?
    var popularMovie: [Results] = []
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.dataSource = self
        view.register(PopularMovieCell.self, forCellReuseIdentifier: PopularMovieCell.cellName)
        
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
        loader?.getPopularMovie(url: .popular, completion: { result in
            switch result{
            case let .success(movie):
                self.popularMovie = movie.results
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case let .failure(error):
                print("\(error.localizedDescription) errr" )
            }
        }) 
    }
}

//MARK: - PopularMovieViewController extension
extension PopularMovieViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        popularMovie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PopularMovieCell.cellName) as? PopularMovieCell else {return 
            UITableViewCell()
        }
        let movie = popularMovie[indexPath.row]
        cell.selectionStyle = .none
        cell.titleLabel.text = "\(movie.original_title)"
        cell.releaseData.text = "\(movie.release_date)"
        cell.overviewLabel.text = "\(movie.overview)"
        cell.titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
        cell.movieImage.loadImageFromURL(stringURL: "https://image.tmdb.org/t/p/w200\(movie.poster_path ?? "/pIkRyD18kl4FhoCNQuWxWu5cBLM.jpg")")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieID = popularMovie[indexPath.row].id
        let movieInfoViewController = MovieInfoViewController()
        
        movieInfoViewController.modalPresentationStyle = .fullScreen
        movieInfoViewController.movieID = movieID
        movieInfoViewController.modalTransitionStyle = .coverVertical
        navigationController?.pushViewController(movieInfoViewController, animated: true)
    }
}

//MARK: - UIImageView extension
extension UIImageView{
    func loadImageFromURL(stringURL: String){
        guard let url = URL(string: stringURL) else {return}
        DispatchQueue.main.async { [weak self] in
            guard let data = try? Data(contentsOf: url) else {return}
            guard let imageData = UIImage(data: data) else {return}
            self?.image = imageData
        }
    }
}
