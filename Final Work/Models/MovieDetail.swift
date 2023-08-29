//
//  MovieDetail.swift
//  Final Work
//
//  Created by Lucas Robaert on 05/08/23.
//

import Foundation


struct MovieDetail: Codable {
    let backdropPath: String
    let id: Int
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String
    let title: String
    let voteAverage: Double
    let voteCount: Int
    let releaseDate: String
    
    enum CodingKeys: String, CodingKey{
        case backdropPath = "backdrop_path"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case title
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case releaseDate = "release_date"
    }
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.backdropPath = try container.decode(String.self, forKey: .backdropPath)
        self.id = try container.decode(Int.self, forKey: .id)
        self.originalLanguage = try container.decode(String.self, forKey: .originalLanguage)
        self.originalTitle = try container.decode(String.self, forKey: .originalTitle)
        self.overview = try container.decode(String.self, forKey: .overview)
        self.popularity = try container.decode(Double.self, forKey: .popularity)
        self.posterPath = try container.decode(String.self, forKey: .posterPath)
        self.title = try container.decode(String.self, forKey: .title)
        self.voteAverage = try container.decode(Double.self, forKey: .voteAverage)
        self.voteCount = try container.decode(Int.self, forKey: .voteCount)
        self.releaseDate = try container.decode(String.self, forKey: .releaseDate)
    }
    
}
