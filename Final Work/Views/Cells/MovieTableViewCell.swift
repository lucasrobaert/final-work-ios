//
//  MovieTableViewCell.swift
//  Final Work
//
//  Created by Lucas Robaert on 05/08/23.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    static var reuseIndentifier: String  = "MovieTableViewCell"
    
    private let image = UIImageView()
    private let title = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureView()
    }
    
    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with movie: MovieDetail){
        title.text = movie.title
        
        
        let urlString = "https://image.tmdb.org/t/p/w500\(movie.posterPath)"
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        ImageManager.shared.loadImage(from:url) { image in
            self.image.image = image
        }
    }

}

// MARK: UI Methods

extension MovieTableViewCell{
    func configureView(){
        self.contentView.addSubview(image)
        self.contentView.addSubview(title)
        
        image.translatesAutoresizingMaskIntoConstraints  = false
        title.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            image.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            image.heightAnchor.constraint(equalToConstant: 50),
            image.widthAnchor.constraint(equalToConstant: 50),
            
            
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            title.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 20),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            title.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
        
        ])
    }
}

extension UIImageView {
    func load(url: String) {
        
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(url)") else {
            return
        }
                
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data){
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
        
    }
}
