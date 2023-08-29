//
//  ViewController.swift
//  Final Work
//
//  Created by Lucas Robaert on 05/08/23.
//

import UIKit

class ViewController: UIViewController {

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    var movies: [MovieDetail] = []
    var filteredMovies: [MovieDetail] = []
    let service: MovieService
    
    init(){
        self.service = MovieService()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureTableView()
        
        self.service.fetchMoviesList(completion: {[weak self] result in
            switch(result){
            case let .success(movies):
                print(movies)
                self?.movies = movies
                self?.filteredMovies = movies
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            
            case let .failure(error):
                print(error)
                self?.movies = []
                self?.filteredMovies = []
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        })
        
    }

}

// MARK: - UI Methods

extension ViewController {
    
    func configureView(){
        self.view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
        
        configureSearchController()
    }
    
    func configureTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.reuseIndentifier)
    }
    
    func configureSearchController(){
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Filter by name"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
}

// MARK: - UiTableViewDataSource

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.reuseIndentifier, for: indexPath) as?
            MovieTableViewCell else {
            return UITableViewCell()
        }
        
        let movie = filteredMovies[indexPath.row]
        
        cell.configure(with: movie)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = DetailViewController()
        vc.movie = filteredMovies[indexPath.row]
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


// MARK: UiTableViewDelegate

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMovies.count
    }
}


// MARK: -

extension ViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText  = searchController.searchBar.text, !searchText.isEmpty else {
            self.filteredMovies = self.movies
            self.tableView.reloadData()
            return
        }
        
        self.filteredMovies = self.movies.filter({movie in
            return movie.title.lowercased().contains(searchText.lowercased())
        })
        
        self.tableView.reloadData()
    }
}
