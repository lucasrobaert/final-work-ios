//
//  DetailViewController.swift
//  Final Work
//
//  Created by Lucas Robaert on 05/08/23.
//

import UIKit

class DetailViewController: UIViewController {

    var movie: MovieDetail? = nil
    private let posterImage = UIImageView()
    private let overviewLabel: UILabel = {
       
        let label = UILabel()
        
        label.text = "Overview:"
        label.font = UIFont.systemFont(ofSize: 24)
        
        
        return label
    }()
    
    private let overview: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .justified
        return label
    }()
    
    private let voteAvarege = UILabel()

    private let release = UILabel()
    private let lineView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .gray
        
        return view
    }()
    
    
    init(){
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .systemGray6
        
     
        title = movie?.originalTitle
        
        configureView()
    }
    
    
    func configureView(){
        
        let urlString = "https://image.tmdb.org/t/p/w500\(movie!.posterPath)"
        
        guard let url = URL(string: urlString) else {
            return
        }

        ImageManager.shared.loadImage(from:url) { image in
            self.posterImage.image = image
        }
        overview.text = movie?.overview
        voteAvarege.text = "Avarege: \(movie!.voteAverage)"
        release.text = "Release: \(movie!.releaseDate)"
        
        posterImage.contentMode = .scaleAspectFit
        
        posterImage.translatesAutoresizingMaskIntoConstraints = false
        overview.translatesAutoresizingMaskIntoConstraints = false
        voteAvarege.translatesAutoresizingMaskIntoConstraints = false
        lineView.translatesAutoresizingMaskIntoConstraints = false
        release.translatesAutoresizingMaskIntoConstraints = false
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(posterImage)
        view.addSubview(overview)
        view.addSubview(voteAvarege)
        view.addSubview(lineView)
        view.addSubview(release)
        view.addSubview(overviewLabel)
        
        NSLayoutConstraint.activate([
            posterImage.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100.0),
            posterImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
            posterImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0),
            posterImage.heightAnchor.constraint(equalToConstant: 300.0),
            
            
            voteAvarege.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: 20),
            voteAvarege.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            
            release.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: 20),
            release.leadingAnchor.constraint(equalTo: voteAvarege.trailingAnchor, constant: 20),
            release.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            
            
            lineView.topAnchor.constraint(equalTo: voteAvarege.bottomAnchor, constant: 10),
            lineView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 1),
            
            
            overviewLabel.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 20),
            overviewLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            overviewLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            
            overview.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 20),
            overview.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            overview.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            
            
        ])
    }

}

