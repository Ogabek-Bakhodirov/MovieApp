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
    
    private func fetchData(){
        loader?.getPopularMovie(completion: { result in
            switch result{
            case let .success(popularMovie):
                self.popularMovie = popularMovie.results
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
        cell.titleLabel.text = "\(movie.original_title)"
        cell.releaseData.text = "\(movie.release_date)"
        cell.overviewLabel.text = "\(movie.overview)"
        cell.titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
        cell.movieImage.loadImageFromURL(stringURL: "https://image.tmdb.org/t/p/w500\(movie.poster_path ?? "/pIkRyD18kl4FhoCNQuWxWu5cBLM.jpg")")
        return cell
    }
}

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
