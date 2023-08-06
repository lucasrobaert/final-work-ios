//
//  MovieResponse.swift
//  Final Work
//
//  Created by Lucas Robaert on 05/08/23.
//

import Foundation


struct MovieResponse: Decodable {
    let results: [MovieDetail]
    
    enum CodingKeys: CodingKey {
        case results
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.results = try container.decode([MovieDetail].self, forKey: .results)
    }
}
